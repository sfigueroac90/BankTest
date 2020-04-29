//
//  Card.swift
//  BankingTest
//
//  Created by Sebastian Figueroa on 28/04/20.
//  Copyright © 2020 Sebastian Figueroa. All rights reserved.
//

import UIKit
import WebKit

class CardViewCell: UITableViewCell {
    
    @IBOutlet var accountId: UILabel!
    @IBOutlet var networkLabel: UILabel!
    @IBOutlet var providerName: UILabel!
    @IBOutlet var CurrencyLabel: UILabel!
    @IBOutlet var CardTypeLabel: UILabel!
    @IBOutlet var nameOnCardLabel: UILabel!
    @IBOutlet var CardNameLabel: UILabel!
    @IBOutlet var logo: WKWebView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFromCard(card:CardInfo){
        
        print("setFromCard")
        accountId.text = card.account_id
        networkLabel.text = card.card_network
        providerName.text = card.provider.display_name
        
        CurrencyLabel.text = card.currency
        
        nameOnCardLabel.text = card.name_on_card
        
        CardNameLabel.text = card.display_name
        logo.loadHTMLString(LogoHelper.getHtmlLogo(string: card.provider.logo_uri),baseURL: nil)
        
    }

}
