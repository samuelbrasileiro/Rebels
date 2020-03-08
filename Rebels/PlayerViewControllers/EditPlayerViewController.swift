//
//  EditPlayerViewController.swift
//  Rebels
//
//  Created by Samuel on 07/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit

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
        if(nome.text == ""){
            let alert = UIAlertController(title: "Atenção", message: "É necessário que o jogador tenha um nome e uma foto.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            action.setValue(UIColor.yellow, forKey: "titleTextColor")
            self.present(alert, animated: true)
        }
        else{
            players[index!] = Player(name: self.nome.text ?? player.name, image: self.image.image ?? player.image!)
            navigationController?.popViewController(animated: true)
        }
        
    }

}
