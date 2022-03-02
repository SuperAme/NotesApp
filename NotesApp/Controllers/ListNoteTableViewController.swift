//
//  NotesTableViewController.swift
//  NotesApp
//
//  Created by Américo MQ on 25/02/22.
//

import Foundation
import UIKit
import CoreData

class ListNoteTableViewController: UITableViewController {
    
    let manager = CoreDataStack()
    var notesArray = [Note]()
    
    var selectedCategory: Category? {
        didSet {
            notesArray = manager.loadNotes(with: selectedCategory!.name!)
        }
    }
    
    @IBOutlet var listNotesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listNotesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notesArray = manager.loadNotes(with: selectedCategory!.name!)
        self.tableView.reloadData()
    }
    
    func deleteNotes(at index: Int) {
        manager.context.delete(notesArray[index])
        notesArray.remove(at: index)
        
        manager.saveData()
        tableView.reloadData()
    }
    
    @IBAction func onAddBtnPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToNotes", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! NotesViewController
        destinationVC.category = selectedCategory
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath)
        cell.detailTextLabel?.text = notesArray[indexPath.row].descriptionText
        cell.textLabel?.text = notesArray[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteNotes(at: indexPath.row)
        }
    }
}
