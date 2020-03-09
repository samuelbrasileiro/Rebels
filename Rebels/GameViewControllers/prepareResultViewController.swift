//
//  prepareResultViewController.swift
//  Rebels
//
//  Created by Samuel Brasileiro on 08/03/20.
//  Copyright © 2020 Samuel. All rights reserved.
//

import UIKit

class prepareResultViewController: BaseGameViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func seeResultButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "resultMissionViewController")
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}
