//
//  Mission.swift
//  Rebels
//
//  Created by Samuel on 08/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import Foundation
import UIKit

class Mission{
    var numberOfPlayers: Int
    var players = [Player]()
    var completed: Bool
    var winner: Troop
    var twoSpiesToFail: Bool
    var voteCounter: Int
    
    init(_ numberOfPlayers: Int) {
        self.numberOfPlayers = numberOfPlayers
        self.completed = false
        self.twoSpiesToFail = false
        self.winner = .none
        self.voteCounter = 0;
    }
    init(_ numberOfPlayers: Int, twoSpiesToFail: Bool) {
        self.numberOfPlayers = numberOfPlayers
        self.completed = false
        self.twoSpiesToFail = twoSpiesToFail
        self.winner = .none
        self.voteCounter = 0;
    }
    func setPlayers(players: [Player]){
        self.players = players
    }
    
    func isAccepted(players: [Player])->Bool{
        voteCounter = 0
        for player in players{
            if !player.vote{
                voteCounter += 1;
            }
        }
        if voteCounter > players.count{
            return false
        }
        return true
    }
    
    
    func missionImage()->UIImage{
        return UIImage(named: "mission" + String(self.numberOfPlayers))!
    }
    
}
