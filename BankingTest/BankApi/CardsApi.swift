//
//  CardsApi.swift
//  BankingTest
//
//  Created by Sebastian Figueroa on 14/04/20.
//  Copyright © 2020 Sebastian Figueroa. All rights reserved.
//

import Foundation

class CardApiInfo:BankApiInfo{
    
    var cardsUrl:URL?
    
    override init(){
        
        super.init()
        let stringURL = "https://\(self.api)/data/v1/cards"
        cardsUrl = URL(string: stringURL)!
        
    }
}


class CardsApi{
    
    var  cardApiInfo = CardApiInfo();
    var completed:((Any?)->())? = nil
    
    private var accessToken = ""
    
    var cards:[CardInfo]=[]
    
    var cardRest = RestManager()
    
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
        cardRest.httpBodyParameters = RestManager.RestEntity()
        cardRest.requestHttpHeaders = RestManager.RestEntity()
    }
    
    func setHeader(){
        let bearer = "Bearer \(accessToken)"
        cardRest.requestHttpHeaders.add(value: bearer, forKey: "Authorization")
        cardRest.requestHttpHeaders.add(value: "keep-alive", forKey: "Connection")
    }
    
    func cardBalanceHeader(){
        
    }
    
    func getCardBalance(){
        clearRest()
        
        
    }
    
    
    
    func getCards(){
        clearRest();
        setHeader();
        cardRest.makeRequest(toURL: cardApiInfo.cardsUrl!, withHttpMethod: .get){ [weak self ](results) in
                
                if let data: Data = results.data { // received from a network request, for
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    if let dictionary = json as? [String:Any]{
                       // print (dictionary["results"])
                        if let cardsData = dictionary["results"]{
                            let cardsData = cardsData as! [[String:Any]]
                        //var cards:[CardInfo]=[]
                        self?.cards = []
                        for cardData in cardsData {
                            if let cardDict = cardData as [String:Any]?{
                                let cardInfo = CardInfo();
                                self?.cards.append(cardInfo)
                                cardInfo.fromDict(from: cardDict)
                                
                            }
                        }
                            DispatchQueue.main.async{[weak self] () in
                                if let completed:(Any?)->() = self?.completed{
                                completed(self?.cards)
                                                           }
                            
                            }
                            

                        }
                        
                                            }
                }
           }
    }
}
