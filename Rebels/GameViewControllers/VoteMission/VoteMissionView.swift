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
    
    
    init(frame: CGRect, name: String, image: UIImage){
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.image = UIImageView(image: image)
        self.image!.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        self.image!.layer.cornerRadius = self.image!.frame.width / 2
        self.image!.layer.masksToBounds = true
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.addSubview(self.image!)
        self.name = UILabel(frame: CGRect(x: 70, y: 0, width: self.frame.width - self.image!.frame.width, height: 60))
        self.name!.textColor = .yellow
        self.name!.text = name
        
        self.addSubview(self.name!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VoteMissionView: UIView {
    
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var rejectButton: UIButton!
    
    @IBOutlet var acceptButton: UIButton!
    
    @IBOutlet var selectedView: UIView!
    
    
    var viewing: Int?{
        didSet{
            if viewing!<game!.numberOfPlayers{
                name.text = game?.players[viewing!].name
            }
        }
    }
    
    override var isHidden: Bool{
        didSet{
            if self.isHidden == false{
                changeStack()
            }
            else{
                for view in selectedView.subviews{
                    view.removeFromSuperview()
                }
            }
        }
    }
    func changeStack(){
        //let stack = UIStackView(frame: CGRect(x: 50, y: 110, width: 250, height: 360))
        
        
        for i in 0..<(game?.getMission().players.count)!{
            let player = game?.getMission().players[i]
            
            self.selectedView.addSubview(participantView(frame: CGRect(x: 0, y: 70*i, width: 200, height: 60), name: player!.name, image: player!.image!))
            
            
            
        }
    }

    func commonInit(){
        
        Bundle.main.loadNibNamed("VoteMissionView", owner: self, options: nil)
        self.addSubview(contentView)
        self.contentView.backgroundColor = .clear
        viewing = 0
        
        //var views = [participantView]()
        self.name.textColor = .yellow
        self.name.backgroundColor = .clear

        
        self.selectedView.backgroundColor = .clear
        
        self.addButtons()
    }
    func addButtons(){
        
        rejectButton.addTarget(self, action: #selector(reject), for: .touchUpInside)
        rejectButton.layer.cornerRadius = 5
        rejectButton.layer.masksToBounds = true
        rejectButton!.backgroundColor = .yellow
        rejectButton!.setTitle("Rejeitar", for: .normal)
        rejectButton!.setTitleColor(.black, for: .normal)
        
        acceptButton!.addTarget(self, action: #selector(accept), for: .touchUpInside)
        acceptButton!.backgroundColor = .yellow
        acceptButton!.setTitle("Aceitar", for: .normal)
        acceptButton!.setTitleColor(.black, for: .normal)
        acceptButton.layer.cornerRadius = 5
        acceptButton.layer.masksToBounds = true
        
    }
    @objc func reject() {
        
        game?.players[viewing!].vote = false
        viewing! += 1
        
        
        if self.viewing!>=game!.numberOfPlayers{
            self.isHidden = true
            viewing = 0
            if let topMostViewController = UIApplication.shared.topMostViewController() as? CreateMissionViewController{
                topMostViewController.checkEnd()
            }
        }
    }
    
    @objc func accept() {
        
        game?.players[viewing!].vote = true
        viewing! += 1
        
        if self.viewing!>=game!.numberOfPlayers{
            self.isHidden = true
            viewing = 0
            if let topMostViewController = UIApplication.shared.topMostViewController() as? CreateMissionViewController{
                topMostViewController.checkEnd()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    

}
