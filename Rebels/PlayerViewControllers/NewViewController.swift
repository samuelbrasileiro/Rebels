//
//  NewPlayerViewController.swift
//  Rebels
//
//  Created by Samuel on 07/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit

class NewPlayerViewController: BasePlayerViewController {

    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationItem.title = "Novo Jogador"
        
        self.trashButton.isHidden = true
        
        self.clickButton.setTitle("Adicionar", for: .normal)
        self.clickButton.addTarget(self, action: #selector(add), for: .touchUpInside)
    }
    
    
    @objc func add() {
        let newPlayer = Player(name: self.nome.text ?? "", image: self.image.image!)
        players.append(newPlayer)
        navigationController?.popViewController(animated: true)
        
    }
    
}
