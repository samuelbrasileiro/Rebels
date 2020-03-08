//
//  BaseGameViewController.swift
//  Rebels
//
//  Created by Samuel on 10/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit

class BaseGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "cancel"), style: .done, target: self, action: #selector(exitAlert)),animated: true)
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: Pontuation.init(colorArray: (game?.missionsColorArray())!)), animated: true)
        
    }
    
    @objc func exitAlert(){
        let actionSheet = UIAlertController(title: "Deseja parar este jogo?", message: nil, preferredStyle: .alert)
        let stop = UIAlertAction(title: "Parar", style: .default, handler: {(action:UIAlertAction) in
            game?.clear()
            self.dismiss(animated: true)
            
        })
        stop.setValue(UIColor.red, forKey: "titleTextColor")
        actionSheet.addAction(stop)
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true)
        
    }

}
