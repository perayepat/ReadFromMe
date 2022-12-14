//
//  DetailViewController.swift
//  ReadFromMe
//
//  Created by Pat on 2022/09/05.
//

import Foundation
import UIKit

class DetailViewController: UITableViewController{
    var book: Book
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var reviewTextView: UITextView!
    @IBOutlet var readMeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = book.image ?? LibrarySymbol.letterSquare(letter: book.title.first).image
        imageView.layer.cornerRadius = 15
        titleLabel.text = book.title
        authorLabel.text = book.author
        if let review = book.review{
            reviewTextView.text = review
        }
        
      
        
        reviewTextView.addDoneBUtton()
        
        let image = book.readMe
        ? LibrarySymbol.bookmarkFill.image
        : LibrarySymbol.bookmark.image
        readMeButton.setImage(image, for: .normal)
    }
    
    @IBAction func toggleReadMe(){
        book.readMe.toggle()
        let image = book.readMe
        ? LibrarySymbol.bookmarkFill.image
        : LibrarySymbol.bookmark.image
        readMeButton.setImage(image, for: .normal)
    }
    
    @IBAction func saveChanges(){
        Library.update(book: book)
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
//        Library.saveImage(selectedImage, forBook: book)
        book.image = selectedImage
        dismiss(animated: true)
    }
}

extension DetailViewController: UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        book.review = textView.text
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
