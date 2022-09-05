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
    var image: UIImage{
        LibrarySymbol.letterSquare(letter: title.first).image
    }
}
