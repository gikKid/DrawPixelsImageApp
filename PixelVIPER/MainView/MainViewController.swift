//
//  MainViewController.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 18.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    let shareButton = UIButton()
    let drawingPlace = UIImageView()
    
    var blackColorButton = UIButton()
    var grayColorButton = UIButton()
    var orangeColorButton = UIButton()
    var greenColorButton = UIButton()
    var yellowColorButton = UIButton()
    var lightBlueColorButton = UIButton()
    var purpleColorButton = UIButton()
    var redColorButton = UIButton()
    var blueColorButton = UIButton()
    var whiteColorButton = UIButton()
    
    var brushButton = UIButton()
    var eraseButton = UIButton()
    var pipeteButton = UIButton()
    var paletteButton = UIButton()
    var backActionButton = UIButton()
    var forwardActionButton = UIButton()
    
    let loadImageButton = createCustomButton(title: "Load image")
    let addImageToGalleryButton = createCustomButton(title: "Add to gallery")
    let resetButton = createCustomButton(title: "Reset")
    
    var rootTabBar:UITabBarController
    var presenter:(ViewToPresenterMainProtocol & InteractorToPresenterMainProtocol)?
    var currentBackgroundButton = UIButton()
    var previousBackgroundButton = UIButton()
    var mainActionButtonsArray = [UIButton]()
    var currentButtonTag:Int? // for send whiteColorButton tag when it was changed yourself color
    var isOpenViewController:Bool?
    
    
    
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
        presenter?.viewDidLoad()
        presenter?.checkTheme(tabbar: rootTabBar, view: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.presenter?.checkTheme(tabbar: self.rootTabBar, view: self.view)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let _ = isOpenViewController else {
            DispatchQueue.main.async {
                self.presenter?.createEmptyCells(imageView:self.drawingPlace)
            }
                
            isOpenViewController = true
            return
        }
    }
    

    //MARK: - Setup view
    
    private func setupView() {
        
        self.view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
                
        let gesture = UITapGestureRecognizer(target: self, action: #selector(drawPixel(sender:)))
        let longTap = UIPanGestureRecognizer(target: self, action: #selector(drawPixel(sender:)))
        
        drawingPlace.addGestureRecognizer(gesture)
        drawingPlace.addGestureRecognizer(longTap)
        drawingPlace.isUserInteractionEnabled = true

        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.imageView?.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1.3)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        
        drawingPlace.isUserInteractionEnabled = true
        drawingPlace.translatesAutoresizingMaskIntoConstraints = false
        drawingPlace.contentMode = .scaleToFill
        
        let grayBackView = UIView()
        grayBackView.backgroundColor = UIColor(named: Constants.backgroundMainSubViewColor)
        grayBackView.layer.cornerRadius = 8
        grayBackView.translatesAutoresizingMaskIntoConstraints = false
        
        blackColorButton = self.createActionButton(systemName: Constants.nameColorButtonsMain)
        blackColorButton.imageView?.tintColor = .black
        blackColorButton.imageView?.layer.transform = CATransform3DMakeScale(1.6, 1.6, 1.6)
        mainActionButtonsArray.append(blackColorButton)
        
        grayColorButton = self.createActionButton( systemName: Constants.nameColorButtonsMain)
        grayColorButton.imageView?.tintColor = .gray
        grayColorButton.imageView?.layer.transform = CATransform3DMakeScale(1.6, 1.6, 1.6)
        mainActionButtonsArray.append(grayColorButton)
        
        orangeColorButton = self.createActionButton( systemName: Constants.nameColorButtonsMain)
        orangeColorButton.imageView?.tintColor = .orange
        orangeColorButton.imageView?.layer.transform = CATransform3DMakeScale(1.6, 1.6, 1.6)
        mainActionButtonsArray.append(orangeColorButton)
        
        greenColorButton = self.createActionButton( systemName: Constants.nameColorButtonsMain)
        greenColorButton.imageView?.tintColor = .green
        greenColorButton.imageView?.layer.transform = CATransform3DMakeScale(1.6, 1.6, 1.6)
        mainActionButtonsArray.append(greenColorButton)
        
        yellowColorButton = self.createActionButton( systemName: Constants.nameColorButtonsMain)
        yellowColorButton.imageView?.tintColor = .yellow
        yellowColorButton.imageView?.layer.transform = CATransform3DMakeScale(1.6, 1.6, 1.6)
        mainActionButtonsArray.append(yellowColorButton)
        
        lightBlueColorButton = self.createActionButton( systemName: Constants.nameColorButtonsMain)
        lightBlueColorButton.imageView?.tintColor = .systemBlue
        lightBlueColorButton.imageView?.layer.transform = CATransform3DMakeScale(1.6, 1.6, 1.6)
        mainActionButtonsArray.append(lightBlueColorButton)
        
        purpleColorButton = self.createActionButton( systemName: Constants.nameColorButtonsMain)
        purpleColorButton.imageView?.tintColor = .purple
        purpleColorButton.imageView?.layer.transform = CATransform3DMakeScale(1.6, 1.6, 1.6)
        mainActionButtonsArray.append(purpleColorButton)
        
        redColorButton = self.createActionButton( systemName: Constants.nameColorButtonsMain)
        redColorButton.imageView?.tintColor = .red
        redColorButton.imageView?.layer.transform = CATransform3DMakeScale(1.6, 1.6, 1.6)
        mainActionButtonsArray.append(redColorButton)
        
        blueColorButton = self.createActionButton( systemName: Constants.nameColorButtonsMain)
        blueColorButton.imageView?.tintColor = .blue
        blueColorButton.imageView?.layer.transform = CATransform3DMakeScale(1.6, 1.6, 1.6)
        mainActionButtonsArray.append(blueColorButton)
        
        whiteColorButton = self.createActionButton( systemName: Constants.nameColorButtonsMain)
        whiteColorButton.imageView?.tintColor = .white
        whiteColorButton.imageView?.layer.transform = CATransform3DMakeScale(1.6, 1.6, 1.6)
        mainActionButtonsArray.append(whiteColorButton)

        let colorsButtonStackView = UIStackView()
        colorsButtonStackView.axis = .horizontal
        colorsButtonStackView.distribution = .fillEqually
        colorsButtonStackView.alignment = .center
        colorsButtonStackView.spacing = 3
        colorsButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        colorsButtonStackView.addArrangedSubview(blackColorButton)
        colorsButtonStackView.addArrangedSubview(grayColorButton)
        colorsButtonStackView.addArrangedSubview(orangeColorButton)
        colorsButtonStackView.addArrangedSubview(greenColorButton)
        colorsButtonStackView.addArrangedSubview(yellowColorButton)
        colorsButtonStackView.addArrangedSubview(lightBlueColorButton)
        colorsButtonStackView.addArrangedSubview(purpleColorButton)
        colorsButtonStackView.addArrangedSubview(redColorButton)
        colorsButtonStackView.addArrangedSubview(blueColorButton)
        colorsButtonStackView.addArrangedSubview(whiteColorButton)
        
        grayBackView.addSubview(colorsButtonStackView)
        
        brushButton = self.createActionButton(systemName: "paintbrush.fill")
        mainActionButtonsArray.append(brushButton)
        eraseButton = self.createActionButton(customName: "erase")
        mainActionButtonsArray.append(eraseButton)
        pipeteButton = self.createActionButton(systemName: "eyedropper.full")
        mainActionButtonsArray.append(pipeteButton)
        paletteButton = self.createActionButton(customName: "palete")
        backActionButton = self.createActionButton(systemName: "gobackward")
        forwardActionButton = self.createActionButton(systemName: "goforward")
        
        let actionsButtonStackView = UIStackView()
        actionsButtonStackView.axis = .horizontal
        actionsButtonStackView.distribution = .equalSpacing
        actionsButtonStackView.alignment = .center
        actionsButtonStackView.spacing = 20
        actionsButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        eraseButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        eraseButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        paletteButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        paletteButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        actionsButtonStackView.addArrangedSubview(brushButton)
        actionsButtonStackView.addArrangedSubview(eraseButton)
        actionsButtonStackView.addArrangedSubview(pipeteButton)
        actionsButtonStackView.addArrangedSubview(paletteButton)
        actionsButtonStackView.addArrangedSubview(backActionButton)
        actionsButtonStackView.addArrangedSubview(forwardActionButton)
        
        
        self.view.addSubview(loadImageButton)
        self.view.addSubview(addImageToGalleryButton)
        self.view.addSubview(resetButton)
        self.view.addSubview(shareButton)
        self.view.addSubview(drawingPlace)
        self.view.addSubview(grayBackView)
        self.view.addSubview(actionsButtonStackView)
        
        let availableHeight = self.view.bounds.height - resetButton.bounds.height - grayBackView.bounds.height - eraseButton.bounds.height - loadImageButton.bounds.height - 300 //need for creating empty cells
        
        NSLayoutConstraint.activate([
        loadImageButton.widthAnchor.constraint(equalToConstant: 150),
        loadImageButton.heightAnchor.constraint(equalToConstant: 30),
        loadImageButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
        loadImageButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -20),
        addImageToGalleryButton.widthAnchor.constraint(equalToConstant: 150),
        addImageToGalleryButton.heightAnchor.constraint(equalToConstant: 30),
        addImageToGalleryButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
        addImageToGalleryButton.bottomAnchor.constraint(equalTo: loadImageButton.bottomAnchor),
        resetButton.widthAnchor.constraint(equalToConstant: 100),
        resetButton.heightAnchor.constraint(equalToConstant: 30),
        resetButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
        resetButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 20),

        shareButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
        shareButton.centerYAnchor.constraint(equalTo: resetButton.centerYAnchor),
        drawingPlace.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -5),
        drawingPlace.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 5),
        drawingPlace.topAnchor.constraint(equalTo: resetButton.bottomAnchor,constant: 20),
        drawingPlace.bottomAnchor.constraint(equalTo: grayBackView.topAnchor,constant: -10),
        drawingPlace.heightAnchor.constraint(equalToConstant: CGFloat(availableHeight)),
        grayBackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
        grayBackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
        grayBackView.bottomAnchor.constraint(equalTo: actionsButtonStackView.topAnchor,constant: -10),
        grayBackView.heightAnchor.constraint(equalToConstant: 50),
        actionsButtonStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
        actionsButtonStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
        actionsButtonStackView.bottomAnchor.constraint(equalTo: addImageToGalleryButton.topAnchor,constant: -20),
        colorsButtonStackView.leadingAnchor.constraint(equalTo: grayBackView.leadingAnchor,constant: 0),
        colorsButtonStackView.trailingAnchor.constraint(equalTo: grayBackView.trailingAnchor,constant: 0),
        colorsButtonStackView.topAnchor.constraint(equalTo: grayBackView.topAnchor,constant: 0),
        colorsButtonStackView.bottomAnchor.constraint(equalTo: grayBackView.bottomAnchor,constant: 0)
        ])
        
        for (numberTag,button) in mainActionButtonsArray.enumerated() {
            button.tag = numberTag
            button.addTarget(self, action: #selector(setBackgroundCurrentAction(_:)), for: .touchUpInside)
            
            if button.tag < 10 {
                button.addTarget(self, action: #selector(setCurrentColor(_:)), for: .touchUpInside)
            }
        }
        
        resetButton.addTarget(self, action: #selector(tapResetButton(_:)), for: .touchUpInside)
        loadImageButton.addTarget(self, action: #selector(tapLoadImageButton(_:)), for: .touchUpInside)
        addImageToGalleryButton.addTarget(self, action: #selector(tapSaveImageButton(_:)), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(tapShareButton(_:)), for: .touchUpInside)
        paletteButton.addTarget(self, action: #selector(tapPaletteButton(_:)), for: .touchUpInside)
        backActionButton.addTarget(self, action: #selector(tapBackAction(_:)), for: .touchUpInside)
        forwardActionButton.addTarget(self, action: #selector(tapCancelPreviousAction(_:)), for: .touchUpInside)
                
    }
    
    private func createActionButton(customName:String? = nil,systemName:String? = nil) -> UIButton{
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
       
        if let customName = customName {
            button.setImage(UIImage(named: customName), for: .normal)
            button.imageView?.contentMode = .scaleToFill
        }
        else if let systemName = systemName {
            button.setImage(UIImage(systemName: systemName), for: .normal)
        }
        button.imageView?.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.2)
        return button
    }
    
    //MARK: - Button logic
    @objc private func tapResetButton(_ sender:UIButton) {
        presenter?.userTapResetButton(imageView: drawingPlace)
    }
    
    @objc private func tapLoadImageButton(_ sender:UIButton) {
        presenter?.userTapLoadImageButton(viewController: self)
    }
    
    @objc private func tapSaveImageButton(_ sender:UIButton) {
        DispatchQueue.main.async {
            self.presenter?.userTapSaveImageButton(imageView: self.drawingPlace)
        }
    }
    
    @objc private func tapShareButton(_ sender:UIButton) {
        presenter?.userTapShareButton(imageView:drawingPlace)
    }
    
    @objc private func drawPixel(sender: UITapGestureRecognizer) {
        let currentPoint = sender.location(in: drawingPlace)
        presenter?.drawCell(imageView: drawingPlace,currentPoint:currentPoint,currentButtonTag:currentButtonTag)
    }
    
    @objc private func setCurrentColor(_ sender:UIButton) {
        self.currentButtonTag = nil
        if sender == whiteColorButton {
            self.currentButtonTag = sender.tag
        }
        presenter?.setCurrentColor(colorButton:sender)
    }
    
    @objc private func tapPaletteButton(_ sender:UIButton) {
        presenter?.userTapPaletteButton(VC: self)
    }
    
    @objc private func tapBackAction(_ sender:UIButton) {
        DispatchQueue.main.async {
            self.presenter?.userTapBackActionButton(imageView: self.drawingPlace)
        }
    }
    
    @objc private func tapCancelPreviousAction(_ sender:UIButton) {
        DispatchQueue.main.async {
            self.presenter?.userTapCancelPreviousActionButton(imageView: self.drawingPlace)
        }
    }
    
    @objc private func setBackgroundCurrentAction(_ sender:UIButton ) {
        var currentButton = UIButton()
        
        if sender.tag == 0 {
            currentButton = blackColorButton
        }
        else if sender.tag == 1 {
            currentButton = grayColorButton
        }
        else if sender.tag == 2 {
            currentButton = orangeColorButton
        }
        else if sender.tag == 3 {
            currentButton = greenColorButton
        }
        else if sender.tag == 4 {
            currentButton = yellowColorButton
        }
        else if sender.tag == 5 {
            currentButton = lightBlueColorButton
        }
        else if sender.tag == 6 {
            currentButton = purpleColorButton
        }
        else if sender.tag == 7 {
            currentButton = redColorButton
        }
        else if sender.tag == 8 {
            currentButton = blueColorButton
        }
        else if sender.tag == 9 {
            currentButton = whiteColorButton
        }
        else if sender.tag == 10 {
            currentButton = brushButton
        }
        else if sender.tag == 11 {
            currentButton = eraseButton
        }
        else if sender.tag == 12 {
            currentButton = pipeteButton
        }
        
        if currentBackgroundButton == currentButton {
            if sender.tag < 10 {
                sender.backgroundColor = .clear
            }
            else if sender.tag >= 10 && sender != eraseButton {
                sender.imageView?.tintColor = .systemBlue
                
                if sender == pipeteButton {
                    presenter?.userUntapPipeteButton()
                }
            }
            else if sender.tag >= 10 && sender == eraseButton {
                eraseButton.setImage(UIImage(named: "erase"), for: .normal)
                currentBackgroundButton = UIButton()
                previousBackgroundButton = sender
                presenter?.userUntapEraserButton()
                return
            }
            currentBackgroundButton = UIButton()
        }
        if previousBackgroundButton.tag < 10 {
            previousBackgroundButton.backgroundColor = .clear
        }
        else if previousBackgroundButton.tag >= 10 {
            if previousBackgroundButton == eraseButton {
                eraseButton.setImage(UIImage(named: "erase"), for: .normal)
                presenter?.userUntapEraserButton()
            }
            else {
                previousBackgroundButton.imageView?.tintColor = .systemBlue
                
                if previousBackgroundButton == pipeteButton {
                    presenter?.userUntapPipeteButton()
                }
            }
        }
        
        if sender.tag < 10 {
            sender.layer.cornerRadius = blackColorButton.layer.frame.width / 1.5
            sender.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        }
        else {
            if sender != eraseButton {
                sender.imageView?.tintColor = .systemGray
                
                if sender == pipeteButton {
                    presenter?.userTapPipeteButton()
                }
            }
            else {
                sender.setImage(UIImage(named: "eraseBackground"), for: .normal)
                presenter?.userTapEraserButton()
            }
        }
        currentBackgroundButton = sender
        previousBackgroundButton = sender
    }
}

//MARK: - PresenterToViewProtocol
extension MainViewController:PresenterToViewMainProtocol {
    func errorLoadImageForEditing(errorMessage: String) {
        present(errorAlertController(errorMessage),animated: true)
    }
    
    func errorSavingImage(errorMessage: String) {
        present(errorAlertController(errorMessage),animated: true)
    }
    
    func errorDeleteImageFromDocument(errorMessage: String) {
        present(errorAlertController(errorMessage),animated: true)
    }
    
    func showWriteTitleImageAlert(alertController: UIAlertController) {
        present(alertController,animated: true)
    }
    
    func errorEmptyTextTitle(errorMessage: String) {
        present(errorAlertController(errorMessage),animated: true)
    }
    
    func onUserTapPaletteButton(paletteVC: PaletteViewController) {
        present(paletteVC,animated: true)
    }
    
    
    func changeColorAtWhiteButton(color: CGColor) {
        whiteColorButton.imageView?.tintColor = UIColor(cgColor: color)
    }
    
    func onUserTapLoadImageButton(pickerVC: UIImagePickerController) {
        present(pickerVC,animated: true)
    }
    
    func onUserTapFailureShareButton(errorMessage: String) {
        present(errorAlertController(errorMessage),animated:true)
    }
    
    func onUserTapSuccessfulShareButton(activityVC: UIActivityViewController) {
        present(activityVC,animated: true)
    }
    
    func onUserTapResetButton(confirmAlertController: UIAlertController) {
        present(confirmAlertController,animated: true)
    }
    
    
}


//MARK: - PickerDelegate
extension MainViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        presenter?.pickImage(info: info, imageView: drawingPlace)
        dismiss(animated: true, completion: nil)
    }
}


//MARK: - PaletteDelegate
extension MainViewController:PalleteViewControllerProtocol {
    func passColor(color: CGColor) {
        DispatchQueue.main.async {
            self.whiteColorButton.imageView?.tintColor = UIColor(cgColor: color)
        }
        self.presenter?.changeColorFromPassedPalette(color: UIColor(cgColor: color))
    }
    
    
}

//MARk: - SettingsDelegate
extension MainViewController:SettingsViewControllerProtocol {
    func setNewExtension(newExtensionName: String) {
        presenter?.changeImageExtension(newExtension: newExtensionName)
    }
    
    func passSizeCells(size: Int) {
        DispatchQueue.main.async {
            self.presenter?.resizeCells(newSize: size, imageView: self.drawingPlace)
        }
    }
    
    
}

//MARK: - GalleryDelegate
extension MainViewController:GalleryViewControllerProtocol {
    func passEditImage(imageName: String) {
        DispatchQueue.main.async {
            self.presenter?.createEmptyCells(imageView: self.drawingPlace)
            self.presenter?.changeImageToEditing(imageName: imageName, imageView: self.drawingPlace)
        }
    }
}
