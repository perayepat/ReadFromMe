//
//  BookCell.swift
//  ReadFromMe
//
//  Created by Pat on 2022/09/05.
//

import Foundation
import UIKit

class BookCell: UITableViewCell{
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var reviewLabel: UILabel!
    
    @IBOutlet var readMeBookmark: UIImageView!
    @IBOutlet var bookThumbnail: UIImageView!
}
