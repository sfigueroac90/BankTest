//
//  AccountsApi.swift
//  BankingTest
//
//  Created by Sebastian Figueroa on 19/04/20.
//  Copyright © 2020 Sebastian Figueroa. All rights reserved.
//

import Foundation


class AccountApiInfo:BankApiInfo{
    
    var accountsURL:URL?
    
    override init(){
        
        super.init()
        let stringURL = "https://\(self.api)/data/v1/accounts"
        accountsURL = URL(string: stringURL)!
        
    }
}

class AccountsApi{
    
    var  accountApiInfo = AccountApiInfo();
    var completed:((Any?)->())? = nil
    var accounts:[AccountInfo]=[]
    
    private var accessToken = ""
    
    var accountRest = RestManager()
    
    init(completion:((Any?)->())?){
        completed = completion;
    }
    
    init(){
        completed = nil;
    }
    
    func setCompletion(completion:((Any?)->())?){
        completed = completion;
    }
    
    func setAccesToken(token:String){
        self.accessToken = token;
    }
    
    func clearRest(){
        accountRest.httpBodyParameters = RestManager.RestEntity()
        accountRest.requestHttpHeaders = RestManager.RestEntity()
    }
    
    func setHeader(){
        let bearer = "Bearer \(accessToken)"
        accountRest.requestHttpHeaders.add(value: bearer, forKey: "Authorization")
        accountRest.requestHttpHeaders.add(value: "keep-alive", forKey: "Connection")
    }
    
    class AccountResult:Decodable{
        var result: [AccountInfo]=[]
        var status:String = ""
    }
    
    func getAccounts(){
        clearRest();
        setHeader();
        accountRest.makeRequest(toURL: accountApiInfo.accountsURL!, withHttpMethod: .get){ [weak self ](results) in
                
                if let data: Data = results.data { // received from a network request, for
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    
                    if let dictionary = json as? [String:Any]{
                        
                        if let accountsData = dictionary["results"] {
                            let accountsData = accountsData as! [[String:Any]]
                            self?.accounts = []
                        
                            for accountData in accountsData {
                                
                                if let accountDict = accountData as [String:Any]?{
                                    
                                     let accountInfo = AccountInfo();
                                                      accountInfo.fromDict(from: accountDict)
                                    self?.accounts.append(accountInfo)
                                }
                            }
                        
                        
                            DispatchQueue.main.async {
                                [weak self]() in
                                if let completed:(Any?)->() = self?.completed{
                                                           completed(self?.accounts)
                                                                                  }
                                   
                                                   }

                            }
                            
                                                               
                    print(json)
                        
                    }

                }
           }
    }
}


