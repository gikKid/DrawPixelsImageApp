//
//  WelcomeViewPresenter.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 18.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation

final class WelcomeViewPresenter:ViewToPresenterWelcomeViewProtocol {
    
    
    var view: PresenterToViewWelcomeViewProtocol?
    var router: PresenterToRouterWelcomeViewProtocol?
    var interactor: PresenterToInteractorWelcomeViewProtocol?
    
    
    func skipWelcomeViews(from:WelcomeViewViewController) {
        UserDefaults.standard.set(true, forKey: Constants.isOpenedKey)
        router?.pushToMainView(from: from)
    }
    
    
    func userEnterToMainView(from: WelcomeViewViewController) {
        interactor?.openMainView(from: from)
    }
    
    func userTapNextWelcomeView(currentPage: Int) {
        interactor?.nextWelcomeView(currentPage: currentPage)
    }
    
    func userTapBackButton(currentPage: Int) {
        interactor?.previousWelcomeView(currentPage: currentPage)
    }
    
}

extension WelcomeViewPresenter:InteractorToPresenterWelcomeViewProtocol {
    
    func nextWelcomeView(currentPage: Int, mainText: String, secondText: String, image: String) {
        view?.onNextWelcomeView(currentPage: currentPage, mainText: mainText, secondText: secondText, image: image)
    }
    
    func previousWelcomeView(currentPage: Int, mainText: String, secondText: String, image: String) {
        view?.onUserTapBackButton(currentPage: currentPage, mainText: mainText, secondText: secondText, image: image)
    }
    
    func enterToMainView(from: WelcomeViewViewController) {
        router?.pushToMainView(from: from)
    }
    
    
    
}
