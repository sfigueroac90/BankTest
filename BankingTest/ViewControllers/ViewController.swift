//
//  ViewController.swift
//  BankingTest
//
//  Created by Sebastian Figueroa on 31/03/20.
//  Copyright © 2020 Sebastian Figueroa. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet var logo: UIImageView!
    
    @IBOutlet var logoWB: WKWebView!
    
    var gettingCode:Bool = false;
    
     var auth = AuthApi();
    
    func failed(){
           
        gettingCode = true;
        
        pushLoginViewController()

       }
    
    func pushLoginViewController(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        
        
        //It is better to use push because to control navigation
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func onClickButton(_ sender: UIButton) {
        print("Button Clicked")
        
        //pushLoginViewController()
        
        refreshAndEnter()
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MainViewController Loaded")
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        
        
    }
    
    
    func authenticated(token:String){
        
        print("Got token")
        
        PersistentToken.saveToken(token: token)
        PersistentToken.saveRefreshToken(refreshToken: auth.accesTokenInfo.refresh_token)
        pushDashController()
        
    }
    
    func pushDashController(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashBoardController")
        if let vc = vc{
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        if (gettingCode){
            if let code = PersistentToken.getCode(){
                gettingCode = false
                auth.setCode(code: code)
                auth.authenticate()
            }
        }
            
           
        
    }

        
        func refreshAndEnter(){
            
            if let refresh = PersistentToken.getRefreshToken(){
                           auth.accesTokenInfo.refresh_token = refresh
                           print("got refresh")
                       }
                       
                       
                       auth.setFailed(failed: {[weak self]() in
                           self?.failed()
                       })
                       
                       auth.setCompletion(completion: {[weak self](token) in
                       self?.authenticated(token:token)})
                       
                       auth.renewAccesToken()
                       
                   }
            
        

}

