//
//  AccountsViewController.swift
//  BankingTest
//
//  Created by Sebastian Figueroa on 29/04/20.
//  Copyright © 2020 Sebastian Figueroa. All rights reserved.
//

import UIKit

class AccountsViewController: UITableViewController {
    
    var accountsApi = AccountsApi()
    var accounts: [AccountInfo] = []
    var token: String = ""
    
    func GotAccounts(accounts: Any?){
        
        if let accounts = accounts{
            let accounts = accounts as! [AccountInfo]
            self.accounts = accounts
            print("got accounts")
            self.tableView.reloadData()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = PersistentToken.getToken(){
        accountsApi.setAccesToken(token: token)
            
            accountsApi.setCompletion { [weak self](accounts) in
                self?.GotAccounts(accounts:accounts)
            }
            
            accountsApi.getAccounts()
        }
        
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return accounts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountViewCell", for: indexPath) as? AccountViewCell else {
            fatalError("The dequeued cell is not an instance of AccoutnViewCell.")
        }

        // Configure the cell...
        cell.setFromAccount(account: accounts[indexPath.row])

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
