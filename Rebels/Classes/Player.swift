//
//  Player.swift
//  Rebels
//
//  Created by Samuel on 05/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import Foundation
import UIKit
enum Troop: String{
    case rebel = "rebel"
    case empire = "empire"
    case none = "none"
    func name()->String{
        switch self {
        case .rebel:
            return "Aliança Rebelde"
        case .empire:
            return "Império"
        default:
            return "Nenhum"
        }
    }
}

public class Player: NSObject{
    var name: String
    var team: Troop
    var vote: Bool
    var selected: Bool
    var image: UIImage?
    override init(){
        
        self.name  = "default"
        self.team  = .none
        self.vote  = false
        self.selected = false
    }
    init(name: String, image: UIImage){
        self.name  = name
        self.image = image
        self.team  = .none
        self.vote  = false
        self.selected = false
    }
    func setTeam(team: Troop){
        self.team = team
    }
    func changeSelection(){
        if self.selected == true{
            self.selected = false
        }
        else{
            self.selected = true
        }
    }
    func getTeam()->Troop{return self.team}
}
