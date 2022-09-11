//
//  SettingsViewController.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 20.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import UIKit

protocol SettingsViewControllerProtocol {
    func passSizeCells(size:Int)
    func setNewExtension(newExtensionName:String)
}

final class SettingsViewController: UIViewController {
    
    let switcher = UISwitch()
    let extensionPicker = UIPickerView()
    let sizePicker = UIPickerView()
    var twitterButton = UIButton()
    var telegramButton = UIButton()
    var mailButton = UIButton()
    var gridSizeText = UILabel()
    var imageExtensionText = UILabel()
    var lightThemeText = UILabel()
    var contactText = UILabel()
    
    var sizesArray = Array(16...32)
    var extensionArray = ["jpg","png"]
    var currentSize:Int?
    var currentExtension:String?
    
    var rootTabBar:UITabBarController
    
    var presenter:(ViewToPresenterSettingsProtocol & InteractorToPresenterSettingsProtocol)?
    
    var delegate:SettingsViewControllerProtocol?
    
    init(rootTabBar:UITabBarController) {
        self.rootTabBar = rootTabBar
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        presenter?.viewDidLoad(switcher: switcher, sizePicker: sizePicker, extensionPicker: extensionPicker, tabbar: rootTabBar, view: view)
    }
    
    //MARK:- Setup View
    
    private func setupView() {
        self.view.backgroundColor = .white
        
//        switcher.isOn = true
        
        extensionPicker.delegate = self
        extensionPicker.dataSource = self
        sizePicker.delegate = self
        sizePicker.dataSource = self
        
        gridSizeText = self.createTextLabel(text: "Grid size")
        imageExtensionText = self.createTextLabel(text: "Image extension")
        lightThemeText = self.createTextLabel(text: "Light theme")
        contactText = self.createTextLabel(text: "Contact")
        
        
        twitterButton = self.createLinkButtons(text: "Twitter")
        telegramButton = self.createLinkButtons(text: "Telegram")
        mailButton = self.createLinkButtons(text: "Mail")
        
        twitterButton.addTarget(self, action: #selector(twitterButtonTapped(_:)), for: .touchUpInside)
        telegramButton.addTarget(self, action: #selector(telegramButtonTapped(_:)), for: .touchUpInside)
        mailButton.addTarget(self, action: #selector(mailButtonTapped(_:)), for: .touchUpInside)
        
        
        let linkButtonsStackView = UIStackView()
        linkButtonsStackView.axis = .horizontal
        linkButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        linkButtonsStackView.distribution = .equalSpacing
        linkButtonsStackView.spacing = 5
        linkButtonsStackView.alignment = .center
        
        linkButtonsStackView.addArrangedSubview(twitterButton)
        linkButtonsStackView.addArrangedSubview(telegramButton)
        linkButtonsStackView.addArrangedSubview(mailButton)
        
        switcher.translatesAutoresizingMaskIntoConstraints = false
        extensionPicker.translatesAutoresizingMaskIntoConstraints = false
        sizePicker.translatesAutoresizingMaskIntoConstraints = false
        
        switcher.addTarget(self, action: #selector(tapSwitcher(_:)), for: .valueChanged)
        
        self.view.addSubview(gridSizeText)
        self.view.addSubview(imageExtensionText)
        self.view.addSubview(lightThemeText)
        self.view.addSubview(contactText)
        self.view.addSubview(linkButtonsStackView)
        self.view.addSubview(switcher)
        self.view.addSubview(sizePicker)
        self.view.addSubview(extensionPicker)
        
        NSLayoutConstraint.activate([
            gridSizeText.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            gridSizeText.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 20),
            imageExtensionText.leadingAnchor.constraint(equalTo: gridSizeText.leadingAnchor),
            imageExtensionText.topAnchor.constraint(equalTo: gridSizeText.bottomAnchor,constant: 30),
            lightThemeText.leadingAnchor.constraint(equalTo: gridSizeText.leadingAnchor),
            lightThemeText.topAnchor.constraint(equalTo: imageExtensionText.bottomAnchor,constant: 30),
            contactText.leadingAnchor.constraint(equalTo: gridSizeText.leadingAnchor),
            contactText.topAnchor.constraint(equalTo: lightThemeText.bottomAnchor,constant: 30),
            linkButtonsStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            linkButtonsStackView.centerYAnchor.constraint(equalTo: contactText.centerYAnchor),
            switcher.trailingAnchor.constraint(equalTo: linkButtonsStackView.trailingAnchor),
            switcher.centerYAnchor.constraint(equalTo: lightThemeText.centerYAnchor),
            sizePicker.trailingAnchor.constraint(equalTo: linkButtonsStackView.trailingAnchor),
            sizePicker.centerYAnchor.constraint(equalTo: gridSizeText.centerYAnchor),
            sizePicker.heightAnchor.constraint(equalToConstant: 50),
            sizePicker.widthAnchor.constraint(equalToConstant: 100),
            extensionPicker.widthAnchor.constraint(equalToConstant: 100),
            extensionPicker.heightAnchor.constraint(equalToConstant: 50),
            extensionPicker.trailingAnchor.constraint(equalTo: linkButtonsStackView.trailingAnchor),
            extensionPicker.centerYAnchor.constraint(equalTo: imageExtensionText.centerYAnchor)
        ])
        
    }
    
    private func createTextLabel(text:String) ->UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .systemBlue
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createLinkButtons(text:String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }

    
    //MARK:- Buttons logic
    
    @objc private func  twitterButtonTapped(_ sender:UIButton) {
        presenter?.userTapTwitterButton()
    }
    
    @objc private func  telegramButtonTapped(_ sender:UIButton) {
        presenter?.userTapTelegramButton()
        
    }
    
    @objc private func  mailButtonTapped(_ sender:UIButton) {
        let alertController = UIAlertController(title: "Customer support mail", message: Constants.mail, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Copy", style: .default, handler: {[weak self] _ in
            guard let self = self else {return}
            self.presenter?.userCopyMail()
            
        }))
        
        present(alertController,animated: true)
    }
    
    @objc private func tapSwitcher(_ sender:UISwitch) {
        presenter?.userTapSwitchTheme(switcher: switcher, sizePicker: sizePicker, extensionPicker: extensionPicker,tabbar:rootTabBar,view:self.view)
    }
    

}


//MARK: - Picker Delegate
extension SettingsViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sizePicker {
            return self.sizesArray.count
        }
        else {
            return self.extensionArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sizePicker {
            return String(self.sizesArray[row])
        }
        else {
            return self.extensionArray[row]
        }
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == self.sizePicker{
            let warningAlert = UIAlertController(title: "Warning!", message: "After resize, your current drawing work will be deleted,are you sure?", preferredStyle: .alert)
            warningAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            warningAlert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: {[weak self] _ in
                guard let self = self else {return}
                self.delegate?.passSizeCells(size: self.sizesArray[row])
            }))
            present(warningAlert, animated: true)
        }
        else  {
            self.delegate?.setNewExtension(newExtensionName: self.extensionArray[row])
        }
    }
    
    
}

//MARK: - PresenterToView
extension SettingsViewController:PresenterToViewSettingsProtocol {
    func onSuccessfulTapTwitterButton(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func onFailureTapTwitterButton(errorMessage: String) {
        present(errorAlertController(errorMessage),animated: true)
    }
    
    func onSuccessfulTapTelegramButton(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func onFailureTapTelegramButton(errorMessage: String) {
        present(errorAlertController(errorMessage),animated: true)
    }
    

    
    
}
