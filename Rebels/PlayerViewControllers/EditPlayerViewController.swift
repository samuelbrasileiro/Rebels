//
//  EditPlayerViewController.swift
//  Rebels
//
//  Created by Samuel on 07/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit
import CoreData
class EditPlayerViewController: BasePlayerViewController {

    override func viewDidLoad(){
        super.viewDidLoad()
        self.image.image = player.image
        self.nome.text = player.name
        self.clickButton.setTitle("Salvar", for: .normal)
        self.trashButton.isHidden = false
        
        self.clickButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        self.trashButton.addTarget(self, action: #selector(trash), for: .touchUpInside)
        
        self.image.layer.cornerRadius = self.image.bounds.width / 2
        self.image.contentMode = .scaleAspectFill
        self.image.layer.masksToBounds = true        
    }
    
    @objc func trash() {
        players.remove(at: index!)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func save() {
        if nome.text == ""{
            createAndShowAlert(message: "É necessário que o jogador tenha um nome e uma foto.")
            
        }
        
        else{
            //LEMBRAR DE REFAZER
            var nameExists = false
            for player in players{
                if self.nome.text == player.name && players[index!].name != player.name{
                    nameExists = true
                }
            }
            if nameExists{
                 createAndShowAlert(message: "Já existe um jogador com este nome, escolha outro.")
            }
            else{
                
                players[index!] = Player(name: self.nome.text ?? player.name, image: self.image.image ?? player.image!)
                let context = AppDelegate.viewContext
                
                let personRequest = NSFetchRequest<Person>(entityName: "Person")
                personRequest.predicate = NSPredicate(format: "tag = %i", index!)
                
                let people = try? context.fetch(personRequest)
            
                people![0].name  = self.nome.text ?? player.name
                people![0].image = self.image.image?.pngData() ?? player.image!.pngData()
                
                do{
                    try context.save()
                } catch{
                    print(error)
                    fatalError()
                }
                navigationController?.popViewController(animated: true)
            }
        }
        
    }

}
