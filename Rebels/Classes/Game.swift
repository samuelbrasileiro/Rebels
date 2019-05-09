//
//  Game.swift
//  Rebels
//
//  Created by Samuel on 08/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import Foundation

class Game{
    var numberOfPlayers: Int
    var numberOfSpies: Int
    var players: [Player]
    var missions: [Mission]
    var missionIndex: Int
    
    init(players: [Player]){
        self.numberOfPlayers = players.count
        self.players = players
        self.missionIndex = 0
        for i in 0..<self.numberOfPlayers{
            players[i].setTeam(team: .empire)
        }
        switch self.numberOfPlayers {
        case 5:
            self.missions = [Mission(2), Mission(2), Mission(3), Mission(3), Mission(3)]
            self.numberOfSpies = 2
        case 6:
            self.missions = [Mission(2), Mission(3), Mission(3), Mission(4,twoSpiesToFail: true), Mission(4, twoSpiesToFail: true)]
            self.numberOfSpies = 2
        case 7:
            self.missions = [Mission(2), Mission(3), Mission(3), Mission(4,twoSpiesToFail: true), Mission(4, twoSpiesToFail: true)]
            self.numberOfSpies = 3
        case 8:
            self.missions = [Mission(3), Mission(4), Mission(4), Mission(5,twoSpiesToFail: true), Mission(5, twoSpiesToFail: true)]
            self.numberOfSpies = 3
        case 9:
            self.missions = [Mission(3), Mission(4), Mission(4), Mission(5,twoSpiesToFail: true), Mission(5, twoSpiesToFail: true)]
            self.numberOfSpies = 3
        case 10:
            self.missions = [Mission(3), Mission(4), Mission(4), Mission(5,twoSpiesToFail: true), Mission(5, twoSpiesToFail: true)]
            self.numberOfSpies = 4
        default:
            self.missions = []
            self.numberOfSpies = 0
        }
        
        for _ in 0..<self.numberOfSpies{
            var number = Int(arc4random_uniform(UInt32(self.numberOfPlayers)))
            while(players[number].getTeam() == .rebel){
                number = Int(arc4random_uniform(UInt32(self.numberOfPlayers)))
            }
            players[number].setTeam(team: .rebel)
        }
    }
    func clearVotes(){
        for i in 0..<players.count{
            players[i].vote = false
        }
    }
    
}
