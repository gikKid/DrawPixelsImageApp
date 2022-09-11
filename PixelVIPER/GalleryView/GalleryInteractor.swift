//
//  GalleryInteractor.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 20.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

final class GalleryInteractor:PresenterToInteractorGalleryProtocol {
    
    var imageNames = [String]()
    let defaults = UserDefaults.standard
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    var presenter: InteractorToPresenterGalleryProtocol?
    
    init() {
        getSavedImageNames(namesArray: &imageNames)
    }
    
    func loadImage_(imageName: String, imageView: UIImageView) {
        let fileURL = documentsUrl.appendingPathComponent(imageName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            imageView.image = UIImage(data: imageData)
        } catch {
            presenter?.errorLoadImage(errorMessage: "Coudnt load this image, try it again!")
        }
    }
    
    func deleteImage(imageName: String) {
        getSavedImageNames(namesArray: &imageNames)
        let fileManager = FileManager.default
        let imagePath = getDocumenetsDirectory().appendingPathComponent(imageName)
        do {
            try fileManager.removeItem(at: imagePath)
            
            for (index, name) in imageNames.enumerated() {
                if name == imageName {
                    imageNames.remove(at: index)
                    presenter?.successfulDeleteImage(newImageNamesArray: imageNames)
                    
                    let fileManager = FileManager.default
                    let imagePath = getDocumenetsDirectory().appendingPathComponent(imageName)
                    do {
                        try fileManager.removeItem(at: imagePath)
                    } catch {
                        presenter?.errorDeleteImage(errorMessage: "Deletion error image from your device")
                    }
                    
                    if let savedNames = try? NSKeyedArchiver.archivedData(withRootObject: self.imageNames, requiringSecureCoding: false) {
                        self.defaults.set(savedNames, forKey: Constants.imageNamesUserDefaultKey)
                    }
                    else {
                        presenter?.errorDeleteImage(errorMessage: "Coudnt save changes")
                    }
                    return
                }
            }
        } catch {
            presenter?.errorDeleteImage(errorMessage: "Deletion error")
        }
    }
    
}
