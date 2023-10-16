//
//  PresenterList.swift
//  ToDoList
//
//  Created by Александр Кузьминов on 13.10.23.
//

import Foundation
import CoreData

    
protocol PresenterListProtocol {
    
    var rowModels:[Note] { get set }
    var notes:[Note] { get set }
    var buttons: [Image] { get set }
    var selectedGroup: DataConfig { get set }
    func addNote(note: String)
    
    func removeNoteAtIndex(index: Int)
    
    func changeIsDone(bool: Bool, id: Int)
    
    func refreshList()
    
    func count()-> Int
    
    func count2()->Int
    
    func didLoad()
    
    func changeIsFavorite(bool: Bool, id: Int)
    
}



class PresenterList: PresenterListProtocol {
    
    
   
    
    var rowModels:[Note] = []
    
    var selectedGroup: DataConfig = .All
    
    var maxId: Int = 0 

    
    var notes:[Note] = []
    
    var buttons:[Image] = [Image(image: "Done", text: "Favorite"),Image(image: "taskDone", text: "Done"),Image(image: "None", text: "All")]
    
    var coreDataService = CoreDataService()

    
    weak var view: ViewListProtocol?
    
    func addNote(note: String) {
        maxId += 1
        
        coreDataService.addTask(text: note, isFavourite: false, id: maxId, isDone: false)
      
        update()
    }

    func didLoad(){
        update()
    }


    
    private func update() {
        guard let dataModels = coreDataService.fetchList() else { return }
        rowModels = dataModels.compactMap ({ model in
            return Note(
                id: model.id,
                text: model.text ?? "N/A",
                creationDate: model.date ?? Date(timeIntervalSince1970: 0),
                isFavourite: model.isFavourite,
                isDone: model.isDone
            )
        })
        
        notes = rowModels
        view?.reloadData()
    }

    
    func removeNoteAtIndex(index: Int) {
        let notess = coreDataService.getAllTasks()
        if index >= 0 && index < notess.count {
            let note = notess[index]
            let context = coreDataService.context
            context.delete(note)
            coreDataService.saveContext()
            notes.remove(at: index)
            refreshList()
        }
    }
    
    
    func changeIsFavorite(bool: Bool, id: Int) {
        coreDataService.changeIsFavorite(id: id, isFavorite: bool)
    }

    func changeIsDone(bool: Bool, id: Int) {
        coreDataService.changeIsDone(id: id, isDone: bool)
    }

    
    func refreshList() {
        view?.reloadData()
    }
    
    func count() -> Int {
        return notes.count
    }
    
    func count2()->Int{
        return buttons.count
    }
    
}
