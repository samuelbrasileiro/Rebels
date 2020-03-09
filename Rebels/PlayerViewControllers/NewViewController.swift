//
//  NewPlayerViewController.swift
//  Rebels
//
//  Created by Samuel on 07/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit
import CoreData
class NewPlayerViewController: BasePlayerViewController {

    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationItem.title = "Novo Jogador"
        
        self.trashButton.isHidden = true
        
        self.clickButton.setTitle("Adicionar", for: .normal)
        self.clickButton.addTarget(self, action: #selector(add), for: .touchUpInside)
    }
    
    
    @objc func add() {
        if(self.nome.text == "" ||  !didChangeImage!){
             createAndShowAlert(message: "É necessário que o jogador tenha um nome e uma foto.")
        }
        else{
            //LEMBRAR DE REFAZER
            var nameExists = false
            for player in players{
                if self.nome.text == player.name{
                    nameExists = true
                }
            }
            if nameExists{
                 createAndShowAlert(message: "Já existe um jogador com este nome, escolha outro.")
            }
            else{
//                let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//                managedObjectContext.reset()
//                let playerMO = NSEntityDescription.insertNewObject(forEntityName:"PlayersDM",
//                                                                           into: managedObjectContext) as! PlayersMO
                let newPlayer = Player(name: self.nome.text ?? "", image: self.image.image!)
                players.append(newPlayer)
//                playerMO.players = players
//                do {
//                    try managedObjectContext.save()
//                } catch {
//                    fatalError("Failure to save context: \(error)")
//                }
//                print("cleito")
//                let playersFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayersDM")
//
//                do {
//                    let fetchedPlayers = try managedObjectContext.fetch(playersFetch) as! [PlayersMO]
//                    print(fetchedPlayers.count)
//                    if let players = fetchedPlayers[fetchedPlayers.count-1].players{
//                        print(players[0].name)
//                    }
//                    else{
//                        print("blue")
//                    }
//                } catch {
//                    fatalError("Failed to fetch players: \(error)")
//                }
                
                
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
