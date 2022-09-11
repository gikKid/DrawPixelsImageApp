//
//  SettingsRouter.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 20.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

final class SettingsRouter: PresenterToRouterSettingsProtocol {
    static func createModule(rootTabBar: UITabBarController) -> SettingsViewController {
        let settingsVC = SettingsViewController(rootTabBar: rootTabBar)
        return settingsVC
    }
    
    
}
