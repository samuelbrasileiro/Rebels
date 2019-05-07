//
//  players.swift
//  Rebels
//
//  Created by Samuel on 05/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import Foundation
enum Troop{
    case rebel
    case empire
    case none
}

class Player{
    var name: String
    var team: Troop
    var photo: String
    init(){
        self.name  = "default"
        self.team  = .none
        self.photo = "default"
    }
    init(name: String, photo: String){
        self.name  = name
        self.photo = photo
        self.team  = .none
    }
    func setTeam(team: Troop){
        self.team = team
    }
}
