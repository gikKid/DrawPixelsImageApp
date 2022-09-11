//
//  GalleryRouter.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 20.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

final class GalleryRouter:PresenterToRouterGalleryProtocol {
    
    func showDeleteAlert(imageName: String, interactor: PresenterToInteractorGalleryProtocol?, view: PresenterToViewGalleryProtocol?) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
            interactor?.deleteImage(imageName: imageName)
        })
        alertController.addAction(deleteAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        view?.showDeleteAlert(alertController: alertController)
    }
    
    
    
    static func createModule(rootTabBar:UITabBarController) -> GalleryViewController {
        let galleryVC = GalleryViewController(rootTabBar: rootTabBar)
        
        return galleryVC
    }
    
    func showActivityAlert(imageName: String, interactor: PresenterToInteractorGalleryProtocol?, view: PresenterToViewGalleryProtocol?) {
        
        let savingImage = UIImageView()
        interactor?.loadImage_(imageName: imageName, imageView: savingImage)
        guard let image = savingImage.image else {
            view?.failureShowActivityView(errorMessage: "Coudnt get drawing image")
            return}
        let activityVC = UIActivityViewController(activityItems: [image],applicationActivities: nil)
        view?.showSaveActivityView(activityVC: activityVC)
    }
    
    
}
