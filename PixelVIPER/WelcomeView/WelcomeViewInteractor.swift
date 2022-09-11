//
//  WelcomeViewInteractor.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 18.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation

final class WelcomeViewInteractor:PresenterToInteractorWelcomeViewProtocol {
    
    let defaults = UserDefaults.standard
    
    var presenter: InteractorToPresenterWelcomeViewProtocol?

    
    let contentOfView = [
        ["image":"painter","mainText":"Thank you for downloading","secondText":"You can draw any pixel image"],
        ["image":"nft","mainText":"Draw your first NFT like Punks","secondText":"Load any image and draw pixels over it (edit previous works) "],
        ["image":"art","mainText":"Save works at device or application","secondText":"You can choose jpg or png extension, size of cells in settings"]]
    
    func previousWelcomeView(currentPage: Int) {
        
        let currentPage_ = currentPage - 1
        
        guard let mainText = contentOfView[currentPage_]["mainText"], let secondText = contentOfView[currentPage_]["secondText"], let image = contentOfView[currentPage_]["image"] else {
             presenter?.previousWelcomeView(currentPage:currentPage_,mainText: "Empty",secondText: "error",image: "painter")
            return
        }
        
        presenter?.previousWelcomeView(currentPage:currentPage_,mainText: mainText,secondText: secondText,image: image)
    }
    
    
    
    func skipWelcomeViews_() {
        
    }
    
    func nextWelcomeView(currentPage: Int) {
        let currentPage_ = currentPage + 1
        
        
        guard let mainText = contentOfView[currentPage_]["mainText"], let secondText = contentOfView[currentPage_]["secondText"], let image = contentOfView[currentPage_]["image"] else {
             presenter?.nextWelcomeView(currentPage:currentPage_,mainText: "Empty",secondText: "error",image: "painter")
            return
        }
        
        presenter?.nextWelcomeView(currentPage:currentPage_,mainText: mainText,secondText: secondText,image: image)
    }
    
    func openMainView(from:WelcomeViewViewController) {
        
        defaults.set(true, forKey: Constants.isOpenedKey)
        
        presenter?.enterToMainView(from: from)
    }
    
    
}
