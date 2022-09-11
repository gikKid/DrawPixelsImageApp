//
//  WelcomeViewViewController.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 18.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import UIKit

final class WelcomeViewViewController: UIViewController {
    
    let imageView = UIImageView()
    let mainTextLabel = UILabel()
    let secondTextLabel = UILabel()
    let nextButton = UIButton()
    let skipButton = UIButton()
    let backButton = UIButton()
    let pageControl = UIPageControl()
    let topButtonsView = UIView()
    
    var presenter:(ViewToPresenterWelcomeViewProtocol & InteractorToPresenterWelcomeViewProtocol)?
    
    var currentPage:Int = 0 //to track currentPage
    
    var skipButtonTopConstraint:NSLayoutConstraint?
    var skipButtonRightConstraint:NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUP()
    }
    
    //MARK: - Setup View
    private func setUP() {
        
        self.view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        settingWelcomeButtons(button: nextButton, text: "Next")
        settingWelcomeButtons(button: skipButton, text: "Skip")
        settingWelcomeButtons(button: backButton, text: "Back")
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)
            ), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipButtonTapped(_:)), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        
        mainTextLabel.translatesAutoresizingMaskIntoConstraints = false
        mainTextLabel.font = .boldSystemFont(ofSize: 22)
        mainTextLabel.textColor = .darkGray
        mainTextLabel.text = Constants.firstWelcomeViewMainText
        mainTextLabel.textAlignment = .center
        mainTextLabel.numberOfLines = 1
        
        secondTextLabel.translatesAutoresizingMaskIntoConstraints = false
        secondTextLabel.textColor = .secondaryLabel
        secondTextLabel.font = .systemFont(ofSize: 18)
        secondTextLabel.text = Constants.firstWelcomeViewSecondText
        secondTextLabel.numberOfLines = 0
        secondTextLabel.textAlignment = .center
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.tintColor = .lightGray
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .darkGray
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Constants.firstWelcomeViewImageName)
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        
        topButtonsView.translatesAutoresizingMaskIntoConstraints = false
        topButtonsView.addSubview(skipButton)
        
        self.view.addSubview(topButtonsView)
        self.view.addSubview(nextButton)
        self.view.addSubview(imageView)
        self.view.addSubview(secondTextLabel)
        self.view.addSubview(pageControl)
        self.view.addSubview(mainTextLabel)
        
        skipButtonTopConstraint = skipButton.topAnchor.constraint(equalTo: topButtonsView.topAnchor,constant: 10)
        skipButtonTopConstraint?.isActive = true
        skipButtonRightConstraint = skipButton.rightAnchor.constraint(equalTo: topButtonsView.rightAnchor,constant: -10)
        skipButtonRightConstraint?.isActive = true
        
        
        NSLayoutConstraint.activate([
            topButtonsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 0),
            topButtonsView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor,constant: 0),
            topButtonsView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,constant: 0),
            topButtonsView.heightAnchor.constraint(equalToConstant: 80),
            topButtonsView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -40),
            nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 150),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor,constant: -10),
            secondTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            secondTextLabel.bottomAnchor.constraint(equalTo: pageControl.topAnchor,constant: -10),
            secondTextLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,constant: -5),
            secondTextLabel.leftAnchor.constraint(equalTo: self.view
                .leftAnchor,constant: 5),
            mainTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mainTextLabel.bottomAnchor.constraint(equalTo: secondTextLabel.topAnchor,constant: -5),
            mainTextLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,constant: -5),
            mainTextLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor,constant: 5),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imageView.bottomAnchor.constraint(equalTo: mainTextLabel.topAnchor,constant: -3),
            skipButton.widthAnchor.constraint(equalToConstant: 70),
            skipButton.heightAnchor.constraint(equalToConstant: 35),
            imageView.topAnchor.constraint(equalTo: topButtonsView.bottomAnchor,constant:0)
        ])
        
        
    }

    //MARK: - Buttons logic
    
    @objc private func nextButtonTapped(_ sender:UIButton) {
        
        if currentPage == 2 {
            presenter?.userEnterToMainView(from: self)
            return
        }
        
        presenter?.userTapNextWelcomeView(currentPage: currentPage)
    }
    
    @objc private func backButtonTapped(_ sender:UIButton) {
        presenter?.userTapBackButton(currentPage: currentPage)
    }
    
    @objc private func skipButtonTapped(_ sender:UIButton) {
        presenter?.skipWelcomeViews(from: self)
    }

}



//MARK: - PresenterToViewProtocol
extension WelcomeViewViewController:PresenterToViewWelcomeViewProtocol {
    
    
    func onNextWelcomeView(currentPage: Int, mainText: String, secondText: String, image: String) {
        self.currentPage = currentPage
        
        if currentPage == 2 {
            nextButton.setTitle("Get started", for: .normal)
            
            skipButtonTopConstraint?.isActive = false
            skipButtonRightConstraint?.isActive = false
            skipButton.removeFromSuperview()
        }
        
        imageView.image = UIImage(named: image)
        mainTextLabel.text = mainText
        secondTextLabel.text = secondText
        pageControl.currentPage = currentPage
        
        
        topButtonsView.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 70),
            backButton.heightAnchor.constraint(equalToConstant: 35),
            backButton.topAnchor.constraint(equalTo: topButtonsView.topAnchor,constant: 10),
            backButton.leadingAnchor.constraint(equalTo: topButtonsView.leadingAnchor,constant: 10)
        ])
        
    }
    
    func onUserTapBackButton(currentPage: Int, mainText: String, secondText: String, image: String) {
        
        self.currentPage = currentPage
        
        if currentPage == 0 {
            backButton.removeFromSuperview()
        }
        
        if currentPage == 1 {
            
            topButtonsView.addSubview(skipButton)
            
            skipButtonRightConstraint?.isActive = true
            skipButtonTopConstraint?.isActive = true
        }
        
        imageView.image = UIImage(named: image)
        mainTextLabel.text = mainText
        secondTextLabel.text = secondText
        pageControl.currentPage = currentPage
        
        nextButton.setTitle("Next", for: .normal)

        
    }
    
    
}
