//
//  MenuViewController.swift
//  ToDoList
//
//  Created by Александр Кузьминов on 15.10.23.
//

import UIKit



class MenuViewController: UIViewController,ViewListProtocol {
   
    var presenter:PresenterListProtocol?
    
    lazy var tableViewButtons:UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configLayout()
    }
    
    func  setupUI(){
        view.backgroundColor = UIColor(red: 0.94, green: 0.96, blue: 0.97, alpha: 1.00)

        tableViewButtons.delegate = self
        tableViewButtons.dataSource = self
        tableViewButtons.register(MenuTableViewCell.self, forCellReuseIdentifier: "button")
        view.addSubview(tableViewButtons)
    }
    
    func configLayout(){
        NSLayoutConstraint.activate([
            tableViewButtons.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            tableViewButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            tableViewButtons.heightAnchor.constraint(equalToConstant: 500),
            tableViewButtons.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    func reloadData() {
        
    }

}

extension MenuViewController:UITableViewDelegate,UITableViewDataSource{
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.count2() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewButtons.dequeueReusableCell(withIdentifier: "button", for: indexPath) as! MenuTableViewCell
        
        guard let model = self.presenter?.buttons else { return UITableViewCell() }

        cell.configData(model: model[indexPath.section])
        return cell
        
    }
    
    
}
