//
//  PersistentToken.swift
//  BankingTest
//
//  Created by Sebastian Figueroa on 28/04/20.
//  Copyright © 2020 Sebastian Figueroa. All rights reserved.
//

import Foundation


class PersistentToken{
    
    static let tokenKeyName = "BankToken"
    static let refreshTokenKeyName = "RefreshToken"
    
    static let authCodeName = "authCode"
   
    class func getToken()->String?{
        
        let token = UserDefaults.standard.string(forKey:tokenKeyName)
        return token
    }
        
    class func saveToken(token:String?){
        if let token = token {
            UserDefaults.standard.set(token, forKey:tokenKeyName)
                return
        }else {
            print("Token not saved")
        }
    }
    
    class func saveCode(code:String?){
        if let code = code{
            UserDefaults.standard.set(code, forKey: authCodeName)
        }
    }
    
    class func getCode()->String?{
       let code = UserDefaults.standard.string(forKey:authCodeName)
        return code
    }
    
    class func saveRefreshToken(refreshToken:String?){
        if let refreshToken = refreshToken {
            UserDefaults.standard.set( refreshToken,forKey: refreshTokenKeyName)
        }
    }
    
    class func getRefreshToken()->String?{
        let token = UserDefaults.standard.string(forKey:refreshTokenKeyName)
               return token
    }
    
}
