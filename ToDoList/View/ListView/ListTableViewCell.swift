//
//  ListCollectionViewCell.swift
//  ToDoList
//
//  Created by Александр Кузьминов on 13.10.23.
//

import UIKit

protocol TapProtocol: AnyObject {
    func didTap(bool: Bool, id: Int)
    
    func didTapDone(bool:Bool,id:Int)
}

//protocol DoneProtocol: AnyObject{
//
//}

class ListTableViewCell: UITableViewCell {
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var delegate: TapProtocol?
    
    //var delegateDone: DoneProtocol?
    
    var previousBackgroundColor: UIColor?
    
    lazy var labelText:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    lazy var buttonIsDone:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var labelID:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .clear
        return label
    }()
    
    lazy var buttonIsFavourite:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(favoriteButtonAction), for: .touchUpInside)
        return button
    }()
    
    func setupUI(){
        self.addSubview(labelText)
        contentView.addSubview(buttonIsFavourite)
        contentView.addSubview(buttonIsDone)
        self.addSubview(labelID)
        self.layer.cornerRadius = 12
        self.selectionStyle = .none
    }
    
    func setupColor(color: UIColor) {
        self.backgroundColor = color
    }
    
    
    
    func configUIData(with model:Note){
        labelText.text = model.text
        labelID.text = "\(model.id)"
        buttonSelected(favourite: model.isFavourite)
        doneSelected(done: model.isDone)
    }
    
    //MARK: DONE BUTTON
    
    func doneSelected(done:Bool){
       
               
        if done == true {
            buttonIsDone.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
            self.layer.borderColor = CGColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            self.layer.borderWidth = 2
        }else{
            buttonIsDone.setImage(UIImage(systemName: "checkmark.seal"), for: .normal)
            self.layer.borderColor = .none
            self.layer.borderWidth = 0
        }
    }
    
    @objc func doneButtonAction(){
        
        if buttonIsDone.imageView?.image == UIImage(systemName: "checkmark.seal.fill") {
            doneSelected(done: false)
            buttonIsDone.isSelected = !buttonIsDone.isSelected
            delegate?.didTapDone(bool: false, id: Int(labelID.text!) ?? 0)
            self.layer.borderColor = .none
            self.layer.borderWidth = 0
        } else if buttonIsDone.imageView?.image == UIImage(systemName: "checkmark.seal"){
            self.backgroundColor = previousBackgroundColor
            doneSelected(done: true)
            buttonIsDone.isSelected = !buttonIsDone.isSelected
            delegate?.didTapDone(bool: true, id: Int(labelID.text!) ?? 0)
            self.layer.borderColor = CGColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            self.layer.borderWidth = 2
        }
    }
    
    //MARK: FAVOURITE BUTTON
    
    func buttonSelected(favourite: Bool) {
        favourite ? buttonIsFavourite.setImage(UIImage(named: "Done"), for: .normal) : buttonIsFavourite.setImage(UIImage(named: "None"), for: .normal)
    }
    
    
    
    @objc func favoriteButtonAction() {
        if buttonIsFavourite.imageView?.image == UIImage(named: "Done")  {
            buttonSelected(favourite: false)
            buttonIsFavourite.isSelected = !buttonIsFavourite.isSelected
            delegate?.didTap(bool: false, id: Int(labelID.text!) ?? 0)
            
        } else if buttonIsFavourite.imageView?.image == UIImage(named: "None") {
            buttonSelected(favourite: true)
            buttonIsFavourite.isSelected = !buttonIsFavourite.isSelected
            delegate?.didTap(bool: true, id: Int(labelID.text!) ?? 0)
        }
    }
    
    func configLayout(){
        NSLayoutConstraint.activate([
            labelText.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            labelText.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 60),
            labelText.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
            labelText.heightAnchor.constraint(equalToConstant: 30),
            
            buttonIsDone.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonIsDone.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            buttonIsDone.heightAnchor.constraint(equalToConstant: 15),
            buttonIsDone.widthAnchor.constraint(equalToConstant: 15),
            
            buttonIsFavourite.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonIsFavourite.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
            buttonIsFavourite.heightAnchor.constraint(equalToConstant: 15),
            buttonIsFavourite.widthAnchor.constraint(equalToConstant: 15),
        ])
        
    }
    
    
}
