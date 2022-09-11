//
//  WelcomeViewRouter.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 18.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

final class WelcomeViewRouter: PresenterToRouterWelcomeViewProtocol {
    static func createModule() -> UINavigationController {
        let welcomeVC = WelcomeViewViewController()
        
        let navController = UINavigationController(rootViewController: welcomeVC)
        
        let presenter:(ViewToPresenterWelcomeViewProtocol & InteractorToPresenterWelcomeViewProtocol) = WelcomeViewPresenter()
        
        welcomeVC.presenter = presenter
        welcomeVC.presenter?.router = WelcomeViewRouter()
        welcomeVC.presenter?.view = welcomeVC
        welcomeVC.presenter?.interactor = WelcomeViewInteractor()
        welcomeVC.presenter?.interactor?.presenter = presenter
        
        return navController
    }
    
    func pushToMainView(from:WelcomeViewViewController) {
        DispatchQueue.main.async {
            let rootTabBarContoller = MainRouter.createModule()
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            window?.rootViewController = rootTabBarContoller
        }
    }
}
