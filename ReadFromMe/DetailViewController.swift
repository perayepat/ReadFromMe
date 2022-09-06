//
//  DetailViewController.swift
//  ReadFromMe
//
//  Created by Pat on 2022/09/05.
//

import Foundation
import UIKit

class DetailViewController: UITableViewController{
    let book: Book
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var reviewTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = book.image
        imageView.layer.cornerRadius = 15
        titleLabel.text = book.title
        authorLabel.text = book.author
        if let review = book.review{
            reviewTextView.text = review
        }
        reviewTextView.addDoneBUtton()
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
    
    //MARK: - init
    //creating a new book with the initializer
    //Initializing a detail view with book data
    
    init?(coder: NSCoder, book: Book) {
      self.book = book
      super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //what to do after we've selected the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {return}
        imageView.image = selectedImage         // if we have the image update the image view
        Library.saveImage(selectedImage, forBook: book)
        dismiss(animated: true)
    }
}

extension DetailViewController: UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
}

extension UITextView{
    func addDoneBUtton(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.resignFirstResponder))
        toolbar.items = [flexSpace, doneButton]
        self.inputAccessoryView = toolbar
    }
}
