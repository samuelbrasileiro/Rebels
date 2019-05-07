//
//  players.swift
//  Rebels
//
//  Created by Samuel on 05/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import Foundation
import UIKit
enum Troop{
    case rebel
    case empire
    case none
}

class Player{
    var name: String
    private var team: Troop
    var photo: UIImage?
    init(){
        self.name  = "default"
        self.team  = .none
    }
    init(name: String, photo: UIImage){
        self.name  = name
        self.photo = photo
        self.team  = .none
    }
    func setTeam(team: Troop){
        self.team = team
    }
    func getTeam()->Troop{return self.team}
}
