//
//  MainProtocols.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 20.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

//MARK: -  View input (View -> Presenter)
protocol ViewToPresenterMainProtocol {
    var view:PresenterToViewMainProtocol? {get set}
    var interactor:PresenterToInteractorMainProtocol? {get set}
    var router:PresenterToRouterMainProtocol? {get set}
    
    func createEmptyCells(imageView:UIImageView)
    func userTapResetButton(imageView:UIImageView)
    func userTapLoadImageButton(viewController:MainViewController)
    func userTapSaveImageButton(imageView:UIImageView)
    func userTapShareButton(imageView:UIImageView)
    func pickImage(info: [UIImagePickerController.InfoKey : Any],imageView:UIImageView)
    func drawCell(imageView:UIImageView,currentPoint:CGPoint,currentButtonTag:Int?)
    func setCurrentColor(colorButton:UIButton)
    func userTapEraserButton()
    func userUntapEraserButton()
    func userTapPipeteButton()
    func userUntapPipeteButton()
    func userTapPaletteButton(VC:MainViewController)
    func changeColorFromPassedPalette(color:UIColor)
    func resizeCells(newSize:Int, imageView:UIImageView)
    func changeImageExtension(newExtension:String)
    func viewDidLoad()
    func changeImageToEditing(imageName:String,imageView:UIImageView)
    func checkTheme(tabbar:UITabBarController,view:UIView)
    func userTapBackActionButton(imageView:UIImageView)
    func userTapCancelPreviousActionButton(imageView:UIImageView)
    
}

//MARK: - View output (Presenter -> View)

protocol PresenterToViewMainProtocol {
    func onUserTapResetButton(confirmAlertController:UIAlertController)
    func onUserTapSuccessfulShareButton(activityVC:UIActivityViewController)
    func onUserTapFailureShareButton(errorMessage:String)
    func onUserTapLoadImageButton(pickerVC:UIImagePickerController)
    func changeColorAtWhiteButton(color:CGColor)
    func onUserTapPaletteButton(paletteVC:PaletteViewController)
    func showWriteTitleImageAlert(alertController:UIAlertController)
    func errorEmptyTextTitle(errorMessage:String)
    func errorSavingImage(errorMessage:String)
    func errorDeleteImageFromDocument(errorMessage:String)
    func errorLoadImageForEditing(errorMessage:String)
}

//MARK: - Interactor input (Presenter -> Interactor)
protocol PresenterToInteractorMainProtocol {
    var presenter:InteractorToPresenterMainProtocol? {get set}
    
    func createEmptyCells_(imageView:UIImageView)
    func drawCell_(imageView:UIImageView,currentPoint:CGPoint,currentButtonTag:Int?)
    func setCurrentColor_(colorButton:UIButton)
    func eraseButton()
    func unTapEraseButton()
    func tapPipeteButton()
    func unTapPipeteButton()
    func changeColorAtWhiteButton(color:UIColor)
    func changeSizeCells(newSize:Int,imageView:UIImageView)
    func changeExtension(newExtension:String)
    func saveImage(imageView:UIImageView,title:String)
    func viewDidLoad_()
    func loadImageForEditing(imageName:String,imageView:UIImageView)
    func makePreviousAction(imageView:UIImageView)
    func cancelPreviousAction(imageView:UIImageView)

}

//MARK: - Interactor output (Interactor -> Presenter)
protocol InteractorToPresenterMainProtocol {
    func colorFromPipete(color:CGColor)
    func failureSavingImage(errorMessage:String)
    func failureDeleteImageFromDocument(errorMessage:String)
    func failureLoadImageForEditing(errorMessage:String)
}

//MARK: - Router input (Presenter -> Router)
protocol PresenterToRouterMainProtocol {
    static func createModule() -> UITabBarController
    
    func showConfirmResetAlert(view:PresenterToViewMainProtocol?,interactor:PresenterToInteractorMainProtocol?,imageView:UIImageView)
    func showActivityVC(view:PresenterToViewMainProtocol?,imageView:UIImageView)
    func showPickerVC(view:PresenterToViewMainProtocol?,viewController:MainViewController)
    func showPaletteView(from VC:MainViewController)
    func showWriteImageNameAlert(imageView: UIImageView,interactor:PresenterToInteractorMainProtocol?,view:PresenterToViewMainProtocol?)
}
