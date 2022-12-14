//
//  Book.swift
//  ReadFromMe
//
//  Created by Pat on 2022/09/05.
//

import Foundation
import UIKit

struct Book:Hashable{
    let title:String
    let author: String
    var review: String?
    var readMe: Bool
    //tell it that it might have to load a book
    var image: UIImage?
//        Library.loadImage(forBook: self)
//        ??
//        LibrarySymbol.letterSquare(letter: title.first).image
    
    static let mockBook = Book(title: "", author: "", readMe: true)
}

extension Book: Codable{
    enum CodingKeys: String, CodingKey{
        case title
        case author
        case review
        case readMe
    }
}
