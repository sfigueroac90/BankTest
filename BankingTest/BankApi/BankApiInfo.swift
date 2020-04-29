//
//  BankApiInfo.swift
//  BankingTest
//
//  Created by Sebastian Figueroa on 14/04/20.
//  Copyright © 2020 Sebastian Figueroa. All rights reserved.
//

import Foundation

class BankApiInfo{
    
    let client_id:String = "sandbox-sfigueroatest-973acd"
    let secret_id:String = "15d22d98-f7d3-4b58-a46b-57fabb5eefb5"
    let auth_api:String = "auth.truelayer-sandbox.com"
    let redirect_uri:String = "https://console.truelayer-sandbox.com/redirect-page"
    let api:String = "api.truelayer-sandbox.com"
    let prefix:String = "https://"
    let auth_posfix:String = "/connect/token"
    var auth_grant_type:String = "authorization_code"
    var auth_refresh_token:String = "refresh_token"
    
}


