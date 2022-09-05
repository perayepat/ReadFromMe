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
        let book = Library.books[indexPath.row]
        return DetailViewController(coder: coder, book: book)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
   

    
    // MARK:- Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      Library.books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
      let book = Library.books[indexPath.row]
      cell.textLabel?.text = book.title
      cell.imageView?.image = book.image
      return cell
    }

}

//MARK: - DataSource
extension LibraryViewController{

}
