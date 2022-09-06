//
//  ViewController.swift
//  ReadFromMe
//
//  Created by Pat on 2022/09/05.
//

import UIKit

enum Section: String, CaseIterable{
    case addNew
    case readMe = "Read Me "
    case finished = "Finished"
}


class LibraryViewController: UITableViewController {
    var dataSource: LibraryDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //edit button
        navigationItem.rightBarButtonItem = editButtonItem
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "\(LibraryHeaderView.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: LibraryHeaderView.reuseIdentifier)
        configureDataSource()
        dataSource.upadate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.upadate()
    }
    
    
    
    @IBSegueAction func showingDetail(_ coder: NSCoder) -> DetailViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow,
              let book = dataSource.itemIdentifier(for: indexPath)
        else { fatalError("Nothing selected!") }
//        let book = Library.books[indexPath.row]

        return DetailViewController(coder: coder, book: book)
    }
    
    
    //MARK: - Delegate
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 1 ? "Read Me" : nil
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {return nil}
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: LibraryHeaderView.reuseIdentifier) as? LibraryHeaderView else {
            return nil
        }
        headerView.titleLabel.text = Section.allCases[section].rawValue
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // as long as its not the first section
        return section != 0 ? 60 : 0
    }
    
    
    
    
    
    
    //MARK: - Data Source
    func configureDataSource(){
        dataSource = LibraryDataSource(tableView: tableView, cellProvider: { tableView, indexPath, book in
            //Will return a cell same as row at
            if indexPath == IndexPath(row: 0, section:0){
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewBookCell", for: indexPath)
                return cell
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BookCell.self)", for: indexPath) as? BookCell
            else{fatalError("Could not create BookCell")}
            cell.bookTitleLabel.text = book.title
            cell.authorLabel.text = book.author
            cell.bookThumbnail.image = book.image ?? LibrarySymbol.letterSquare(letter: book.title.first).image
            cell.bookThumbnail.layer.cornerRadius = 12
            if let review = book.review{
                cell.reviewLabel.text = review
                cell.reviewLabel.isHidden = false
            }
            cell.readMeBookmark.isHidden = !book.readMe
            return cell
        })
    }
    
    func upadateDataSource(){
        //Snapshot of the data you want to display
        var newSnapshot = NSDiffableDataSourceSnapshot<Section, Book>()
        //new number of secitons method
        newSnapshot.appendSections(Section.allCases)
//        newSnapshot.appendItems(Library.books, toSection: .readMe)
        
        //Grouping by the books read me property
        let booksByReadMe: [Bool:[Book]] = Dictionary(grouping: Library.books, by: \.readMe)
        for (readMe, books) in booksByReadMe{
            newSnapshot.appendItems(books,toSection: readMe ? .readMe : .finished)
        }
        newSnapshot.appendItems([Book.mockBook], toSection: .addNew)
        dataSource.apply(newSnapshot, animatingDifferences: true)
    }
    
    ///Old Data Source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        2
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return section == 0 ? 1 : Library.books.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath == IndexPath(row: 0, section:0){
//            let cell = tableView.dequeueReusableCell(withIdentifier: "NewBookCell", for: indexPath)
//            return cell
//        }
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BookCell.self)", for: indexPath) as? BookCell
//        else{fatalError("Could not create BookCell")}
//        let book = Library.books[indexPath.row]
//        cell.bookTitleLabel.text = book.title
//        cell.authorLabel.text = book.author
//        cell.bookThumbnail.image = book.image
//        cell.bookThumbnail.layer.cornerRadius = 12
//        return cell
//
//    }
    
}
//MARK: - Custom Class
class LibraryHeaderView: UITableViewHeaderFooterView{
    static let reuseIdentifier = "\(LibraryHeaderView.self)"
    @IBOutlet var titleLabel: UILabel!
}

class LibraryDataSource: UITableViewDiffableDataSource<Section, Book>{
    func upadate(){
        //Snapshot of the data you want to display
        var newSnapshot = NSDiffableDataSourceSnapshot<Section, Book>()
        //new number of secitons method
        newSnapshot.appendSections(Section.allCases)
//        newSnapshot.appendItems(Library.books, toSection: .readMe)
        
        //Grouping by the books read me property
        let booksByReadMe: [Bool:[Book]] = Dictionary(grouping: Library.books, by: \.readMe)
        for (readMe, books) in booksByReadMe{
            newSnapshot.appendItems(books,toSection: readMe ? .readMe : .finished)
        }
        newSnapshot.appendItems([Book.mockBook], toSection: .addNew)
        apply(newSnapshot, animatingDifferences: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //SHould you be able to remove books
        //if the section is the add new section you can't delete it otherwise delete it
        indexPath.section == snapshot().indexOfSection(.addNew) ? false : true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //Editing styles that can appear on a cell
        if editingStyle == .delete{
            guard let book = self.itemIdentifier(for: indexPath) else {return} //make sure there's a book for that index path
            Library.delete(book: book)
            upadate()
        }
    }
}
