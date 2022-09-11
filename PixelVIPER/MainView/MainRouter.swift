//
//  MainRouter.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 20.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

final class MainRouter: PresenterToRouterMainProtocol {
        
    func showPickerVC(view: PresenterToViewMainProtocol?, viewController: MainViewController) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = viewController as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        view?.onUserTapLoadImageButton(pickerVC: picker)
    }
    
    func showActivityVC(view: PresenterToViewMainProtocol?, imageView: UIImageView) {
        guard let image = imageView.image else {
            view?.onUserTapFailureShareButton(errorMessage:"Coudnt get drawing image")
            return}
        let activity = UIActivityViewController(activityItems: [image],applicationActivities: nil)
        view?.onUserTapSuccessfulShareButton(activityVC: activity)
    }
    
    func showConfirmResetAlert(view: PresenterToViewMainProtocol?, interactor: PresenterToInteractorMainProtocol?, imageView: UIImageView) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        let resetAction = UIAlertAction(title: "Reset", style: .destructive, handler: { _ in
            interactor?.createEmptyCells_(imageView: imageView)
        })
        alertController.addAction(resetAction)
        
        view?.onUserTapResetButton(confirmAlertController: alertController)
    }
    
    func showPaletteView(from VC: MainViewController) {
        let palleteVC = PaletteViewController()
        palleteVC.delegate = VC
        palleteVC.modalPresentationStyle = .overFullScreen
        VC.onUserTapPaletteButton(paletteVC:palleteVC)
    }
    
    func showWriteImageNameAlert(imageView: UIImageView, interactor: PresenterToInteractorMainProtocol?, view: PresenterToViewMainProtocol?) {
        
        let alertController = UIAlertController(title: "Save image", message: "Write title", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {[weak self] textField in
            guard let _ = self else {return}
            textField.placeholder = "Title"
        })
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { _ in
            if let text = alertController.textFields?[0].text, text != "" {
                interactor?.saveImage(imageView: imageView, title: text)
            }
            else {
                view?.errorEmptyTextTitle(errorMessage: "Fill the text field")
                return
            }
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(saveAction)
        view?.showWriteTitleImageAlert(alertController: alertController)
    }
    
    static func createModule() -> UITabBarController {
        let rootTabBarVC = RootTabBarViewController()
        
        return rootTabBarVC
    }
    
    
}
