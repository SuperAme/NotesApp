//
//  NotesTableViewController.swift
//  NotesApp
//
//  Created by Américo MQ on 25/02/22.
//

import Foundation
import UIKit

class ListNoteTableViewController: UITableViewController {
    
    var notes = ["Note one","Note two","Note three","Note Four"]
    @IBOutlet var listNotesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        listNotesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    @IBAction func onAddButtonPressed(_ sender: UIBarButtonItem) {
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
