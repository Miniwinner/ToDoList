//
//  Model.swift
//  ToDoList
//
//  Created by Александр Кузьминов on 13.10.23.
//

import Foundation

struct Note{
    var id: Int
    var text: String
    var creationDate: Date
    var isFavourite: Bool
    var isDone:Bool
}




struct Image{
    var image:String
    var text:String
}

enum DataConfig{
    case All
    case Done
    case Fav
}
