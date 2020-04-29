//
//  BankApi.swift
//  BankingTest
//
//  Created by Sebastian Figueroa on 5/04/20.
//  Copyright © 2020 Sebastian Figueroa. All rights reserved.
//

import Foundation

//Class with informatin about the api





class BankApi{
    
    var code: String = ""
    let client_id:String = "sandbox-sfigueroatest-973acd"
    let secret_id:String = "15d22d98-f7d3-4b58-a46b-57fabb5eefb5"
    let auth_api:String = "auth.truelayer-sandbox.com"
    let redirect_uri:String = "https://console.truelayer-sandbox.com/redirect-page"
    let api:String = "api.truelayer-sandbox.com"
    let prefix:String = "https://"
    let auth_posfix:String = "/connect/token"
    var access_token:String = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjE0NTk4OUIwNTdDOUMzMzg0MDc4MDBBOEJBNkNCOUZFQjMzRTk1MTAiLCJ0eXAiOiJhdCtqd3QiLCJ4NXQiOiJGRm1Kc0ZmSnd6aEFlQUNvdW15NV9yTS1sUkEifQ.eyJuYmYiOjE1ODY5MTQzMDksImV4cCI6MTU4NjkxNzkwOSwiaXNzIjoiaHR0cHM6Ly9hdXRoLnRydWVsYXllci1zYW5kYm94LmNvbSIsImF1ZCI6WyJodHRwczovL2F1dGgudHJ1ZWxheWVyLXNhbmRib3guY29tL3Jlc291cmNlcyIsImRhdGFfYXBpIl0sImNsaWVudF9pZCI6InNhbmRib3gtc2ZpZ3Vlcm9hdGVzdC05NzNhY2QiLCJzdWIiOiJDQ0xBRmJaeGxzaWdNMDVtYzFTRURUQlRQRGhvd0J3VnkxbUlzc2s1ZTdvPSIsImF1dGhfdGltZSI6MTU4NjkxNDMwMywiaWRwIjoibG9jYWwiLCJjb25uZWN0b3JfaWQiOiJtb2NrIiwiY3JlZGVudGlhbHNfa2V5IjoiMjQzMzIxMWNjNGQ1OTkyNWZkMDMzOGU4NDZmOTNjZGViOWQ4NDkzNGM1OTAwOGVjMTdjNDY3NGQ4ZDhiYzJkOSIsInByaXZhY3lfcG9saWN5IjoiRmViMjAxOSIsImNvbnNlbnRfaWQiOiJkM2UxOGNiNy1hNTUyLTQ4YjUtYmNkZC1iZDUxMmQ2ZTAzODgiLCJzY29wZSI6WyJpbmZvIiwiYWNjb3VudHMiLCJjYXJkcyIsInRyYW5zYWN0aW9ucyIsImJhbGFuY2UiLCJkaXJlY3RfZGViaXRzIiwic3RhbmRpbmdfb3JkZXJzIiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbInB3ZCJdfQ.BqHSKPyvyVpaFEIpPtz83gHjeD-JAT9GuH4QxiVMJdy1UNpOoPRIm5nhoMuwtvik0Of2SptlBOBq3hKxA3fWqCGgOPw8bBvzlvwGOqj6uRJYCW64uYa2T3Ehd_LPwgvg6L4QLTlHaboUuWnvddWSbmVrIr69zKyizVSUymagCiqMCg3vXU-0f4h-JZwnAPLMqrxCPVG3X0xKdn4GntjeCvq6-Ni8PAVaVIugGCmfQe2UvOZsCQcWuhIUh-Yfrv_Cg0orpuANJNpKGOs8YoDbyDurPmv4hrJ4J4oSv0LWhMKc-guFLr9YQRCoZ70DlHRzINpjhJYqlhz1CPtKjVFBNg"
    var auth_grant_type:String = "authorization_code"
    
    var accesTokenInfo = AccessTokenJson()
    
    var authRest = RestManager()
    var cardRest = RestManager()
    var Cards:[CardInfo] = []
    
    init(){
        accesTokenInfo.access_token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjE0NTk4OUIwNTdDOUMzMzg0MDc4MDBBOEJBNkNCOUZFQjMzRTk1MTAiLCJ0eXAiOiJhdCtqd3QiLCJ4NXQiOiJGRm1Kc0ZmSnd6aEFlQUNvdW15NV9yTS1sUkEifQ.eyJuYmYiOjE1ODY5MTQzMDksImV4cCI6MTU4NjkxNzkwOSwiaXNzIjoiaHR0cHM6Ly9hdXRoLnRydWVsYXllci1zYW5kYm94LmNvbSIsImF1ZCI6WyJodHRwczovL2F1dGgudHJ1ZWxheWVyLXNhbmRib3guY29tL3Jlc291cmNlcyIsImRhdGFfYXBpIl0sImNsaWVudF9pZCI6InNhbmRib3gtc2ZpZ3Vlcm9hdGVzdC05NzNhY2QiLCJzdWIiOiJDQ0xBRmJaeGxzaWdNMDVtYzFTRURUQlRQRGhvd0J3VnkxbUlzc2s1ZTdvPSIsImF1dGhfdGltZSI6MTU4NjkxNDMwMywiaWRwIjoibG9jYWwiLCJjb25uZWN0b3JfaWQiOiJtb2NrIiwiY3JlZGVudGlhbHNfa2V5IjoiMjQzMzIxMWNjNGQ1OTkyNWZkMDMzOGU4NDZmOTNjZGViOWQ4NDkzNGM1OTAwOGVjMTdjNDY3NGQ4ZDhiYzJkOSIsInByaXZhY3lfcG9saWN5IjoiRmViMjAxOSIsImNvbnNlbnRfaWQiOiJkM2UxOGNiNy1hNTUyLTQ4YjUtYmNkZC1iZDUxMmQ2ZTAzODgiLCJzY29wZSI6WyJpbmZvIiwiYWNjb3VudHMiLCJjYXJkcyIsInRyYW5zYWN0aW9ucyIsImJhbGFuY2UiLCJkaXJlY3RfZGViaXRzIiwic3RhbmRpbmdfb3JkZXJzIiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbInB3ZCJdfQ.BqHSKPyvyVpaFEIpPtz83gHjeD-JAT9GuH4QxiVMJdy1UNpOoPRIm5nhoMuwtvik0Of2SptlBOBq3hKxA3fWqCGgOPw8bBvzlvwGOqj6uRJYCW64uYa2T3Ehd_LPwgvg6L4QLTlHaboUuWnvddWSbmVrIr69zKyizVSUymagCiqMCg3vXU-0f4h-JZwnAPLMqrxCPVG3X0xKdn4GntjeCvq6-Ni8PAVaVIugGCmfQe2UvOZsCQcWuhIUh-Yfrv_Cg0orpuANJNpKGOs8YoDbyDurPmv4hrJ4J4oSv0LWhMKc-guFLr9YQRCoZ70DlHRzINpjhJYqlhz1CPtKjVFBNg"
    }
    
    
    
    
    
    var getCardsUrl:URL? = nil
       
       func setUrls(){
        let stringURL = "https://\(api)/data/v1/cards"
        getCardsUrl = URL(string: stringURL)
        
        if (getCardsUrl != nil ){
            print(getCardsUrl!.absoluteURL);
       }
    }
     
}


extension BankApi{
    

        
      
}







