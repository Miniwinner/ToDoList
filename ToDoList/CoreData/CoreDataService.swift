//
//  CoreDataService.swift
//  ToDoList
//
//  Created by Александр Кузьминов on 15.10.23.
//

import Foundation
import CoreData
import UIKit

import CoreData

class CoreDataService {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ListModel") // Замените "YourModelName" на имя вашей Core Data модели
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Core Data error: \(error)")
            }
        })
        return container
    }()

    var context: NSManagedObjectContext {
            return persistentContainer.viewContext
        }
    
    func fetchList() -> [List]? {
        let fetchRequest: NSFetchRequest<List> = List.fetchRequest()
        
        do {
            let models = try context.fetch(fetchRequest)
            return models
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Core Data save error: \(error)")
            }
        }
    }

    func changeIsFavorite(id: Int, isFavorite: Bool) {
        let context = persistentContainer.viewContext
        
        let request: NSFetchRequest<List> = List.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            if let note = try context.fetch(request).first {
                note.isFavourite = isFavorite
                saveContext()
            }
        } catch {
            print("Error changing favorite status: \(error)")
        }
    }
    
    func changeIsDone(id: Int, isDone: Bool) {
        let context = persistentContainer.viewContext
        
        let request: NSFetchRequest<List> = List.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            if let note = try context.fetch(request).first {
                note.isDone = isDone
                saveContext()
            }
        } catch {
            print("Error changing favorite status: \(error)")
        }
    }
    
    func addTask(text: String, isFavourite: Bool,id:Int,isDone:Bool) {
        let note = List(context: context)
        note.isDone = isDone
        note.id = id
        note.text = text
        note.isFavourite = isFavourite
        saveContext()
    }

    func updateTask(note: List, isFavourite: Bool,isDone: Bool) {
        note.isFavourite = isFavourite
        note.isDone = isDone
        saveContext()
    }

    func getAllTasks() -> [List] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<List> = List.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }


}

