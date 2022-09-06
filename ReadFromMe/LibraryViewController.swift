//
//  ViewController.swift
//  ReadFromMe
//
//  Created by Pat on 2022/09/05.
//

import UIKit

class LibraryViewController: UITableViewController {
    
    @IBSegueAction func showingDetail(_ coder: NSCoder) -> DetailViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow
        else { fatalError("Nothing selected!") }
        let book = Library.books[indexPath.row - 1]
        return DetailViewController(coder: coder, book: book)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    //MARK: - Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Library.books.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == IndexPath(row: 0, section:0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewBookCell", for: indexPath)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BookCell.self)", for: indexPath) as? BookCell
        else{fatalError("Could not create BookCell")}
        let book = Library.books[indexPath.row - 1]
        cell.bookTitleLabel?.text = book.title
        cell.authorLabel?.text = book.author
        cell.bookThumbnail?.image = book.image
        cell.bookThumbnail.layer.cornerRadius = 10
        return cell
    }
    
}

