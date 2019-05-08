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
        vc.delegate = self
        vc.allowsEditing = true
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            
            vc.sourceType = .camera
            vc.cameraCaptureMode = .photo
            vc.cameraFlashMode = .off
            self.present(vc, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
            
            vc.sourceType = .photoLibrary
            self.present(vc, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true)
        
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
    
    @IBAction func trashButton(_ sender: UIButton) {
        players.remove(at: index!)
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
}
