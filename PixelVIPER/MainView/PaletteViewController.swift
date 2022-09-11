//
//  PaleteView.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 24.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import UIKit

protocol PalleteViewControllerProtocol {
    func passColor(color:CGColor)
}

class PaletteViewController: UIViewController,UIGestureRecognizerDelegate {
    
    let closeButton = UIButton()
    let doneButton = UIButton()
    let deviderView = UIView()
    let mainView = UIView()
    let currentColorimageView = UIImageView()
    let pickerColor = UISlider()
    var selectedCurrentColor:CGColor?
    
    var delegate:PalleteViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let theme = UserDefaults.standard.string(forKey: Constants.keyTheme){
            if theme == "dark" {
                mainView.backgroundColor = .black
                deviderView.backgroundColor = .lightGray
            }
            else {
                mainView.backgroundColor = .white
                deviderView.backgroundColor = .gray
            }
        }
    }
    
    private func setupView() {
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.backgroundColor = UIColor(named: Constants.paletteBackColor)
        mainView.layer.cornerRadius = 15
        self.view.addSubview(mainView)
        
        self.setupButton(button: closeButton, text: "Close")
        self.setupButton(button: doneButton, text: "Done")
        doneButton.addTarget(self, action: #selector(tapDoneButton(_:)), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(tapCloseButton(_:)), for: .touchUpInside)
        
        deviderView.backgroundColor = .gray
        deviderView.translatesAutoresizingMaskIntoConstraints = false
        
        currentColorimageView.translatesAutoresizingMaskIntoConstraints = false
        currentColorimageView.layer.cornerRadius = 10
        currentColorimageView.isUserInteractionEnabled = true
        
        let tapCurrentColor = UITapGestureRecognizer(target: self, action: #selector(tapCurrentColor(_:)))
        currentColorimageView.addGestureRecognizer(tapCurrentColor)
        

        pickerColor.translatesAutoresizingMaskIntoConstraints = false
        pickerColor.minimumValue = 0
        pickerColor.maximumValue = 1
        pickerColor.isContinuous = true
        pickerColor.setValue(0.5, animated: false)
        pickerColor.maximumTrackTintColor = UIColor.white.withAlphaComponent(0.001)
        pickerColor.minimumTrackTintColor = UIColor.white.withAlphaComponent(0.001)
        pickerColor.setThumbImage(UIImage(systemName: "circle"), for: .normal)
        pickerColor.layer.insertSublayer(self.setColorsGradientToPicker(pickerColor, [UIColor.systemPink.cgColor,UIColor.orange.cgColor,UIColor.yellow.cgColor,UIColor.green.cgColor,UIColor.blue.cgColor,UIColor.purple.cgColor,UIColor.red.cgColor]), at: 0)
        pickerColor.addTarget(self, action: #selector(setLimitAtThumb(_:)), for: .valueChanged)
        pickerColor.isUserInteractionEnabled = true
        pickerColor.addTarget(self, action: #selector(pickerColorTapped(_:)), for: .touchUpInside)
        
        currentColorimageView.layer.insertSublayer(self.setColorGradientToImage(currentColorimageView, pickerColor.layer.colorOfPoint(point: CGPoint(x: pickerColor.thumbCenterX, y: pickerColor.thumbCenterY))), at: 0)
        currentColorimageView.isUserInteractionEnabled = true
        
        
        mainView.addSubview(closeButton)
        mainView.addSubview(doneButton)
        mainView.addSubview(deviderView)
        mainView.addSubview(currentColorimageView)
        mainView.addSubview(pickerColor)
        
        NSLayoutConstraint.activate([
            mainView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            mainView.heightAnchor.constraint(equalToConstant: (self.view.frame.height / 2) - 50),
            mainView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: 0),
            mainView.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: 0),
            mainView.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 0),
            closeButton.topAnchor.constraint(equalTo: mainView.topAnchor,constant: 10),
            closeButton.leftAnchor.constraint(equalTo: mainView.leftAnchor,constant: 10),
            doneButton.topAnchor.constraint(equalTo: mainView.topAnchor,constant: 10),
            doneButton.rightAnchor.constraint(equalTo: mainView.rightAnchor,constant: -10),
            deviderView.heightAnchor.constraint(equalToConstant: 1),
            deviderView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 30),
            deviderView.topAnchor.constraint(equalTo: closeButton.bottomAnchor,constant: 5),
            deviderView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            currentColorimageView.topAnchor.constraint(equalTo: deviderView.bottomAnchor,constant: 30),
            currentColorimageView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            currentColorimageView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 30),
            currentColorimageView.bottomAnchor.constraint(equalTo: pickerColor.topAnchor,constant: -10),
            pickerColor.bottomAnchor.constraint(equalTo: mainView.bottomAnchor,constant: -30),
            pickerColor.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            pickerColor.widthAnchor.constraint(equalToConstant:  self.view.frame.width - 30),
            pickerColor.heightAnchor.constraint(equalToConstant: 40)
        ])
            
        self.changeColor() // to setup color at currentImageView at start
        
    }
    
    private func setupButton(button:UIButton,text:String) {
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
    }
    
    private func setColorsGradientToPicker(_ view:UISlider,_ colors:[CGColor]) -> CAGradientLayer {
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 30, height: 40)
        gradient.colors = colors
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.cornerRadius = 10
        return gradient
    }
    
    private func setColorGradientToImage(_ view:UIImageView,_ color:CGColor) -> CAGradientLayer{
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.white.cgColor,color]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.locations = [0.0,0.5]
        gradient.cornerRadius = 10
        return gradient
    }
    
    private func changeColor() {
        currentColorimageView.subviews.forEach({$0.removeFromSuperview()})
        let point = CGPoint(x: pickerColor.thumbCenterX, y: pickerColor.thumbCenterY)
        let currentColor = pickerColor.layer.colorOfPoint(point: point)
        
        guard let sublayers = currentColorimageView.layer.sublayers, !sublayers.isEmpty else {return}
            currentColorimageView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        currentColorimageView.layer.insertSublayer(self.setColorGradientToImage(currentColorimageView, currentColor ), at: 0)
    }
    
    @objc private func tapDoneButton(_ sender: UIButton) {
        
        guard let passColor = self.selectedCurrentColor else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        delegate?.passColor(color: passColor)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func tapCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func setLimitAtThumb(_ sender:UISlider) {
        if sender.value > 0.977 { // CRUTCH !!! , it fix cathcing white/black color from another view
            sender.value = 0.965
            self.changeColor()
            return
        }
        self.changeColor()
    }
    
    @objc private func pickerColorTapped(_ sender:UITapGestureRecognizer) {
        self.changeColor()
    }
    
    @objc private func tapCurrentColor(_ sender:UITapGestureRecognizer) {
        let point = sender.location(in: currentColorimageView)
        
        if !currentColorimageView.subviews.isEmpty{
            currentColorimageView.subviews.forEach({$0.removeFromSuperview()})
        }
        
        let circleImageView = UIImageView.init(image: UIImage(systemName: "circle"))
        circleImageView.frame = CGRect(x: point.x, y: point.y, width: 15.0, height: 15.0)
        
        currentColorimageView.addSubview(circleImageView)
        
        self.selectedCurrentColor = currentColorimageView.layer.colorOfPoint(point: point)
    }
}


