//
//  VoteMissionViewController.swift
//  Rebels
//
//  Created by Samuel on 14/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit

class participantView: UIView{
    var image: UIImageView?
    var name: UILabel?
    
    
    init(name: String, image: UIImage){
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        self.backgroundColor = .clear
        self.image = UIImageView(image: image)
        self.image!.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        self.image!.layer.cornerRadius = self.image!.frame.width / 2
        self.layer.masksToBounds = true
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.addSubview(self.image!)
        self.name = UILabel(frame: CGRect(x: 70, y: 0, width: self.frame.width - self.image!.frame.width, height: 60))
        self.name!.text = name
        
        self.addSubview(self.name!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VoteMissionView: UIView {
    
    var stack: UIStackView?
    
    var name: UILabel?
    
    var rejectButton: UIButton?
    
    var acceptButton: UIButton?
    
    var viewing: Int = 0
    
    override var isHidden: Bool{
        didSet{
            if self.isHidden == false{
                changeStack()
            }
        }
    }
    func changeStack(){
        self.name!.text = game?.players[viewing].name
        print("hulala")
        
       
        
        for i in 0..<(game?.getMission().numberOfPlayers)!{
            let player = game?.getMission().players[i]
            self.stack?.addArrangedSubview(participantView(name: player!.name, image: player!.image!))
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        //var views = [participantView]()
        self.name = UILabel(frame: CGRect(x: 0, y: 40, width: 375, height: 50))
        self.name!.textColor = .yellow
        self.name!.backgroundColor = .clear
        addSubview(name!)
        self.name!.text = game?.players[viewing].name
        
        self.stack = UIStackView()
        
        stack!.axis = .vertical
        stack!.distribution = .equalSpacing
        stack!.alignment = .center
        stack!.spacing = 30
        stack!.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stack!)
        
        self.addButtons()
        
        
    }
    func addButtons(){
        rejectButton = UIButton(frame: CGRect(
            x: 50, y: 522,
            width: 110, height: 50))
        
        rejectButton!.addTarget(self, action: #selector(reject), for: .touchUpInside)
        rejectButton!.backgroundColor = .yellow
        rejectButton!.setTitle("Rejeitar", for: .normal)
        rejectButton!.setTitleColor(.black, for: .normal)
        
        self.addSubview(rejectButton!)
        
        acceptButton = UIButton(frame: CGRect(
            x: 215, y: 522,
            width: 110, height: 50))
        
        acceptButton!.addTarget(self, action: #selector(accept), for: .touchUpInside)
        acceptButton!.backgroundColor = .yellow
        acceptButton!.setTitle("Aceitar", for: .normal)
        acceptButton!.setTitleColor(.black, for: .normal)
        
        self.addSubview(acceptButton!)
    }
    @objc func reject() {
        
        game?.players[viewing].vote = false
        viewing += 1
        
        if self.viewing>=game!.numberOfPlayers{
            self.isHidden = true
            viewing = 0
            if let topMostViewController = UIApplication.shared.topMostViewController() as? CreateMissionViewController{
                topMostViewController.checkEnd()
            }
        }
        //changeStack()
    }
    
    @objc func accept() {
        
        game?.players[viewing].vote = true
        viewing += 1
        
        if self.viewing>=game!.numberOfPlayers{
            self.isHidden = true
            viewing = 0
            if let topMostViewController = UIApplication.shared.topMostViewController() as? CreateMissionViewController{
                topMostViewController.checkEnd()
            }
        }
        //changeStack()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
