//
//  AccountTableViewCell.swift
//  BankingTest
//
//  Created by Sebastian Figueroa on 29/04/20.
//  Copyright © 2020 Sebastian Figueroa. All rights reserved.
//

import UIKit
import WebKit

class AccountViewCell: UITableViewCell {
    
    @IBOutlet var AccountName: UILabel!
    @IBOutlet var AccountType: UILabel!
    @IBOutlet var AccountNumber: UILabel!
    @IBOutlet var AccountSortCode: UILabel!
    @IBOutlet var AccountCurrency: UILabel!
    @IBOutlet var AccountSwift: UILabel!
    @IBOutlet var AccountId: UILabel!
    @IBOutlet var ProviderName: UILabel!
    @IBOutlet var logo: WKWebView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFromAccount(account:AccountInfo){
        
        AccountName.text = account.display_name
        AccountType.text = account.account_type
        AccountNumber.text = account.account_number.number
        
        AccountSwift.text = account.account_number.swift_bic
        
        AccountSortCode.text =
            account.account_number.sort_code
        
        AccountCurrency.text = account.currency
        
        AccountId.text = account.account_id
        
        ProviderName.text = account.provider.display_name
        
        
        logo.loadHTMLString(LogoHelper.getHtmlLogo(string: account.provider.logo_uri),baseURL: nil)
        
        let url = URL(string: account.provider.logo_uri)
        if let url = url{
            print("loding logo in" + url.absoluteString)
            //logo.load(URLRequest(url:url))

        }

        
        
    }

}
