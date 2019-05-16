//
//  ShowTeamViewController.swift
//  Rebels
//
//  Created by Samuel on 07/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit

enum Phase: Int{
    case first = 1
    case second = 2
    case third = 3
    case fourth = 4
    
    mutating func nextPhase(){
        self = Phase(rawValue: self.rawValue + 1) ?? .first
    }
    mutating func exchange(){
        if self == .first{self = .second}
        else{self = .first}
    }
    init(){
        self = .first
    }
    
}

class ShowTeamViewController: BaseGameViewController {
    
    @IBOutlet weak var team: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var instruction: UILabel!
    
    @IBOutlet var image: UIImageView!
    
    @IBOutlet weak var imageBorder: UIView!
    
    @IBOutlet var button: UIButton!
    
    var playerIndex: Int?
    
    var showRoleButtonPhase = Phase()
    
    var showRoleButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playerIndex = 0
        
        
        self.image.layer.cornerRadius = self.image.frame.width / 2
        self.image.layer.masksToBounds = true
        self.image.contentMode = .scaleAspectFill
        
        self.imageBorder.layer.cornerRadius = self.imageBorder.frame.width / 2
        self.imageBorder.layer.masksToBounds = true
        
        imageBorder.backgroundColor = .yellow
        imageBorder.isHidden = true
        
        self.button.layer.cornerRadius = button.frame.width / 2
        self.button.layer.masksToBounds = true
        
        self.button.backgroundColor = .clear
        self.button.alpha = 0
        
        self.image.image = game?.players[playerIndex!].image
        self.name.text = game?.players[playerIndex!].name
        self.team.text = nil
        
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
        self.instruction.text = "Entregue o dispositivo para este(a) jogador(a). Selecione o perfil quando estiver pronto."
        
        addShowRoleButton()
        waitPlayer(index: self.playerIndex!)
    }

    
    //When the Photo is pressed
    @objc func buttonAction(_ sender: UIButton){
        showRoleButton.isHidden = false
        imageBorder.isHidden = false
        button.isHidden = true
        button.isUserInteractionEnabled = false
        
    }
    
    //When the Show Role / OK button is pressed
    @objc func showRoleButtonAction(_ sender: UIButton){
        //Show role is pressed
        if(showRoleButtonPhase == .first){
            imageBorder.isHidden = true
            button.isHidden = false
            button.isUserInteractionEnabled = false
            
            showRole(index: self.playerIndex!)
        }
        //Ok is pressed
        else if !checkEnd(){
            
            imageBorder.isHidden = true
            button.isHidden = false
            button.isUserInteractionEnabled = true
            showRoleButton.isHidden = true
            showRoleButton.setTitle("MOSTRAR PAPEL", for: .normal)
            waitPlayer(index: self.playerIndex!)
        }
        
        showRoleButtonPhase.exchange()
    }
    
    func showRole(index: Int){
        self.instruction.text = nil
        
        self.button.tintColor = .clear
        self.button.setImage(UIImage(named: (game?.players[index].getTeam().rawValue)!)!, for: .normal)
        self.button.alpha = 0
        
        UIView.animate(withDuration: 2.0, delay: 0, options: [.autoreverse, .repeat], animations: {
            
            self.button.alpha = 1
            if(game?.players[index].getTeam() == .empire){
                self.button.tintColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 0.5)
            }
            else{
                self.button.tintColor = UIColor(red: 0.5, green: 0, blue: 0, alpha: 0.5)
            }
        })
        self.button.backgroundColor = .clear
        self.team.text = "O seu grupo é " + (game?.players[index].getTeam().name())!
        self.name.text = game?.players[index].name
        self.image.image = game?.players[index].image
        
        self.showRoleButton.setTitle("OK", for: .normal)
        
        if(index == game!.numberOfPlayers - 1){
            self.showRoleButton.setTitle("Começar Missão 1", for: .normal)
        }
        
        self.playerIndex = self.playerIndex! + 1
        
    }
    func waitPlayer(index: Int){
        self.button.setImage(UIImage(named: "yellowClick")!, for: .normal)
        self.button.alpha = 0
        self.showRoleButton.setTitle("MOSTRAR PAPEL", for: .normal)
        UIView.animate(withDuration: 3.0, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
            self.button.backgroundColor = .white
            self.button.alpha = 1
            self.button.tintColor = .yellow
        })
        
        self.name.text = game?.players[index].name
        self.image.image = game?.players[index].image
        self.team.text = nil
        self.instruction.text = "Entregue o dispositivo para este(a) jogador(a). Selecione o perfil quando estiver pronto."
    }
    
    func addShowRoleButton(){
        showRoleButton = UIButton(frame: CGRect(
            x: self.view.frame.width / 2 - 100, y: self.view.frame.height - 180,
            width: 200, height: 40))
        
        showRoleButton.addTarget(self, action: #selector(showRoleButtonAction(_:)), for: .touchUpInside)
        showRoleButton.backgroundColor = .yellow
        showRoleButton.setTitle("MOSTRAR O PAPEL", for: .normal)
        showRoleButton.setTitleColor(.black, for: .normal)
        showRoleButton.isHidden = true
        
        self.view.addSubview(showRoleButton)
    }
    
    func checkEnd()->Bool{
        if(self.playerIndex! == game!.numberOfPlayers){
            
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateMissionViewController")
        self.navigationController?.pushViewController(vc, animated: false)
            return true
        }
        return false
    }
    
    
}
