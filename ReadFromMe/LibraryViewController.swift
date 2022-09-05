//
//  ViewController.swift
//  ReadFromMe
//
//  Created by Pat on 2022/09/05.
//

import UIKit

class LibraryViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Library.books.count
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
