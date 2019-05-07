//
//  NewPlayerViewController.swift
//  Rebels
//
//  Created by Samuel on 07/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit

class EditPlayerViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var player = Player()
    var index: Int?
    @IBOutlet weak var nome: UITextField!
    
    @IBOutlet var image: UIImageView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        nome.delegate = self
        self.navigationItem.title = "Edit Player"
        self.image.layer.cornerRadius = self.image.bounds.width / 2
        
        self.image.layer.masksToBounds = true
        
        self.image.image = player.photo
        self.nome.text = player.name
        
    }
    @IBAction func button(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        vc.cameraFlashMode = .off
        
        present(vc, animated: true)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        self.image.image = image
        
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        players[index!] = Player(name: self.nome.text ?? player.name, photo: self.image.image ?? player.photo!)
            navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
}
