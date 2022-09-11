//
//  WelcomeViewProtocols.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 18.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit


//MARK: - View input (View -> Presenter)
protocol ViewToPresenterWelcomeViewProtocol {
    
    var view:PresenterToViewWelcomeViewProtocol? {get set}
    var interactor:PresenterToInteractorWelcomeViewProtocol? {get set}
    var router:PresenterToRouterWelcomeViewProtocol? {get set}
    func skipWelcomeViews(from view:WelcomeViewViewController)
    func userTapNextWelcomeView(currentPage:Int)
    func userTapBackButton(currentPage:Int)
    func userEnterToMainView(from view:WelcomeViewViewController)
}

//MARK: - View Output (Presenter -> View)
protocol PresenterToViewWelcomeViewProtocol {
    func onNextWelcomeView(currentPage:Int,mainText:String,secondText:String,image:String)
    func onUserTapBackButton(currentPage:Int,mainText:String,secondText:String,image:String)
}

//MARK: - Interactor input (Presenter -> Interactor)
protocol PresenterToInteractorWelcomeViewProtocol {
    var presenter: InteractorToPresenterWelcomeViewProtocol? {get set}
    func nextWelcomeView(currentPage:Int)
    func previousWelcomeView(currentPage:Int)
    func openMainView(from view:WelcomeViewViewController)
}

//MARK: - Interactoir Output (Interactor -> Presenter)
protocol InteractorToPresenterWelcomeViewProtocol {
    func enterToMainView(from view:WelcomeViewViewController)
    func nextWelcomeView(currentPage:Int,mainText:String,secondText:String,image:String)
    func previousWelcomeView(currentPage:Int,mainText:String,secondText:String,image:String)
}

//MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterWelcomeViewProtocol {
    static func createModule() -> UINavigationController
    func pushToMainView(from view:WelcomeViewViewController)
}
