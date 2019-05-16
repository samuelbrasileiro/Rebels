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
    var leader: Int
    var numberOfSelected: Int
    init(players: [Player]){
        self.numberOfPlayers = players.count
        self.players = players
        self.missionIndex = 0
        self.leader = 0
        self.numberOfSelected = 0
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
    func selectionCompleted()->Bool{
        if self.numberOfSelected == missions[missionIndex].numberOfPlayers{
            return true
        }
        return false
    }
    func changeSelection(index: Int){
        
        if players[index].selected == false {
            if self.numberOfSelected < missions[missionIndex].numberOfPlayers{
                self.numberOfSelected += 1
                players[index].selected = true
            }
        }
        else{
            self.numberOfSelected -= 1
            players[index].selected = false
        }
    }
    func setSelected() -> [Player] {
        var selected = [Player]()
        for i in 0..<numberOfPlayers{
            if players[i].selected{
                selected.append(players[i])
            }
        }
        return selected
    }
    func getLeader()->Player{
        return players[leader]
    }
    func missionTitle()->String{
        var title: String
        switch missionIndex {
        case 0:
            title = "Primeira"
        case 1:
            title = "Segunda"
        case 2:
            title = "Terceira"
        case 3:
            title = "Quarta"
        case 5:
            title = "Quinta"
        default:
            title = "Nenhuma"
        }
        title += " Missão"
        return title
    }
    func clearVotes(){
        for i in 0..<players.count{
            players[i].vote = false
        }
    }
    func getMission()->Mission{
        return missions[missionIndex]
    }
    
    func setLeader(leader: Int){
        self.leader = leader
    }
    func changeLeader(){
        if(self.leader < players.count){
            self.leader += 1
        }
        else{
            self.leader = 0
        }
    }
    
    func checkVotes() -> Bool {
        var votes: Int = 0
        for i in 0..<numberOfPlayers{
            if players[i].vote{
                votes += 1
            }
        }
        if votes >= Int(ceil(Double(numberOfPlayers) / 2)){
            return true
        }
        return false
    }
    
    func clear(){
        self.numberOfSelected = 0
        for i in 0..<players.count{
            players[i].selected = false
            players[i].vote = false
        }
    }
    
}
