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
    var newBookImage: UIImage?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookImageView.layer.cornerRadius = 15
        
    }
    
    @IBAction func cancel(){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveNewBook(){
        guard let title = titleTextField.text,
              let author = authorTextField.text,
              !title.isEmpty,
              !author.isEmpty
        else{return}
        
        Library.addNew(book: Book(title: title, author: author, readMe: true, image: newBookImage))
        navigationController?.popViewController(animated: true)
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
        newBookImage = selectedImage
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




