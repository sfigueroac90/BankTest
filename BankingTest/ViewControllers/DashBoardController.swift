//
//  DashBoardController.swift
//  BankingTest
//
//  Created by Sebastian Figueroa on 1/04/20.
//  Copyright © 2020 Sebastian Figueroa. All rights reserved.
//

import UIKit

class DashBoardController: UIViewController {
    
    let identifier: String = "DashBoardController"
    
    var code: String = "";
    
   
    var cardsApi = CardsApi();
    var accountsApi = AccountsApi();
    
    var accessToken="";
    
   // var ba = BankApi();
    
    @IBAction func onCardsClicked(_ sender: UIButton) {
        pushCardController()
                //cardsApi.getCards();
    }
    
    @IBAction func onAccountsClicked(_ sender: UIButton) {
        pushAccountController()
    }
    
    @IBAction func onTransactionsClicked(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let token = PersistentToken.getToken(){
            
            cardsApi.setCompletion(completion: { (cards) in
                       self.GotCards(cards:cards)
                   })
                   
                   accountsApi.setCompletion { (accounts) in
                       self.GotAccounts(accounts: accounts)
                   }
            cardsApi.setAccesToken(token: token)
            accountsApi.setAccesToken(token: token)
        } else {
            print ("There is not token")
        }
        
        //Auth
    
    }
    
    func authenticated(token: String){
        print("Authentication has been done from dashboard with token \(token)" );
        accessToken = token
        cardsApi.setAccesToken(token: token)
        accountsApi.setAccesToken(token: token)
    }
    
    
    func GotCards(cards:Any?){
        print("Got cards")
        if let cards = cards{
            print(cards)
        }
    }
    
    func GotAccounts(accounts:Any?){
        print("Got Accounts")
        if let accounts = accounts{
            for account in accounts as! [AccountInfo]{
                print(account.account_number.swift_bic)
            }
        }
        
    }
    
    func pushCardController(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CardViewController")
        if let vc = vc{
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    func pushAccountController(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountsViewController")
        if let vc = vc{
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
 


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
