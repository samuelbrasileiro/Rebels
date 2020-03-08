//
//  PlayMissionViewController.swift
//  Rebels
//
//  Created by Samuel on 16/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit

class PlayMissionViewController: BaseGameViewController {
    
    @IBOutlet var missionTitle: UILabel!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var instruction: UILabel!
    
    @IBOutlet var image: UIImageView!
    
    @IBOutlet var imageBorder: UIView!
    
    @IBOutlet var button: UIButton!
    
    var playerIndex: Int?
    
    var showActionButtonPhase = Phase()
    
    var showActionButton = UIButton()
    
    var sabotageButton = UIButton()
    
    var missionPlayers: [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle(title: "")
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
        
        addshowActionButton()
        addSabotageButton()
        
        missionTitle.text = (game?.missionTitle())!
        waitPlayer(index: self.playerIndex!)
        waitPlayer(index: self.playerIndex!)
    }
    
    
    //When the Photo is pressed
    @objc func buttonAction(_ sender: UIButton){
        showActionButton.isHidden = false
        imageBorder.isHidden = false
        button.isHidden = true
        button.isUserInteractionEnabled = false
        
    }
    
    //When the Show Role / OK button is pressed
    @objc func showActionButtonAction(_ sender: UIButton){
        //Show role is pressed
        if(showActionButtonPhase == .first){
            imageBorder.isHidden = true
            button.isHidden = false
            button.isUserInteractionEnabled = false
            if missionPlayers[playerIndex!].getTeam() == .rebel {
                print(missionPlayers[playerIndex!].getTeam())
                sabotageButton.isHidden = false
                instruction.text = "Você é da Aliança Rebelde e está infiltrado no Império. Para prejudicar os planos do Imperador, você pode tanto cooperar quanto sabotar esta missão."
            }
            else{
                instruction.text = "Você é um soldado do Império. É designado para você uma única função: servir ao seu general. Coopere com a missão."
            }
            changeAction(index: self.playerIndex!)
        }
        //COOPERAR is pressed
        else if !checkEnd(){
            sabotageButton.isHidden = true
            imageBorder.isHidden = true
            button.isHidden = false
            button.isUserInteractionEnabled = true
            showActionButton.isHidden = true
            showActionButton.setTitle("COMEÇAR", for: .normal)
            waitPlayer(index: self.playerIndex!)
            
        }
        
        showActionButtonPhase.exchange()
    }
    
    @objc func sabotageButtonAction(_ sender: UIButton){
        game?.sabotaged()
        if !checkEnd(){
            sabotageButton.isHidden = true
            imageBorder.isHidden = true
            button.isHidden = false
            button.isUserInteractionEnabled = true
            showActionButton.isHidden = true
            showActionButton.setTitle("COMEÇAR", for: .normal)
            waitPlayer(index: self.playerIndex!)
            
        }
        showActionButtonPhase.exchange()
    }
    func changeAction(index: Int){
        
        self.button.isHidden = true
        
        self.name.text = missionPlayers[index].name
        self.image.image = missionPlayers[index].image
        
        self.showActionButton.setTitle("COOPERAR", for: .normal)
        
        
        self.playerIndex = self.playerIndex! + 1
        
    }
    func waitPlayer(index: Int){
        imageBorder.isHidden = true
        button.isHidden = false
        button.isUserInteractionEnabled = true
        showActionButton.setTitle("COMEÇAR", for: .normal)
        self.button.setImage(UIImage(named: "yellowClick")!, for: .normal)
        self.button.alpha = 0
        self.showActionButton.setTitle("COMEÇAR", for: .normal)
        UIView.animate(withDuration: 3.5, delay: 0.5, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
            self.button.backgroundColor = .white
            self.button.alpha = 1
            self.button.tintColor = .yellow
        })
        
        self.name.text = missionPlayers[index].name
        self.image.image = missionPlayers[index].image
        //self.team.text = nil
        self.instruction.text = "Entregue o dispositivo para este(a) jogador(a). Selecione o perfil quando estiver pronto."
    }
    
    func addshowActionButton(){
        showActionButton = UIButton(frame: CGRect(
            x: self.view.frame.width / 2 - 100, y: self.view.frame.height - 180,
            width: 200, height: 40))
        
        showActionButton.addTarget(self, action: #selector(showActionButtonAction(_:)), for: .touchUpInside)
        showActionButton.backgroundColor = .yellow
        showActionButton.setTitle("COMEÇAR", for: .normal)
        showActionButton.layer.cornerRadius = 5
        showActionButton.layer.masksToBounds = true
        showActionButton.setTitleColor(.black, for: .normal)
        showActionButton.isHidden = true
        
        self.view.addSubview(showActionButton)
    }
    
    func addSabotageButton(){
        sabotageButton = UIButton(frame: CGRect(
            x: self.view.frame.width / 2 - 100, y: self.view.frame.height - 260,
            width: 200, height: 40))
        
        sabotageButton.addTarget(self, action: #selector(sabotageButtonAction(_:)), for: .touchUpInside)
        sabotageButton.backgroundColor = .yellow
        sabotageButton.setTitle("SABOTAR", for: .normal)
        sabotageButton.layer.cornerRadius = 5
        sabotageButton.layer.masksToBounds = true
        sabotageButton.setTitleColor(.black, for: .normal)
        sabotageButton.isHidden = true
        
        self.view.addSubview(sabotageButton)
    }
    
    func checkEnd()->Bool{
        if(self.playerIndex! == game!.getMission().numberOfPlayers){
            game?.setWinner()
            game?.clear()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateMissionViewController")
            self.navigationController?.pushViewController(vc, animated: true)
            return true
        }
        return false
    }
    
}
