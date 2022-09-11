//
//  GalleryPresenter.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 20.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

final class GalleryPresenter:ViewToPresenterGalleryProtocol {

    var view: PresenterToViewGalleryProtocol?
    var router: PresenterToRouterGalleryProtocol?
    var interactor: PresenterToInteractorGalleryProtocol?
    
    func reloadCollection(collectionView: UICollectionView) {
        
    }
    
    func deleteImage(imageName: String) {
        router?.showDeleteAlert(imageName: imageName, interactor: interactor, view: view)
    }
    
    func editPicture() {
        
    }
    
   func savePicture(imageName: String) {
        router?.showActivityAlert(imageName: imageName, interactor: interactor, view: view)
    }
    
    func loadImage(imageName: String, imageView: UIImageView) {
        interactor?.loadImage_(imageName: imageName, imageView: imageView)
    }
    
    func checkTheme(view:UIView,collectionView:UICollectionView) {
        if let theme = UserDefaults.standard.string(forKey: Constants.keyTheme){
            if theme == "dark" {
                view.backgroundColor = .black
                collectionView.backgroundColor = .black
            }
            else {
                view.backgroundColor = .white
                collectionView.backgroundColor = .white
            }
        }
    }
    
    
}

extension GalleryPresenter:InteractorToPresenterGalleryProtocol {
    func successfulDeleteImage(newImageNamesArray:[String]) {
        view?.successfulReloadContent(newImageNamesArray:newImageNamesArray)
    }
    
    func errorDeleteImage(errorMessage: String) {
        view?.showFailureDeleteImage(errorMessage: errorMessage)
    }
    
    func errorLoadImage(errorMessage: String) {
        view?.errorLoadImage(errorMessage: errorMessage)
    }
    
    
}
