//
//  LogoHelper.swift
//  BankingTest
//
//  Created by Sebastian Figueroa on 29/04/20.
//  Copyright © 2020 Sebastian Figueroa. All rights reserved.
//

import Foundation

class LogoHelper{
    
    class func getHtmlLogo(string:String) -> String{
        
        let prefix = "<meta name='viewport' content='width=device-width, initial-scale=1.0'><body><img width='100%' height='100%' src='"
        
        let sufix = "' style='display: block; margin-left: auto; margin-right: auto; width: 100%;'/></body>"
        
        
        return prefix + string + sufix
    
    }
    
}
