//
//  CoreDataStack.swift
//  NotesApp
//
//  Created by Américo MQ on 28/02/22.
//

import Foundation
import CoreData
import UIKit

class CoreDataStack {
    
    public static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NotesDataModel")
        container.loadPersistentStores { (desc, error) in
            if let error = error {
                print("Error Loading store \(desc) - \(error)")
                return
            }
            print("Database ready!")
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return Self.persistentContainer.viewContext
    }
    
    func loadCategories() -> [Category] {
        var categoryNotes = [Category]()
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categoryNotes = try context.fetch(request)
        } catch {
            print("Error Loading Categories - \(error)")
        }
        return categoryNotes
    }
    
    func loadNotes(with name: String) -> [Note] {
        var notesArray = [Note]()
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", name)
        
        request.predicate = categoryPredicate
        
        do {
            notesArray = try context.fetch(request)
        } catch {
            print("Error fetching notes \(error.localizedDescription)")
        }
        
        return notesArray
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
    }
}
