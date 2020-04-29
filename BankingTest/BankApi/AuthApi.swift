//
//  AuthApi.swift
//  BankingTest
//
//  Created by Sebastian Figueroa on 14/04/20.
//  Copyright © 2020 Sebastian Figueroa. All rights reserved.
//

import Foundation

class AuthApi{
    
    var  BankInfo = BankApiInfo();
    
    var completed:((_ token:String)->())? = nil
    
    var failed:(()->())? = nil
    
    init(completion:((_ token:String)->())?){
        completed = completion;
    }
    
    init(){
           completed = nil;
       }
    
    func setFailed(failed: (()->())?){
        if let failed = failed {
            self.failed = failed
        }
        
    }
    
    var authRest = RestManager();
    private var code:String = "";
    
    var accesTokenInfo = AccessTokenJson()
    
    func setCode(code: String){
        self.code = code
    }
    
    func getCode() -> String? {
        return self.code;
    }
    
    func authenticatedWithCompletion(completion:((_ token:String)->())?){
        completed = completion
        authenticate()
    }
    
    func setCompletion(completion:((_ token:String)->())?){
        completed = completion;
    }
    
    func clearRest(){
        authRest.httpBodyParameters = RestManager.RestEntity()
        authRest.requestHttpHeaders = RestManager.RestEntity()
    }
    
    func setAuthRest(){
        
        authRest.requestHttpHeaders.add(value: "application/x-www-form-urlencoded", forKey: "Content-Type")
               authRest.httpBodyParameters.add(value: BankInfo.auth_grant_type as String, forKey: "grant_type")
               authRest.httpBodyParameters.add(value: BankInfo.client_id as String, forKey: "client_id")
               authRest.httpBodyParameters.add(value: BankInfo.secret_id as String, forKey: "client_secret")
               authRest.httpBodyParameters.add(value: BankInfo.redirect_uri as String, forKey: "redirect_uri")
               authRest.httpBodyParameters.add(value: code as String, forKey: "code")
        
    }
    
    func setRenewRest(){
        
        authRest.requestHttpHeaders.add(value: "application/x-www-form-urlencoded", forKey: "Content-Type")
        authRest.httpBodyParameters.add(value: BankInfo.auth_refresh_token as String, forKey: "grant_type")
        authRest.httpBodyParameters.add(value: self.accesTokenInfo.refresh_token, forKey:"refresh_token")
                    authRest.httpBodyParameters.add(value: BankInfo.client_id as String, forKey: "client_id")
                    authRest.httpBodyParameters.add(value: BankInfo.secret_id as String, forKey: "client_secret")
        
        print("Refresh token" + self.accesTokenInfo.refresh_token)
                   // authRest.httpBodyParameters.add(value: BankInfo.redirect_uri as String, forKey: "redirect_uri")
                    
        
        
        
    }
    
    func authenticate(){
        
        guard let url = URL(string: BankInfo.prefix + BankInfo.auth_api + BankInfo.auth_posfix) else { return }
        
        clearRest()
        setAuthRest()
        
        authRest.makeRequest(toURL: url, withHttpMethod: .post) { [weak self ](results) in
                
                //print("Got results")
                if let data: Data = results.data { // received from a network request, for example
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    //print(json)
                
                    if let access: AccessTokenJson = try? JSONDecoder().decode(AccessTokenJson.self, from: data){
                        
                          self?.accesTokenInfo = access;

                        DispatchQueue.main.async { [weak self] in
                            
                            if let completed = self?.completed {
                                print("Auth completed")
                                if let accessToken = self?.accesTokenInfo.access_token {
                                    completed(accessToken);
                                    
                                    
                                }
                            }
                        }
                        print("got token")
                        return
                    }
                }
            
                print("failed")
                DispatchQueue.main.async { [weak self] in
                     if let failed = self?.failed{
                        failed()
                }
                
            }
            
            }
            
    }
    
    
    func renewAccesToken(){
        
         guard let url = URL(string: BankInfo.prefix + BankInfo.auth_api + BankInfo.auth_posfix) else { return }
 
        clearRest()
        setRenewRest()
        
        
        authRest.makeRequest(toURL: url, withHttpMethod: .post) { [weak self ](results) in
                
                //print("Got results")
                if let data: Data = results.data { // received from a network request, for example
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                
                    if let access: AccessTokenJson = try? JSONDecoder().decode(AccessTokenJson.self, from: data){
                        
                          self?.accesTokenInfo = access;

                        DispatchQueue.main.async { [weak self] in
                            
                            if let completed = self?.completed {
                                print("Auth completed")
                                if let accessToken = self?.accesTokenInfo.access_token {
                                    completed(accessToken);
                                    
                                    
                                }
                            }
                        }
                        print("Got")
                        return
                    }
                }
            
                DispatchQueue.main.async { [weak self] in
                     print("failed")
                     if let failed = self?.failed{
                        failed()
                }
                
            }
            
            }
        
    }
    
}
    
