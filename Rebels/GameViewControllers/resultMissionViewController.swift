//
//  resultMissionViewController.swift
//  Rebels
//
//  Created by Samuel Brasileiro on 08/03/20.
//  Copyright © 2020 Samuel. All rights reserved.
//

import UIKit
class RoundedUIButton: UIButton{
    func commonInit(){
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}
class resultMissionViewController: BaseGameViewController {
    
    @IBOutlet var image: UIImageView!
    
    @IBOutlet var resultado: UILabel!
    
    override func viewDidLoad() {
        game?.setWinner()
        game?.clear()
        
        super.viewDidLoad()
        
        image.image = UIImage(named: (game?.getMission().winner.rawValue)!)
        if game?.getMission().winner == .empire{
            resultado.text = "Não houve nenhuma sabotagem! O Império conseguiu realizar a missão com sucesso."
        }
        else if game?.getMission().numberOfFails == 1{
            resultado.text = "Um recruta sabotou o plano do Império, então não foi possível completá-lo."
        }
        else{
            resultado.text = "Houve \(game?.getMission().numberOfFails ?? 2) sabotagens na missão do Império! Cuidado com os recrutas que foram escolhidos."
        }
    }
    
    
    @IBAction func nextMissionButton(_ sender: Any) {
        game?.nextMission()
        if (game?.didGameEnd())!{
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "endGameViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateMissionViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    

}
