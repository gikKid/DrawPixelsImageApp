//
//  GalleryProtocols.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 20.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

//MARK: - View input (View -> Presenter)
protocol ViewToPresenterGalleryProtocol {
    var view:PresenterToViewGalleryProtocol? {get set}
    var router:PresenterToRouterGalleryProtocol? {get set}
    var interactor:PresenterToInteractorGalleryProtocol? {get set}
    func reloadCollection(collectionView:UICollectionView)
    func loadImage(imageName:String,imageView:UIImageView)
    func deleteImage(imageName:String)
    func editPicture()
    func savePicture(imageName:String)
    func checkTheme(view:UIView,collectionView:UICollectionView)
}

//MARK: - View otput (Presenter -> View)
protocol PresenterToViewGalleryProtocol {
    func errorLoadImage(errorMessage:String)
    func showDeleteAlert(alertController:UIAlertController)
    func successfulReloadContent(newImageNamesArray:[String])
    func showFailureDeleteImage(errorMessage:String)
    func showSaveActivityView(activityVC:UIActivityViewController)
    func failureShowActivityView(errorMessage:String)
}

//MARK: - Interactor input (Presenter -> Interactor)
protocol PresenterToInteractorGalleryProtocol {
    var presenter:InteractorToPresenterGalleryProtocol? {get set}
    func loadImage_(imageName:String,imageView:UIImageView)
    func deleteImage(imageName:String)
}

//MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterGalleryProtocol {
    func errorLoadImage(errorMessage:String)
    func successfulDeleteImage(newImageNamesArray:[String])
    func errorDeleteImage(errorMessage:String)
}

//MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterGalleryProtocol {
    static func createModule(rootTabBar:UITabBarController) -> GalleryViewController
    func showDeleteAlert(imageName:String,interactor:PresenterToInteractorGalleryProtocol?,view:PresenterToViewGalleryProtocol?)
    func showActivityAlert(imageName:String, interactor:PresenterToInteractorGalleryProtocol?,view:PresenterToViewGalleryProtocol?)
}
