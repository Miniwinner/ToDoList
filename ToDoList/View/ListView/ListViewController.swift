//
//  ViewController.swift
//  ToDoList
//
//  Created by Александр Кузьминов on 13.10.23.
//

import UIKit

protocol ViewListProtocol: AnyObject {
    func reloadData()
   
}

protocol ShowMenuProtocol{
    func toogleMenu()
}

class ListViewController: UIViewController,ViewListProtocol {

    var presenter:PresenterListProtocol?
    
    var delegate:ShowMenuProtocol?
    
    
    lazy var tableViewList:UITableView = {
        let collection = UITableView()
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    lazy var buttonMenu:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "list.bullet.circle"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonAdd:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(presentAddAlert), for: .touchUpInside)
        return button
    }()
    
    lazy var alertAdd: UIAlertController = {
        let alert = UIAlertController(title: "Добавить заметку", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Введите вашу заметку"
        }
        
        alert.addAction(UIAlertAction(title: "Готово", style: .default) { [weak self] _ in
            if let textField = alert.textFields?.first, let note = textField.text {
                self?.presenter?.addNote(note: note)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        return alert
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.didLoad()
        setupUI()
        configLayout()
    }

     @objc func presentAddAlert() {
        present(alertAdd, animated: true, completion: nil)
         alertAdd.textFields?.first?.text = ""
    }
    
    @objc func showMenu(){
        delegate?.toogleMenu()
    }
    
//
    
    func setupUI(){
        view.backgroundColor = .white

        
        tableViewList.delegate = self
        tableViewList.dataSource = self
        tableViewList.register(ListTableViewCell.self, forCellReuseIdentifier: "list")
        
        tableViewList.separatorStyle = .none
        
        view.addSubview(tableViewList)
        
        view.addSubview(buttonAdd)
        
        view.addSubview(buttonMenu)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableViewList.reloadData()
        }
    }
    
    func configLayout(){
        NSLayoutConstraint.activate([
            tableViewList.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            tableViewList.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            tableViewList.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5),
            tableViewList.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -5),
            
            buttonAdd.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            buttonAdd.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -17),
            buttonAdd.heightAnchor.constraint(equalToConstant: 30),
            buttonAdd.widthAnchor.constraint(equalToConstant: 30),
            
            buttonMenu.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            buttonMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            buttonMenu.widthAnchor.constraint(equalToConstant: 30),
            buttonMenu.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}

extension ListViewController:UITableViewDelegate,UITableViewDataSource{
       
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true // Включите редактирование для всех строк
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.removeNoteAtIndex(index: indexPath.section)
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.count() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewList.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! ListTableViewCell
        
        if indexPath.section % 2 != 0 {
            cell.setupColor(color: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00))
        } else {
            cell.setupColor(color: UIColor(red: 0.94, green: 0.96, blue: 0.97, alpha: 1.00))
        }
        
//        guard let model = self.presenter?.notes, indexPath.section < model.count else { return UITableViewCell() }
//        guard let modelDone = self.presenter?.doneNotes, indexPath.section < modelDone.count else { return UITableViewCell() }
//        guard let modelFav = self.presenter?.favouriteNotes, indexPath.section < modelFav.count else { return UITableViewCell() }
//
//        switch presenter?.selectedGroup {
//        case .All:
//            cell.configUIData(with: model[indexPath.section])
//        case .Done:
//            cell.configUIData(with: modelDone[indexPath.section])
//        case .Fav:
//            cell.configUIData(with: modelFav[indexPath.section])
//        default:
//            break
//        }


        
        guard let model = self.presenter?.notes else { return UITableViewCell() }

        
        
        cell.configUIData(with: model[indexPath.section])
        cell.delegate = self
        return cell
    }
    
    
}

extension ListViewController: TapProtocol {
    func didTapDone(bool: Bool, id: Int) {
        presenter?.changeIsDone(bool: bool, id: id)
    }
    
    func didTap(bool: Bool, id: Int) {
        presenter?.changeIsFavorite(bool: bool, id: id)
    }
}




