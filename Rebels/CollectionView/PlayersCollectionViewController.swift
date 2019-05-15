//
//  PlayersCollectionViewController.swift
//  Rebels
//
//  Created by Samuel on 07/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit


var players = [Player]()
var game: Game?

class PlayersCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let sectionInsets = UIEdgeInsets(top:   50.0,   left: 20.0,
                                             bottom:50.0,   right: 20.0)
    private let itemsPerRow: CGFloat = 2
    let startButton = UIButton()
    @objc func add(){
        if let vc = instantiateFromSuperclassStoryboard(type: 1, base: "BasePlayerViewController") as? NewPlayerViewController{
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.bounces = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        playSound(name: "EndorTheme")
        players = [ Player(name: "Samuel1", image: UIImage(named: "photo1")!),
                    Player(name: "Samuel2", image: UIImage(named: "photo2")!),
                    Player(name: "Samuel3", image: UIImage(named: "photo3")!),
                    Player(name: "Samuel4", image: UIImage(named: "photo4")!),
                    Player(name: "Samuel5", image: UIImage(named: "photo5")!)
                ]
        navigationController?.navigationBar.tintColor = .yellow
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        addStartButton()
        
    }
    func addStartButton(){
        startButton.frame = CGRect(origin: CGPoint(x: self.view.frame.width/2 - 60, y: self.view.frame.height - 120),size: CGSize(width: 120, height: 40))
        startButton.setTitle("Começar Jogo", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.backgroundColor = .yellow
        startButton.layer.cornerRadius = 5
        startButton.layer.masksToBounds = true
        startButton.addTarget(self, action: #selector(startGame(_:)), for: .touchUpInside)
        self.view.addSubview(startButton)
    }
    @objc func startGame(_ sender: UIButton){
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowTeamNavigationController") as? UINavigationController{
            
            game = Game(players: players)
            present(vc, animated: true)
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = true
        super.viewWillAppear(animated)
        
        let imageView = UIImageView(image: UIImage(named: "starsBackground"))
        imageView.contentMode = .scaleAspectFill
        self.collectionView.backgroundView = imageView
        self.collectionView.backgroundColor = .black
        
        self.collectionView.reloadData()
        
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return players.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "PlayersCollectionViewCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PlayersCollectionViewCell  else {
            fatalError("The dequeued cell is not an instance of PlayersTableViewCell.")
        }
        let player = players[indexPath.row]
        
        cell.image.image = player.image
        cell.image.layer.cornerRadius = cell.image.frame.width / 2
        cell.image.layer.masksToBounds = true
        cell.image.contentMode = .scaleAspectFill
        
        cell.nome.text = player.name
        cell.nome.textColor = .yellow
        return cell
    }
    
    
        
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = instantiateFromSuperclassStoryboard(type: 0, base: "BasePlayerViewController") as? EditPlayerViewController{
                vc.player = players[indexPath.row]
                vc.index = indexPath.row
                navigationController?.pushViewController(vc, animated: true)
        }
    }
        
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
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
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = players.remove(at: sourceIndexPath.row)
        players.insert(temp, at: destinationIndexPath.row)
    }
    
    
}
