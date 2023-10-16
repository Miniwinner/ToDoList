//
//  MenuConfigurator.swift
//  ToDoList
//
//  Created by Александр Кузьминов on 15.10.23.
//

import Foundation

class MenuConfigurator {
    static func configureMenuViewController() -> MenuViewController {
        let menuVC = MenuViewController()
        let presenter = PresenterList()
        menuVC.presenter = presenter
        presenter.view = menuVC
        return menuVC
    }
}
