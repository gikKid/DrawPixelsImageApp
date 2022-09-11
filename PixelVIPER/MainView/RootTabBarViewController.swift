//
//  RootTabBarViewController.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 20.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import UIKit

final class RootTabBarViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    private func setup() {
        
        let mainVC = MainViewController(rootTabBar:self)
        let mainTabBarItem = UITabBarItem(title: "Drawing", image: UIImage(systemName: "pencil.circle"), selectedImage: UIImage(systemName: "pencil.circle.fill"))
        
        let mainPresenter:(ViewToPresenterMainProtocol & InteractorToPresenterMainProtocol) = MainPresenter()
        
        mainVC.presenter = mainPresenter
        mainVC.presenter?.router = MainRouter()
        mainVC.presenter?.view = mainVC
        mainVC.presenter?.interactor = MainInteractor()
        mainVC.presenter?.interactor?.presenter = mainPresenter
        
        mainVC.tabBarItem = mainTabBarItem
        
        let mainVCNavigationController = UINavigationController()
        mainVCNavigationController.viewControllers = [mainVC]
        
        let galleryVC = GalleryRouter.createModule(rootTabBar: self)
        let galleryTabBarItem = UITabBarItem(title: "My collection", image: UIImage(systemName: "photo"), selectedImage: UIImage(systemName: "photo.fill"))
        
        let galleryPresenter:(ViewToPresenterGalleryProtocol
        & InteractorToPresenterGalleryProtocol) = GalleryPresenter()
        
        galleryVC.presenter = galleryPresenter
        galleryVC.presenter?.router = GalleryRouter()
        galleryVC.presenter?.view = galleryVC
        galleryVC.presenter?.interactor = GalleryInteractor()
        galleryVC.presenter?.interactor?.presenter = galleryPresenter
        galleryVC.tabBarItem = galleryTabBarItem
        galleryVC.delegate = mainVC
        
        let settingsVC = SettingsRouter.createModule(rootTabBar:self)
        let settingsTabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))
        settingsVC.tabBarItem = settingsTabBarItem
        settingsVC.delegate = mainVC
        
        let settingsPresenter:(ViewToPresenterSettingsProtocol & InteractorToPresenterSettingsProtocol) = SettingsPresenter()
        
        settingsVC.presenter = settingsPresenter
        settingsVC.presenter?.router = SettingsRouter()
        settingsVC.presenter?.view = settingsVC
        settingsVC.presenter?.interactor = SettingsInteractor()
        settingsVC.presenter?.interactor?.presenter = settingsPresenter
        
        
        let controllers = [mainVCNavigationController,galleryVC,settingsVC]
        
        self.viewControllers = controllers
        self.selectedIndex = 0
        
    }


}
