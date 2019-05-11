//
//  CreateMissionViewController.swift
//  Rebels
//
//  Created by Samuel on 09/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import UIKit

class CreateMissionViewController: BaseGameViewController {
    var backgroundPlayer: AVPlayer?
    @IBOutlet weak var backgroundVideo: UIView!
    
    @IBOutlet weak var missionTitle: UILabel!
    
    @IBOutlet var image: UIImageView!
    
    var mission: Mission?
    
    @IBOutlet weak var leaderName: UILabel!
    
    @IBOutlet var button: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupVideo()
        
        mission = game?.getMission()
        
        missionTitle.text = game?.missionTitle()
        
        self.image.layer.cornerRadius = self.image.frame.width / 2
        self.image.layer.masksToBounds = true
        self.image.contentMode = .scaleAspectFill
        
        image.image = game!.getLeader().image
       leaderName.text = game!.getLeader().name
        button.setImage( mission?.missionImage(), for: .normal)
        
        
    }
    
    
    
    
    func setupVideo(){
        
        guard let url = Bundle.main.url(forResource: "starsVideoBackground", withExtension: "mov") else {
            print("No file with specified name exists")
            return }
        do{
            let safeImage = UIImageView(image: UIImage(named: "starsBackground")!)
            safeImage.frame = self.backgroundVideo.frame
            safeImage.contentMode = .scaleToFill
            backgroundVideo.addSubview(safeImage)
            
            backgroundPlayer = AVPlayer(url: url)
            let newLayer = AVPlayerLayer(player: backgroundPlayer)
            newLayer.frame = self.backgroundVideo.frame
            self.backgroundVideo.layer.addSublayer(newLayer)
            newLayer.videoGravity = .resizeAspectFill
            backgroundPlayer!.play()
            
        }
    }
    


}
