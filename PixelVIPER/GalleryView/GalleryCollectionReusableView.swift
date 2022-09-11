//
//  GalleryCollectionReusableView.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 21.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import UIKit

final class GalleryCollectionReusableView: UICollectionReusableView {
    
    
    let label = UILabel()
    static let identefier = "headerCollectionReusableView"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My works"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 27)
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
        
}
