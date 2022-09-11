//
//  MainPresenter.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 20.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

final class MainPresenter:ViewToPresenterMainProtocol {
    
    var view: PresenterToViewMainProtocol?
    var interactor: PresenterToInteractorMainProtocol?
    var router: PresenterToRouterMainProtocol?
    

    func createEmptyCells(imageView: UIImageView) {
        interactor?.createEmptyCells_(imageView:imageView)
    }
    
    func userTapResetButton(imageView: UIImageView) {
        router?.showConfirmResetAlert(view: view, interactor: interactor, imageView: imageView)
    }
    
    func userTapShareButton(imageView: UIImageView) {
        router?.showActivityVC(view: view, imageView: imageView)
       }
    
    func userTapLoadImageButton(viewController:MainViewController) {
        router?.showPickerVC(view: view, viewController: viewController)
    }
    
    func pickImage(info: [UIImagePickerController.InfoKey : Any], imageView: UIImageView) {
        guard let image = info[.editedImage] as? UIImage else {return}
        let imageName = UUID().uuidString
        let imagePath = getDocumenetsDirectory().appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
            imageView.image = image
        }
    }
    
    func userTapSaveImageButton(imageView: UIImageView) {
        router?.showWriteImageNameAlert(imageView: imageView,interactor: interactor, view: view)
    }
    
    func drawCell(imageView: UIImageView, currentPoint: CGPoint,currentButtonTag:Int?) {
        interactor?.drawCell_(imageView: imageView, currentPoint: currentPoint,currentButtonTag:currentButtonTag)
    }
    
    func setCurrentColor(colorButton: UIButton) {
        interactor?.setCurrentColor_(colorButton: colorButton)
    }
    
    func userTapEraserButton() {
        interactor?.eraseButton()
    }
    
    func userUntapEraserButton() {
        interactor?.unTapEraseButton()
    }
    
    func userTapPipeteButton() {
        interactor?.tapPipeteButton()
    }
    
    func userUntapPipeteButton() {
        interactor?.unTapPipeteButton()
    }
    
    func userTapPaletteButton(VC: MainViewController) {
        router?.showPaletteView(from: VC)
    }
    
    func userTapBackActionButton(imageView: UIImageView) {
        interactor?.makePreviousAction(imageView: imageView)
    }
    
    func userTapCancelPreviousActionButton(imageView: UIImageView) {
        interactor?.cancelPreviousAction(imageView: imageView)
    }
    
    func changeColorFromPassedPalette(color: UIColor) {
        interactor?.changeColorAtWhiteButton(color: color)
    }
    
    func resizeCells(newSize: Int, imageView: UIImageView) {
        interactor?.changeSizeCells(newSize: newSize, imageView: imageView)
    }
    
    func changeImageExtension(newExtension: String) {
        interactor?.changeExtension(newExtension: newExtension)
    }
    
    func viewDidLoad() {
        interactor?.viewDidLoad_()
    }
    
    func changeImageToEditing(imageName: String, imageView: UIImageView) {
        interactor?.loadImageForEditing(imageName: imageName, imageView: imageView)
    }
    
    func checkTheme(tabbar: UITabBarController, view: UIView) {
        if let theme = UserDefaults.standard.string(forKey: Constants.keyTheme){
            if theme == "dark" {
                tabbar.overrideUserInterfaceStyle = .dark
                view.backgroundColor = .black
            }
            else {
                tabbar.overrideUserInterfaceStyle = .light
                view.backgroundColor = .white
            }
        }
    }
}

extension MainPresenter:InteractorToPresenterMainProtocol {
    func failureLoadImageForEditing(errorMessage: String) {
        view?.errorLoadImageForEditing(errorMessage: errorMessage)
    }
    
    func failureSavingImage(errorMessage: String) {
        view?.errorSavingImage(errorMessage: errorMessage)
    }
    
    func failureDeleteImageFromDocument(errorMessage: String) {
        view?.errorDeleteImageFromDocument(errorMessage: errorMessage)
    }
    
    func colorFromPipete(color: CGColor) {
        view?.changeColorAtWhiteButton(color: color)
    }
    
    
    
}
