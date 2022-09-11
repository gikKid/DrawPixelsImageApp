//
//  GalleryCollectionViewCell.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 21.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import UIKit

protocol GalleryCellProtocol {
    func deleteImage(imageName:String)
    func failureDeleteImage(errorMessage:String)
    func saveImage(imageName:String)
    func failureSaveImage(errorMessage:String)
    func editImage(imageName:String)
    func failureEditImage(errorMessage:String)
}

final class GalleryCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let editButton = UIButton()
    let deleteButton = UIButton()
    let saveButton = UIButton()
    var buttonsArray = [UIButton]()
    
    var delegate:GalleryCellProtocol?
    
    static let identefier = "noteCell"
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) hasnt been implemented")
    }
    
    func setupCell() {
        self.backgroundColor = .clear
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.gray.cgColor
        
        self.setupButtons(button: saveButton, text: "Save")
        self.setupButtons(button: deleteButton, text: "Delete")
        self.setupButtons(button: editButton, text: "Edit")
        deleteButton.addTarget(self, action: #selector(tapDeleteButton(_:)), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(tapSaveButton(_:)), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(tapEditButton(_:)), for: .touchUpInside)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .boldSystemFont(ofSize: 25)
        nameLabel.textColor = UIColor(named: Constants.blueColorButton)
        
        
        self.addSubview(imageView)
        self.addSubview(nameLabel)
        self.addSubview(editButton)
        self.addSubview(deleteButton)
        self.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: self.frame.width),
            imageView.heightAnchor.constraint(equalToConstant: self.frame.height / 1.3),
            imageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 0),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 0),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 0),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            editButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 5),
            editButton.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10),
            saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: editButton.topAnchor),
            deleteButton.topAnchor.constraint(equalTo: editButton.topAnchor),
            deleteButton.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10)
            
        ])
    }
    
    private func setupButtons(button:UIButton,text:String) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 23)
    }
    
    @objc private func tapDeleteButton(_ sender:UIButton) {
        guard let imageName = self.nameLabel.text else {
            delegate?.failureDeleteImage(errorMessage: "Coudnt delete image")
            return}
        delegate?.deleteImage(imageName: imageName)
    }
    
    @objc private func tapSaveButton(_ sender:UIButton) {
        guard let imageName = nameLabel.text else {
            delegate?.failureSaveImage(errorMessage: "Coudnt save image")
            return
        }
        delegate?.saveImage(imageName: imageName)
    }
    
    @objc private func tapEditButton(_ sender:UIButton) {
        guard let imageName = self.nameLabel.text else {
            delegate?.failureEditImage(errorMessage: "Coudnt edit message")
            return
        }
        delegate?.editImage(imageName: imageName)
    }
    
    
    
}
