//
//  CreateMissionCollectionViewCell.swift
//  Rebels
//
//  Created by Samuel on 14/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit

class CreateMissionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nome: UILabel!
    
    @IBOutlet weak var highlight: UIView!
    @IBOutlet var image: UIImageView!
    var restoreColor = UIColor.clear
    override var isSelected: Bool{
        didSet{
            if(game!.numberOfSelected >= (game?.missions[game!.missionIndex].numberOfPlayers)!
                && highlight.backgroundColor == .clear){
            if self.isSelected == true{
                restoreColor = highlight.backgroundColor!
                
                highlight.backgroundColor = .red
            }
            else{
                highlight.backgroundColor = restoreColor
            }
            }
        }
    }
    
}
