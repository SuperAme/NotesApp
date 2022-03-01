//
//  NotesTableViewController.swift
//  NotesApp
//
//  Created by Américo MQ on 25/02/22.
//

import Foundation
import UIKit

class ListNoteTableViewController: UITableViewController {
    
    let manager = CoreDataStack()
    
    var notes = ["Note one","Note two","Note three","Note Four"]
    var selectedCategory: Category? {
        didSet {
//            loadNotes()
            //            print(selectedCategory)
        }
    }
    
    @IBOutlet var listNotesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        listNotesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func onAddBtnPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToNotes", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! NotesViewController
        destinationVC.category = selectedCategory
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row]
        return cell
    }
}
