//
//  LoginViewController.swift
//  BankingTest
//
//  Created by Sebastian Figueroa on 31/03/20.
//  Copyright © 2020 Sebastian Figueroa. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {

    @IBOutlet var LoginWebView: WKWebView!
    
    var gotConsole: Bool = false
    var lastTitle: String = ""
    let TokenTitle: String = "TrueLayer | Console"
    var code: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initLogin()

    }
    
    
    func initLogin(){
        
        print("Loaded Login")
                              self.navigationController?.setNavigationBarHidden(false, animated: true)

                              if let url = URL(string: "https://auth.truelayer-sandbox.com/?response_type=code&client_id=sandbox-sfigueroatest-973acd&scope=info%20accounts%20balance%20cards%20transactions%20direct_debits%20standing_orders%20offline_access&redirect_uri=https://console.truelayer-sandbox.com/redirect-page&providers=uk-ob-all%20uk-oauth-all%20uk-cs-mock"
                      ) {
                                  let request = URLRequest(url: url)
                                  LoginWebView.load(request)
                              }
                              
                              //Set observer for load progress
                              LoginWebView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
                              
                              
                              //Set observer for title
                              LoginWebView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        
    }
    
    
    //https://stackoverflow.com/questions/41421686/get-the-value-of-url-parameters
    func getQueryStringParameter(url: String, param: String) -> String? {
      guard let url = URLComponents(string: url) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let progress = Float(LoginWebView.estimatedProgress);
            print(progress)
            
            if(progress == 1.0 && lastTitle == TokenTitle){
               
            }
        }
        if keyPath == "title" {
            if let title = LoginWebView.title {
                
                print(title)
                lastTitle = title
                if( title == TokenTitle ){
                    //Esto debería hacerse inmediatamente en el redireccionamiento
                    if let url = LoginWebView.url?.absoluteString{
                        let got_code = getQueryStringParameter(url: url, param: "code")
                        print("Got code")
                        print(code as Any);
                       
                        if let stringCode = got_code as String? {
                            
                            if ( stringCode.count > 0){
                                code = stringCode
                                PersistentToken.saveCode(code: code)
                                self.navigationController?.popToRootViewController(animated: true)

                               
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    
    func pushDashController(code: String){
        
        let vc = DashBoardController();
        vc.code = code
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func pushDashController(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashBoardController")
        if let vc = vc{
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    
    
    func getToken(){
        
        //class
        LoginWebView.evaluateJavaScript("document.getElementsByClassName('sc-cIsjWt iVLSNV sc-jeCdPy geHdnK').length") { (result, error) in
            print("After evaluate")
            if let error = error {print(error)}
            
            if let result = result{
                print(result)
            }
            
            
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

    override func viewWillAppear(_ animated: Bool) {
        
        //Config auth
      
               
    }
}
