//
//  ViewController.swift
//  NotesApp
//
//  Created by Américo MQ on 25/02/22.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {

    private let manager = CoreDataStack()
    @IBOutlet var mainTableView: UITableView!
    
    var categoryNotes = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        loadCategories()
    }
    
    func saveCategory() {
        do {
            try manager.context.save()
        } catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categoryNotes = try manager.context.fetch(request)
        } catch {
            print("Error Loading Categories - \(error)")
        }
        
        tableView.reloadData()
    }
    
    func deleteCategory(at index: Int) {
        manager.context.delete(categoryNotes[index])
        categoryNotes.remove(at: index)
        
        saveCategory()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let categoryTitle = textField.text {
                let newCategory = Category(context: self.manager.context)
                newCategory.name = categoryTitle
                self.categoryNotes.append(newCategory)
                self.saveCategory()
//                print(categoryTitle)
            }
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add new category"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categoryNotes[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "NoteListSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ListNoteTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryNotes[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteCategory(at: indexPath.row)
        }
    }

}

