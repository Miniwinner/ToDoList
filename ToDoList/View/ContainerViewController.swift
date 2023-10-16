//
//  ContainerViewController.swift
//  ToDoList
//
//  Created by Александр Кузьминов on 15.10.23.
//

import UIKit

class ContainerViewController: UIViewController,ShowMenuProtocol {
    
    
    
    var controller: UIViewController!
    var menuViewController: UIViewController!
    var bool:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureListVC()
    }
    

    
    func configureListVC(){
        let listVC = MainConfigurator.config(showMenuDelegate: self)
   
        controller = listVC
        view.addSubview(controller.view)
        addChild(controller)
    }
    
  
    
    func configureMenuVC(){
        if menuViewController == nil{
            
            menuViewController = MenuConfigurator.configureMenuViewController()
            view.insertSubview(menuViewController.view, at: 0)
            addChild(menuViewController)
            
        }else{
            
        }
    }
    func showMenuVC(bool:Bool){
        if bool == true{
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                self.controller.view.frame.origin.x = self.controller.view.frame.width - 140
            },
                           completion: { (finished) in
                
            })
        }else{
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                self.controller.view.frame.origin.x = 0
            },
                           completion: { (finished) in
                
            })
        }
    }
    
    func toogleMenu() {
        configureMenuVC()
        bool = !bool
        showMenuVC(bool: bool)
    }
}
