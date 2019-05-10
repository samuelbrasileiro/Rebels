//
//  CreateMissionViewController.swift
//  Rebels
//
//  Created by Samuel on 09/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit

class CreateMissionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "cancel"), style: .done, target: self, action: #selector(exitAlert)),animated: true)
        // Do any additional setup after loading the view.
    }
    
    @objc func exitAlert(){
        let actionSheet = UIAlertController(title: "Deseja parar este jogo?", message: nil, preferredStyle: .alert)
        
        actionSheet.addAction(UIAlertAction(title: "Parar", style: .default, handler: {(action:UIAlertAction) in
            self.dismiss(animated: false, completion: {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateMissionNavigationController")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window!.rootViewController?.dismiss(animated: true, completion: nil)
            })
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
