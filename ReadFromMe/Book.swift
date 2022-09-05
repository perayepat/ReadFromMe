//
//  Book.swift
//  ReadFromMe
//
//  Created by Pat on 2022/09/05.
//

import Foundation
import UIKit

struct Book{
    let title:String
    let author: String
    //tell it that it might have to load a book
    
    var image: UIImage{
        Library.loadImage(forBook: self)
        ??
        LibrarySymbol.letterSquare(letter: title.first).image
    }
}
