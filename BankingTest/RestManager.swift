//
//  RestManager.swift
//  BankingTest
//
//  Created by Sebastian Figueroa on 4/04/20.
//  Copyright © 2020 Sebastian Figueroa. All rights reserved.
//

import Foundation


class RestManager{
    
    enum HttpMethod: String {
        case get
        case post
        case put
        case patch
        case delete
    }
    
    enum CustomError: Error {
        case failedToCreateRequest
    }
    
    var requestHttpHeaders = RestEntity()
    var urlQueryParameters = RestEntity()
    var httpBodyParameters = RestEntity()
    var httpBody: Data?
    

    private func prepareRequest(withURL url: URL?, httpBody: Data?, httpMethod: HttpMethod) -> URLRequest? {
        print("Got url in prepare request:")
        print(url)
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        print("Got http method: \(request.httpMethod)")
     
        for (header, value) in requestHttpHeaders.allValues() {
            request.setValue(value, forHTTPHeaderField: header)
        }
     
        request.httpBody = httpBody
        
        print("Got Body and url")
        print(url.absoluteURL)
        
        return request
    }
    
    func makeRequest(toURL url: URL,
                     withHttpMethod httpMethod: HttpMethod,
                     completion: @escaping (_ result: Results) -> Void) {
     
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let targetURL = self?.addURLQueryParameters(toURL: url)
            let httpBody = self?.getHttpBody()
            if( self == nil){
                print("Self is nil")
            }
            print("will prepare request")
            guard let request = self?.prepareRequest(withURL: targetURL, httpBody: httpBody, httpMethod: httpMethod) else {
                completion(Results(withError: CustomError.failedToCreateRequest))
                return
            }
     
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            let task = session.dataTask(with: request) { (data, response, error) in
                completion(Results(withData: data,
                                   response: Response(fromURLResponse: response),
                                   error: error))
            }
            task.resume()
        }
    }

    public func getData(fromURL url: URL, completion: @escaping (_ data: Data?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                guard let data = data else { completion(nil); return }
                completion(data)
            })
            task.resume()
        }
    }
    
}

extension RestManager{
    


    /*

     // Setting a request HTTP header.
     requestHttpHeaders.add(value: "application/json", forKey: "content-type")
      
     // Getting a URL query parameter.
     urlQueryParameters.value(forKey: "firstname")
     
     */
    
    struct RestEntity {
        private var values: [String: String] = [:]

        mutating func add(value: String, forKey key: String) {
    
            values[key] = value
        }

        func value(forKey key: String) -> String? {
            return values[key]
        }

        func allValues() -> [String: String] {
            return values
        }

        func totalItems() -> Int {
            return values.count
        }
        
       mutating func remove() -> Void{
        values.removeAll()
        }
    }
    
    struct Response {
        var response: URLResponse?
        var httpStatusCode: Int = 0
        var headers = RestEntity()
        
        
        init(fromURLResponse response: URLResponse?) {
               guard let response = response else { return }
               self.response = response
               httpStatusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        
               if let headerFields = (response as? HTTPURLResponse)?.allHeaderFields {
                   for (key, value) in headerFields {
                       headers.add(value: "\(value)", forKey: "\(key)")
                   }
               }
           }
    }
    
    
    struct Results {
        
        var data: Data?
        var response: Response?
        var error: Error?
     
        init(withData data: Data?, response: Response?, error: Error?) {
            self.data = data
            self.response = response
            self.error = error
        }
     
        init(withError error: Error) {
            self.error = error
        }
    }
    
    private func getHttpBody() -> Data? {
        guard let contentType = requestHttpHeaders.value(forKey: "Content-Type") else { return nil }
     
        print("Getting body")
        if contentType.contains("application/json") {
            return try? JSONSerialization.data(withJSONObject: httpBodyParameters.allValues(), options: [.prettyPrinted, .sortedKeys])
        } else if contentType.contains("application/x-www-form-urlencoded") {
           
            
            //Sebas F. is very important to add ! because otherwise we always get optional
            
            let bodyString = httpBodyParameters.allValues().map { "\($0)=\(String(describing: ($1).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))" }.joined(separator: "&")
            let res = bodyString.data(using: .utf8)
            
            if let res = res {
                if let str = String(data: res, encoding: .utf8){
                    print (str)
                }
            }
            print("Got body")
            return res
            
            
        } else {
            return httpBody
        }
    }
    
    private func addURLQueryParameters(toURL url: URL) -> URL {
        if urlQueryParameters.totalItems() > 0 {
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return url }
            var queryItems = [URLQueryItem]()
            for (key, value) in urlQueryParameters.allValues() {
                let item = URLQueryItem(name: key, value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
                queryItems.append(item)
            }
     
            urlComponents.queryItems = queryItems
     
            guard let updatedURL = urlComponents.url else { return url }
            return updatedURL
        }
     
        return url
    }
    
    
    

}



extension RestManager.CustomError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .failedToCreateRequest: return NSLocalizedString("Unable to create the URLRequest object", comment: "")
        }
    }
}
