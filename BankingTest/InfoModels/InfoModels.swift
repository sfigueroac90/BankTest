//
//  CardInfo.swift
//  BankingTest
//
//  Created by Sebastian Figueroa on 14/04/20.
//  Copyright © 2020 Sebastian Figueroa. All rights reserved.
//

import Foundation


class AccountInfo:Decodable{
    var account_id:String = ""
    var account_number = AccountNumber()
    var account_type:String = ""
    var currency:String = ""
    var display_name:String = ""
    var provider = Provider()
    var update_timestamp: String = ""
    init(){}
    
    func fromDict(from dict:Dictionary<String,Any>){
        
        if let str = dict["account_id"] {
                   self.account_id = str as! String
               }
        
        if let str = dict["account_number"] {
            let provDict = str as! [String:Any]
            account_number.fromDict(from: provDict)
               }
        
        if let str = dict["currency"] {
            self.currency = str as! String
        }
        
        if let str = dict["display_name"] {
            self.display_name = str as! String
        }
        
        if let str = dict["update_timestamp"] {
            self.update_timestamp = str as! String
        }
        
        if let str = dict["provider"] {
                   let provDict = str as! [String:Any]
                   provider.fromDict(from: provDict)
                      }

    }
    
}

class AccountBalanceInfo:Decodable{
    
    /*
     {
       "results": [
         {
           "currency": "GBP",
           "available": 1161.2,
           "
     ": 1161.2,
           "overdraft": 1000,
           "update_timestamp": "2017-02-07T17:33:30.001222Z"
         }
       ]
     }
     */
    
    var currency:String = ""
    var available:String = ""
    var overdraft:String = ""
    var update_timestamp:String = ""
    
    func fromDict(from dict:Dictionary<String,Any>){
        
        if let str = dict["currency"]{
            self.currency = str as! String
        }
        
        if let str = dict["available"]{
            self.available = str as! String
        }
        
        if let str = dict["overdraft"]{
            self.overdraft = str as! String
        }
        
        if let str = dict ["update_timestamp"]{
            self.update_timestamp = str as! String
        }
        
    }
    

}

class Transaction:Decodable{
    
    /*
     {
       "results": [
         {
           "transaction_id": "03c333979b729315545816aaa365c33f",
           "timestamp": "2018-03-06T00:00:00",
           "description": "GOOGLE PLAY STORE",
           "amount": -2.99,
           "currency": "GBP",
           "transaction_type": "DEBIT",
           "transaction_category": "PURCHASE",
           "transaction_classification": [
             "Entertainment",
             "Games"
           ],
           "merchant_name": "Google play",
           "running_balance": {
             "amount": 1238.60,
             "currency": "GBP"
           },
           "meta": {
             "bank_transaction_id": "9882ks-00js",
             "provider_transaction_category": "DEB"
           }
         },
         {
           "transaction_id": "3484333edb2078e77cf2ed58f1dec11e",
           "timestamp": "2018-02-18T00:00:00",
           "description": "PAYPAL EBAY",
           "amount": -25.25,
           "currency": "GBP",
           "transaction_type": "DEBIT",
           "transaction_category": "PURCHASE",
           "transaction_classification": [
             "Shopping",
             "General"
           ],
           "merchant_name": "Ebay",
           "meta": {
             "bank_transaction_id": "33b5555724",
             "provider_transaction_category": "DEB"
           }
         }
       ]
     }
     */
    
    var transaction_id:String = ""
    var timestamp:String = ""
    var description:String = ""
    var amount: String
    var currency:String = "GBP"
    var transaction_type:String = ""
    var transaction_category:String = "PURCHASE"
    var transaction_classification:[String] = []
    var merchant_name:String = "Ebay"
    var meta: [String:String] = [:]
    
    func fromDict(from dict:Dictionary<String,Any>){
        
        if let str = dict["transaction_id"] {
            self.transaction_id = str as! String
        }
        
        if let str = dict["timestamp"]{
            self.timestamp = str as! String
        }
        
        if let str = dict["description"]{
            self.description = str as! String
        }
        
        if let str = dict["description"]{
            self.description = str as! String
        }
        
        if let str = dict["currency"]{
            self.currency = str as! String
        }
        
        if let str = dict["amount"]{
            self.amount = str as! String
        }
        
        if let str = dict["transaction_type"]{
            self.transaction_type = str as! String
        }
        
        if let str = dict["transaction_category"]{
            self.transaction_category = str as! String
        }
        
        if let str = dict["transaction_classification"]{
            self.transaction_classification = str as! [String]
        }
        
        if let str = dict["merchant_name"]{
            self.merchant_name = str as! String
        }
        
        if let meta = dict["meta"] {
            self.meta = meta as! [String:String]
            
        }
        
    }
    
}

class CardInfo:Decodable{
    
    var account_id: String = "";
    var card_network: String = "";
    var card_type: String = "";
    var currency: String = "";
    var display_name: String = "";
    var name_on_card: String = "";
    var partial_card_number: String = "";
    var update_timestamp: String = "";
    var provider: Provider = Provider()
    
    init(){}
    
    func fromDict(from dict:Dictionary<String,Any>){
        
        if let str = dict["account_id"] {
            self.account_id = str as! String
        }
        if let str = dict["card_network"] {
            self.card_network = str as! String
        }
        if let str = dict["card_type"] {
            self.card_type = str as! String
        }
        if let str = dict["currency"] {
            self.currency = str as! String
            
        }
        if let str = dict["display_name"] {
            self.display_name = str as! String
            
        }
        if let str = dict["name_on_card"] {
            self.name_on_card = str as! String
            
        }
        if let str = dict["partial_card_number"] {
            self.partial_card_number = str as! String
            
        }
        if let str = dict["update_timestamp"] {
            self.update_timestamp = str as! String
            
        }
        
        if let prov = dict["provider"]  {
             
            let provDict = prov as! [String:Any]
            provider.fromDict(from: provDict)
        }
        
       
    }
    
}

class Provider: Decodable{
  
    var display_name:String = ""
    var logo_uri:String = "";
    var provider_id:String = "";
    
    func fromDict(from dict:Dictionary<String,Any>){
        
        let provDict = dict 
                   print(type(of: provDict))
                   print(provDict)
                   
            if let display_name = provDict["display_name"]  {
                self.display_name =  display_name as! String
                   }
                   if let logo_uri = provDict["logo_uri"] {
                        self.logo_uri =  logo_uri as! String
                   }
                   
                   if let prov_id = provDict["logo_uri"] {
                       self.provider_id =  prov_id as! String
                   }
        
    }
    
}

class AccountNumber: Decodable{
    var number:String=""
    var sort_code:String=""
    var swift_bic:String=""
    
    func fromDict(from dict:Dictionary<String,Any>){
        
        if let str = dict["number"] {
                   self.number = str as! String
               }
        
        if let str = dict["sort_code"] {
                          self.sort_code = str as! String
                      }
        
        if let str = dict["swift_bic"] {
            self.swift_bic = str as! String
        }
        
    }
}

class AccessTokenJson:Decodable {
       
    var access_token:String = ""
    var expires_in: Int = 10
    var refresh_token: String = ""
    var scope: String = ""
    var token_type: String = ""
          
}
