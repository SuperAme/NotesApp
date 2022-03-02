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
            loadNotes()
        }
    }
    
    @IBOutlet var listNotesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listNotesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNotes()
        self.tableView.reloadData()
    }
    
    func loadNotes() {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        request.predicate = categoryPredicate
        
        do {
            notesArray = try manager.context.fetch(request)
        } catch {
            print("Error fetching notes \(error.localizedDescription)")
        }
    }
    
    func deleteNotes(at index: Int) {
        manager.context.delete(notesArray[index])
        notesArray.remove(at: index)
        
        do {
            try manager.context.save()
        } catch {
            print(error.localizedDescription)
        }
        
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
