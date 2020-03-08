//
//  endGameViewController.swift
//  Rebels
//
//  Created by Samuel Brasileiro on 08/03/20.
//  Copyright © 2020 Samuel. All rights reserved.
//

import UIKit

class endGameViewController: BaseGameViewController {

    @IBOutlet var image: UIImageView!
    
    @IBOutlet var instruction: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = UIImage(named: (game?.winner.rawValue)!)
        if game?.winner == .empire{
            instruction.text = "Parabéns império! Vocês conseguiram descobrir quem eram os infiltrados nos planos do imperador e deram um fim a eles."
        }
        else{
            instruction.text = "Isso, rebeldes! A missão de infiltrar foi realizada com sucesso. Com a sua ajuda, a aliança rebelde conseguiu enfraquecer um pouco mais o Império."
        }
    }
    
    @IBAction func playAgainButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
