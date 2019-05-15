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
    
    @IBOutlet var collection: UICollectionView!
    
    var backgroundPlayer: AVPlayer?
    @IBOutlet weak var backgroundVideo: UIView!
    
    var mission: Mission?
    
    
    private let sectionInsets = UIEdgeInsets(top:   50.0,   left: 20.0,
                                             bottom:50.0,   right: 20.0)
    private let itemsPerRow: CGFloat = 2
    
    var voteButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        collection.allowsSelection = true
        collection.backgroundColor = .clear
        collection.tintColor = .clear
        collection.bounces = false
        collection.isScrollEnabled = true
        
        setupVideo()
        
        mission = game?.getMission()
        
        addVoteButton()
        
    }
    func addVoteButton(){
        voteButton = UIButton(frame: CGRect(x: self.view.frame.width/2 - 60, y: self.view.frame.height - 120, width: 120, height: 40))
        voteButton.isHidden = true
        voteButton.setTitle("Votar", for: .normal)
        voteButton.setTitleColor(.black, for: .normal)
        voteButton.backgroundColor = .yellow
        voteButton.layer.cornerRadius = 5
        voteButton.layer.masksToBounds = true
        voteButton.addTarget(self, action: #selector(startVote(_:)), for: .touchUpInside)
        self.view.addSubview(voteButton)
    }
    @objc func startVote(_ sender: UIButton){
        //        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VoteMissionViewController") as? VoteMissionViewController{
        //            navigationController?.pushViewController(vc, animated: true)
                    
        //        }
        if collection.isHidden{
            collection.isHidden = false
            voteButton.isHidden = true
        }
        else{
            collection.isHidden = true
            voteButton.isHidden = false
            collection.scrollsToTop = true
            
            collection.setContentOffset(CGPoint(x: 0, y: -20), animated: true)
        }
    }
    
    
    
}




extension CreateMissionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        game?.changeSelection(index: indexPath.row)
        if (game?.selectionCompleted())!{
            voteButton.isHidden = false
        }
        else{
            voteButton.isHidden = true
        }
        collection.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return game!.numberOfPlayers
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "CreateMissionCollectionViewCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CreateMissionCollectionViewCell  else {
            fatalError("The dequeued cell is not an instance of PlayersTableViewCell.")
        }
        let player = players[indexPath.row]
        
        cell.image.image = player.image
        cell.image.layer.cornerRadius = cell.image.frame.width / 2
        cell.backgroundColor = .clear
        cell.image.layer.masksToBounds = true
        cell.highlight.layer.cornerRadius = cell.highlight.frame.width / 2
        cell.highlight.layer.masksToBounds = true
        cell.image.contentMode = .scaleAspectFill
        
        if(player.selected){
            cell.highlight.backgroundColor = .yellow
        }
        else{
            cell.highlight.backgroundColor = .clear
        }
        cell.nome.text = player.name
        cell.nome.textColor = .yellow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collection.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        //print(widthPerItem)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "\(CreateMissionCollectionReusableView.self)",
                for: indexPath) as? CreateMissionCollectionReusableView
                else {
                    fatalError("Invalid view type")
            }
            header.missionTitle.text = game?.missionTitle()
            
            header.image.layer.cornerRadius = header.image.frame.width / 2
            header.image.layer.masksToBounds = true
            header.image.contentMode = .scaleAspectFill
            
            header.image.image = game!.getLeader().image
            
            header.leaderName.text = game!.getLeader().name
            header.numberImage.image = mission?.missionImage()
            
            return header
        default:
            // 4
            assert(false, "Invalid element type")
        }
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
