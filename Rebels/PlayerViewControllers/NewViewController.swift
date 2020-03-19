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
                
                
                let context = AppDelegate.viewContext
                
                let person = Person(context: context)
                
                person.tag = Int32(players.count)
                person.name  = self.nome.text ?? ""
                //person.image = self.image.image!
                if let imageData = self.image.image?.pngData() {
                        person.image = imageData
                    }
                do{
                    try context.save()
                } catch{
                    fatalError("Failed to save players: \(error)")
                }
                let newPlayer = Player(name: self.nome.text ?? "", image: self.image.image!)
                players.append(newPlayer)
                
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
