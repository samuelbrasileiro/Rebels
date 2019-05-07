//
//  PlayersTableViewController.swift
//  Rebels
//
//  Created by Samuel on 05/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit


class PlayersTableViewController: UITableViewController {
    var players = [Player]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = true
        super.viewWillAppear(animated)
        
        // Add a background view to the table view
        let imageView = UIImageView(image: UIImage(named: "starsBackground"))
        imageView.contentMode = .scaleAspectFill
        self.tableView.backgroundView = imageView
        tableView.backgroundColor = .black
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = UIColor(red: 1, green: 1, blue: 0.1, alpha: 0.5)
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PlayersTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlayersTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)

        //let conversa = conversas[indexPath.row]
        //cell.data.text = String(conversa.data)
        //cell.sessaoID.text = String(conversas.count - indexPath.row)
        //cell.amiImage.image = UIImage(named: image)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("hihi")
            //conversas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //if segue.identifier == "conversaDetalhes"{
            
           // if let _ = segue.destination as? UIViewController {
                
                //let selectCell = tableView.indexPathForSelectedRow?.row
                //let conversa = conversas[selectCell!]
                
            //}
       // }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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

}
