//
//  Global functions.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 18.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

func settingWelcomeButtons(button:UIButton,text:String) {
    button.setTitle(text, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = UIColor(named: Constants.welcomeViewButtonColor)
    button.titleLabel?.textColor = .white
    button.layer.cornerRadius = 8
}

func createCustomButton (title:String) -> UIButton {
    let button = UIButton()
    button.setTitle(title, for: .normal)
    button.backgroundColor = UIColor(named: Constants.blueColorButton)
    button.tintColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 8
    return button
}

func errorAlertController(_ message:String) -> UIAlertController
{
    let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    return ac
}

func getDocumenetsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func getSavedImageNames( namesArray:inout [String]) {
    
    let defaults = UserDefaults.standard
    if let savedNamesImages = defaults.object(forKey: Constants.imageNamesUserDefaultKey) as? Data,let decodedNamesImages = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedNamesImages) as? [String] {
        namesArray = decodedNamesImages
    }
    else {
        defaults.set(namesArray, forKey: Constants.imageNamesUserDefaultKey)
    }
}
