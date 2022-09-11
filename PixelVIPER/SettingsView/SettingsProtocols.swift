//
//  SettingsProtocols.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 20.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

//MARK: - View input (View -> Presenter)
protocol ViewToPresenterSettingsProtocol {
    var view:PresenterToViewSettingsProtocol? {get set}
    var router:PresenterToRouterSettingsProtocol? {get set}
    var interactor:PresenterToInteractorSettingsProtocol? {get set}
    
    func userTapTwitterButton()
    func userTapTelegramButton()
    func userCopyMail()
    func userTapSwitchTheme(switcher:UISwitch, sizePicker:UIPickerView,extensionPicker:UIPickerView,tabbar:UITabBarController,view:UIView)
    func viewDidLoad(switcher:UISwitch, sizePicker:UIPickerView,extensionPicker:UIPickerView,tabbar:UITabBarController,view:UIView)
}

//MARK: - View output (Presenter -> View)
protocol PresenterToViewSettingsProtocol {
    func onSuccessfulTapTwitterButton(url:URL)
    func onFailureTapTwitterButton(errorMessage:String)
    func onSuccessfulTapTelegramButton(url:URL)
    func onFailureTapTelegramButton(errorMessage:String)
    
}

//MARK: - Interactor input (Presenter -> Interactor)
protocol PresenterToInteractorSettingsProtocol {
    var presenter:InteractorToPresenterSettingsProtocol? {get set}
    
    func tapTwitterButton()
    func tapTelegramButton()
    func showCopyMailView()
}

//MARK: - Interactor output (Interactor -> Presenter)
protocol InteractorToPresenterSettingsProtocol {
    func successfulTapTwitterButton(url:URL)
    func failureTapTwitterButton(errorMessage:String)
    func successfulTapTelegramButton(url:URL)
    func failureTapTelegramButton(errorMessage:String)
    
}

//MARK: - Router input (Presenter -> Router)
protocol PresenterToRouterSettingsProtocol {
    static func createModule(rootTabBar:UITabBarController) -> SettingsViewController
}
