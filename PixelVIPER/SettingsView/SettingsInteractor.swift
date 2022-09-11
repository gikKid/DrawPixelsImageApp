//
//  SettingsInteractor.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 20.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

final class SettingsInteractor:PresenterToInteractorSettingsProtocol {
    
    var presenter: InteractorToPresenterSettingsProtocol?
    
    func tapTwitterButton() {
        guard let url = URL(string: Constants.twitterLink) else {
            presenter?.failureTapTwitterButton(errorMessage: "Coudnt get twitter link")
            return}
        presenter?.successfulTapTwitterButton(url: url)
    }
    
    func tapTelegramButton() {
        guard let url = URL(string: Constants.telegramLink) else {
            presenter?.failureTapTelegramButton(errorMessage: "Coudnt get telegram link")
            return}
        presenter?.successfulTapTelegramButton(url: url)
    }
    
    func showCopyMailView() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = Constants.mail
        
        SuccessfulCopiedMailAlert.instance.showView()
        
    }
    
}
