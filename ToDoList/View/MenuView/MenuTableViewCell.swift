//
//  MenuTableViewCell.swift
//  ToDoList
//
//  Created by Александр Кузьминов on 15.10.23.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    lazy var labelText:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    lazy var iconImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    func setupUI(){
        self.addSubview(labelText)
        self.addSubview(iconImage)
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    func configData(model:Image){
        iconImage.image = UIImage(named: model.image)
        labelText.text = model.text
    }
    
    func configLayout(){
        NSLayoutConstraint.activate([
            labelText.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            labelText.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor,constant: 10),
            labelText.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10),
            labelText.heightAnchor.constraint(equalToConstant: 30),
            
            iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            iconImage.heightAnchor.constraint(equalToConstant: 30),
            iconImage.widthAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    
}
