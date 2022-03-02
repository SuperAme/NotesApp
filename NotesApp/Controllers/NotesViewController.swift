//
//  NotesViewController.swift
//  NotesApp
//
//  Created by Américo MQ on 25/02/22.
//

import Foundation
import UIKit

class NotesViewController: UIViewController {
    
    let manager = CoreDataStack()
    
    var category: Category?
    
    @IBOutlet weak var descriptionNoteTextField: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onSaveButton(_ sender: UIBarButtonItem) {
        if let titleTf = titleTextField.text, let descr = descriptionNoteTextField.text {
            let newNote = Note(context: manager.context)
            newNote.title = titleTf
            newNote.descriptionText = descr
            newNote.parentCategory = self.category
            
            saveNote()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveNote() {
        do {
            try manager.context.save()
        } catch  {
            print("Error saving context \(error)")
        }
    }
}
