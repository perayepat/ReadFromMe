//
//  DetailViewController.swift
//  ReadFromMe
//
//  Created by Pat on 2022/09/05.
//

import Foundation
import UIKit

class DetailViewController: UIViewController{
    let book: Book
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = book.image
        titleLabel.text = book.title
        authorLabel.text = book.author
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
