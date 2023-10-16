//
//  List+CoreDataProperties.swift
//  ToDoList
//
//  Created by Александр Кузьминов on 15.10.23.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var isFavourite: Bool
    @NSManaged public var isDone: Bool
    @NSManaged public var text: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: Int


}

extension List : Identifiable {

}
