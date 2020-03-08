//
//  GameViewController.swift
//  Rebels
//
//  Created by Samuel on 16/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit

class GameViewController: BaseGameViewController {
    

    @IBOutlet var name: UILabel!
    
    @IBOutlet var instruction: UILabel!
    
    @IBOutlet var image: UIImageView!
    
    @IBOutlet var imageBorder: UIView!
    
    @IBOutlet var button: UIButton!
    
    var playerIndex: Int?
    
    var showRoleButtonPhase = Phase()
    
    var showRoleButton = UIButton()
    
    var missionPlayers: [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        missionPlayers = (game?.getMission().players)!
        
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
        
        self.image.image = missionPlayers[playerIndex!].image
        self.name.text = missionPlayers[playerIndex!].name
        
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
        self.instruction.text = "Entregue o dispositivo para este(a) jogador(a). Selecione o perfil quando estiver pronto."
        
        addShowRoleButton()
        
        waitPlayer(index: self.playerIndex!)
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
            
            changeAction(index: self.playerIndex!)
        }
            //Ok is pressed
        else if !checkEnd(){
            
            imageBorder.isHidden = true
            button.isHidden = false
            button.isUserInteractionEnabled = true
            showRoleButton.isHidden = true
            showRoleButton.setTitle("COMEÇAR", for: .normal)
            waitPlayer(index: self.playerIndex!)
            
        }
        
        showRoleButtonPhase.exchange()
    }
    
    func changeAction(index: Int){
        self.instruction.text = nil
        
        
        self.name.text = missionPlayers[index].name
        self.image.image = missionPlayers[index].image
        
        self.showRoleButton.setTitle("OK", for: .normal)
        
        
        self.playerIndex = self.playerIndex! + 1
        
    }
    func waitPlayer(index: Int){
        imageBorder.isHidden = true
        button.isHidden = false
        button.isUserInteractionEnabled = true
        showRoleButton.setTitle("COMEÇAR", for: .normal)
        self.button.setImage(UIImage(named: "yellowClick")!, for: .normal)
        self.button.alpha = 0
        self.showRoleButton.setTitle("COMEÇAR", for: .normal)
        UIView.animate(withDuration: 3.0, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
            self.button.backgroundColor = .white
            self.button.alpha = 1
            self.button.tintColor = .yellow
        })
        
        self.name.text = missionPlayers[index].name
        self.image.image = missionPlayers[index].image
        //self.team.text = nil
        self.instruction.text = "Entregue o dispositivo para este(a) jogador(a). Selecione o perfil quando estiver pronto."
    }
    
    func addShowRoleButton(){
        showRoleButton = UIButton(frame: CGRect(
            x: self.view.frame.width / 2 - 100, y: self.view.frame.height - 180,
            width: 200, height: 40))
        
        showRoleButton.addTarget(self, action: #selector(showRoleButtonAction(_:)), for: .touchUpInside)
        showRoleButton.backgroundColor = .yellow
        showRoleButton.setTitle("COMEÇAR", for: .normal)
        showRoleButton.setTitleColor(.black, for: .normal)
        showRoleButton.isHidden = true
        
        self.view.addSubview(showRoleButton)
    }
    
    func checkEnd()->Bool{
        if(self.playerIndex! == game!.getMission().numberOfPlayers){
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateMissionViewController")
            self.navigationController?.pushViewController(vc, animated: false)
            return true
        }
        return false
    }
    
}
