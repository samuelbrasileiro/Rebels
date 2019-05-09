//
//  OptionsViewController.swift
//  Rebels
//
//  Created by Samuel on 07/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit
import QuartzCore

enum Phase: Int{
    case first = 1
    case second = 2
    case third = 3
    case fourth = 4
    
    mutating func nextPhase(){
        self = Phase(rawValue: self.rawValue + 1) ?? .first
    }
}

class ShowTeamViewController: UIViewController {

    @IBOutlet weak var team: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var instruction: UILabel!
    
    @IBOutlet var image: UIImageView!
    
    @IBOutlet var button: UIButton!
    
    var playerIndex: Int?
    
    var phase: Phase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playerIndex = 0
        self.phase = .first
        self.image.layer.cornerRadius = self.image.frame.width / 2
        self.image.layer.masksToBounds = true
        
        
        self.button.layer.cornerRadius = button.frame.width / 2
        self.button.layer.masksToBounds = true
        
        self.button.backgroundColor = .clear
        self.button.alpha = 0
        
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
        showPlayer(index: self.playerIndex!)
    }
    
    @objc func buttonAction(_ sender: UIButton){
        showPlayer(index: self.playerIndex!)
    }

    func showPlayer(index: Int){
        switch self.phase! {
        case .first:
            self.button.setImage(UIImage(named: "yellowClick")!, for: .normal)
            self.button.alpha = 0
            
            UIView.animate(withDuration: 4.0, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction, .beginFromCurrentState], animations: {
                self.button.backgroundColor = .white
                self.button.alpha = 1
                self.button.tintColor = .yellow
            })
            
            self.name.text = game?.players[index].name
            self.image.image = game?.players[index].image
            self.team.text = "Team"
            self.instruction.text = "Click on your photo to see which team you're in"
            phase!.nextPhase()
            
        case .second:
            
            self.button.tintColor = .clear
            
            var named: String
            if(game?.players[index].getTeam() == .empire){
                named = "empire"
            }
            else{
                named = "rebel"
            }
            self.button.setImage(UIImage(named: named)!, for: .normal)
            
            self.button.alpha = 0
            
            UIView.animate(withDuration: 2.0, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction, .beginFromCurrentState], animations: {
                
                self.button.alpha = 1
                if(game?.players[index].getTeam() == .empire){
                    self.button.tintColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 0.5)
                }
                else{
                    self.button.tintColor = UIColor(red: 0.5, green: 0, blue: 0, alpha: 0.5)
                }
            })
            self.button.backgroundColor = .clear
            self.team.text = game?.players[index].getTeam().rawValue
            self.name.text = game?.players[index].name
            self.image.image = game?.players[index].image
            if(index == game!.numberOfPlayers - 1){
                self.instruction.text = "Click again on your photo to start Mission 1"
            }
            else{
                self.instruction.text = "Click again on your photo to change the player"
            }
            if(index < game!.numberOfPlayers - 1){
                self.playerIndex = self.playerIndex! + 1
                phase = .first
            }
        default: break
            
        }
        
    }

}
