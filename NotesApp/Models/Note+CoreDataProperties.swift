//
//  Note+CoreDataProperties.swift
//  NotesApp
//
//  Created by Américo MQ on 28/02/22.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var parentCategory: Category?

}

extension Note : Identifiable {

}
