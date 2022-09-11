//
//  SettingsPresenter.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 20.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

final class SettingsPresenter:ViewToPresenterSettingsProtocol {

    var view: PresenterToViewSettingsProtocol?
    var router: PresenterToRouterSettingsProtocol?
    var interactor: PresenterToInteractorSettingsProtocol?
    
    func userTapTwitterButton() {
        interactor?.tapTwitterButton()
    }
    
    func userTapTelegramButton() {
        interactor?.tapTelegramButton()
    }
    
    func userCopyMail() {
        interactor?.showCopyMailView()
    }
    
    func userTapSwitchTheme(switcher: UISwitch, sizePicker: UIPickerView, extensionPicker: UIPickerView,tabbar:UITabBarController,view:UIView) {
        if !switcher.isOn {
            UserDefaults.standard.set("dark", forKey: Constants.keyTheme)
            tabbar.overrideUserInterfaceStyle = .dark
            extensionPicker.overrideUserInterfaceStyle = .dark
            sizePicker.overrideUserInterfaceStyle = .dark
            view.backgroundColor = .black
            switcher.isOn = false

        }
        else {
            UserDefaults.standard.set("light", forKey: Constants.keyTheme)
            tabbar.overrideUserInterfaceStyle = .light
            extensionPicker.overrideUserInterfaceStyle = .light
            sizePicker.overrideUserInterfaceStyle = .light
            view.backgroundColor = .white
            switcher.isOn = true
        }
    }
    
    func viewDidLoad(switcher: UISwitch, sizePicker: UIPickerView, extensionPicker: UIPickerView, tabbar: UITabBarController, view: UIView) {
        if let theme = UserDefaults.standard.string(forKey: Constants.keyTheme){
            if theme == "dark" {
                switcher.isOn = false
                tabbar.overrideUserInterfaceStyle = .dark
                extensionPicker.overrideUserInterfaceStyle = .dark
                sizePicker.overrideUserInterfaceStyle = .dark
                view.backgroundColor = .black
            }
            else {
                switcher.isOn = true
                tabbar.overrideUserInterfaceStyle = .light
                extensionPicker.overrideUserInterfaceStyle = .light
                sizePicker.overrideUserInterfaceStyle = .light
                view.backgroundColor = .white
            }
        }
    }
    
}

extension SettingsPresenter:InteractorToPresenterSettingsProtocol {
    func successfulTapTwitterButton(url: URL) {
        view?.onSuccessfulTapTwitterButton(url: url)
    }
    
    func failureTapTwitterButton(errorMessage: String) {
        view?.onFailureTapTwitterButton(errorMessage: errorMessage)
    }
    
    func successfulTapTelegramButton(url: URL) {
        view?.onSuccessfulTapTelegramButton(url: url)
    }
    
    func failureTapTelegramButton(errorMessage: String) {
        view?.onFailureTapTelegramButton(errorMessage: errorMessage)
    }
    
    
}
