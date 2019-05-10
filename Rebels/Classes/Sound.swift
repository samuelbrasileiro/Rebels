//
//  Sound.swift
//  Rebels
//
//  Created by Samuel on 08/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import Foundation
import AVFoundation

var soundPlayer: AVAudioPlayer?

func playSound(name: String) {
    guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
        print("No file with specified name exists")
        return }
    
    do {
        try AVAudioSession.sharedInstance().setCategory(.soloAmbient, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        
        /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
        soundPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
        /* iOS 10 and earlier require the following line:
         player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
        
        guard let soundPlayer = soundPlayer else { return }
        soundPlayer.numberOfLoops = -1
        soundPlayer.play()
        
    } catch let error {
        print(error.localizedDescription)
    }
}

func stopSound(){
    soundPlayer?.stop()
}
