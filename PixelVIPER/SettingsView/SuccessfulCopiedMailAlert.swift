//
//  SuccessfulCopiedMailAlert.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 20.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import UIKit

final class SuccessfulCopiedMailAlert: UIView {
    
    let textLabel = UILabel()
    let imageView = UIImageView()
    let parentView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    let subView = UIView()

    static let instance = SuccessfulCopiedMailAlert()
    
    func showView() {
            
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Copying successfuly"
        textLabel.font = .systemFont(ofSize: 14)
        textLabel.textColor = .white
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "link.icloud")
        imageView.tintColor = .white
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.backgroundColor = .gray
        subView.layer.cornerRadius = 8
        subView.addSubview(textLabel)
        subView.addSubview(imageView)
        
        parentView.backgroundColor = UIColor.black.withAlphaComponent(0)
        parentView.isOpaque = false
        parentView.addSubview(subView)
        
        NSLayoutConstraint.activate([
            subView.widthAnchor.constraint(equalToConstant: 200),
            subView.heightAnchor.constraint(equalToConstant: 50),
            subView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            subView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            textLabel.rightAnchor.constraint(equalTo: subView.rightAnchor,constant: -5),
            textLabel.centerYAnchor.constraint(equalTo: subView.centerYAnchor),
            imageView.leftAnchor.constraint(equalTo: subView.leftAnchor,constant: 15),
            imageView.centerYAnchor.constraint(equalTo: subView.centerYAnchor)
        ])
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        window?.addSubview(parentView)
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.dismissAlert), userInfo: nil, repeats: false)
        
    }
    
    @objc private func dismissAlert() {
        parentView.removeFromSuperview()
    }

}
