//
//  EntryController.swift
//  JournalCoreData
//
//  Created by stanley phillips on 1/18/21.
//

import CoreData

class EntryController {
    // MARK: - Properties
    static let shared = EntryController()
    var entries: [Entry] = []
    private lazy var fetchRequest: NSFetchRequest<Entry> = {
        let request = NSFetchRequest<Entry>(entityName: "Entry")
        request.predicate = NSPredicate(value: true)
        
        return request
    }()
    
    // MARK: - CRUD
    func createEntryWith(title: String, bodyText: String) {
        Entry(title: title, bodyText: bodyText)
        CoreDataStack.saveContext()
    }
    
    func fetchEntries() {
        self.entries = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    func update(entry: Entry, title: String, bodyText: String) {
        entry.title = title
        entry.bodyText = bodyText
        CoreDataStack.saveContext()
    }
    
    func delete(entry: Entry) {
        guard let indexToDelete = entries.firstIndex(of: entry) else {return}
        entries.remove(at: indexToDelete)
        CoreDataStack.context.delete(entry)
        CoreDataStack.saveContext()
    }
}
