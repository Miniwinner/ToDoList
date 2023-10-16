//
//  MainConfigurator.swift
//  ToDoList
//
//  Created by Александр Кузьминов on 13.10.23.
//

import Foundation
import UIKit



class MainConfigurator {
    static func config(showMenuDelegate: ShowMenuProtocol) -> UIViewController {
        let vc = ListViewController()
        let presenter = PresenterList()
        vc.presenter = presenter
        presenter.view = vc
        vc.delegate = showMenuDelegate 
        return vc
    }
}


