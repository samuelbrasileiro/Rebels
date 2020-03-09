//
//  BasePlayerViewController.swift
//  Rebels
//
//  Created by Samuel on 07/05/19.
//  Copyright © 2019 Samuel. All rights reserved.
//

import UIKit
func instantiateFromSuperclassStoryboard(type: Int, base: String) -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: base)
    switch type {
    case 0:
        object_setClass(controller, EditPlayerViewController.self)
        return controller as! EditPlayerViewController
    case 1:
        object_setClass(controller, NewPlayerViewController.self)
        return controller as! NewPlayerViewController
    default:
        return controller
    }
    
}

class BasePlayerViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var player = Player()
    var index: Int?
    var didChangeImage: Bool?
    @IBOutlet weak var nome: UITextField!
    @IBOutlet var image: UIImageView!
    @IBOutlet var clickButton: UIButton!
    
    @IBOutlet var trashButton: UIButton!
    
    @IBOutlet var buttonOutlet: UIButton!
    override func viewDidLoad(){
        super.viewDidLoad()
        nome.delegate = self
        if self.traitCollection.userInterfaceStyle == .dark{
            nome.textColor = .white
        }
        buttonOutlet.layer.cornerRadius = 5
        buttonOutlet.layer.masksToBounds = true
        didChangeImage = false
    }
       
    
    @IBAction func button(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        let actionSheet = UIAlertController(title: "Escolha uma fonte", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Câmera", style: .default, handler: {(action:UIAlertAction) in
            
            vc.sourceType = .camera
            vc.cameraCaptureMode = .photo
            vc.cameraFlashMode = .off
            self.present(vc, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Biblioteca de Fotos", style: .default, handler: {(action:UIAlertAction) in
            
            vc.sourceType = .photoLibrary
            self.present(vc, animated: true)
        }))
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        actionSheet.addAction(cancel)
        
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
            print("Nenhuma imagem encontrada")
            return
        }
        
        self.image.layer.cornerRadius = self.image.bounds.width / 2
        
        self.image.layer.masksToBounds = true
        self.image.contentMode = .scaleAspectFill
        self.image.image = image
        didChangeImage = true
        
    }
    
    func createAndShowAlert(message: String){
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        action.setValue(UIColor.yellow, forKey: "titleTextColor")
        self.present(alert, animated: true)
    }

    
}
