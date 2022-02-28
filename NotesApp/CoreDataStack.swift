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
    
    func saveCategory(with name: String) {
        let context = context
        
        let category = Category(context: context)
        category.name = name
        
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
    }
}
