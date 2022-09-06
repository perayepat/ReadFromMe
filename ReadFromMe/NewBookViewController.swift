//
//  NewBookViewController.swift
//  ReadFromMe
//
//  Created by Pat on 2022/09/06.
//

import Foundation
import UIKit


class NewBookViewController:UITableViewController{
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var authorTextField: UITextField!
    @IBOutlet var bookImageView: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookImageView.layer.cornerRadius = 15
        
    }
    
 
    
    @IBAction func updateImage(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType =
        UIImagePickerController.isSourceTypeAvailable(.camera)
        ? .camera
        : .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
        
    }
    
}

extension NewBookViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //what to do after we've selected the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {return}
        bookImageView.image = selectedImage         // if we have the image update the image view
        dismiss(animated: true)
    }
}

extension NewBookViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //what happens after you press return
        // by passing the first responder responsibilities
        if textField == titleTextField{
            return authorTextField.becomeFirstResponder()
        }else{
            return textField.resignFirstResponder()
        }
    }
}




