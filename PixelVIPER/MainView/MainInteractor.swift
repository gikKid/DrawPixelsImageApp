//
//  MainInteractor.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 20.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

final class MainInteractor:PresenterToInteractorMainProtocol {

    var paintedPixelsArray = [CGPoint]()
    var lineWidth:CGFloat = 0.5
    var imageModel = Image()
    var width:CGFloat?
    var isErase = false
    var whiteColorButtonWasChanged = false
    var currentColorAtWhiteButton = UIColor()
    var isPipete = false
    var color = UIColor.black
    var namesImages = [String]()
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    let defaults = UserDefaults.standard
    
    var previousTenActions = [Action]()
    var deletedPreviousTenActions = [Action]()

     struct Action {
        var setedColor:CGColor
        var previousColor:CGColor
        var x:CGFloat
        var y:CGFloat
    }
    
    var presenter: InteractorToPresenterMainProtocol?
    
    init() {
        getSavedImageNames(namesArray: &namesImages)
    }
    
    func viewDidLoad_() { // create Example cell at Collection view at first opening view
        if namesImages.count == 0 {
            let exampleImageView = UIImageView.init(image: UIImage(named: Constants.exampleImageName))
            if let dataImage = exampleImageView.image?.jpegData(compressionQuality: 0.8) {
                self.save(fileName: Constants.exampleImageCellLabelName, imageData: dataImage)
                self.imageModel.title = Constants.exampleImageCellLabelName
                self.createNewImage()
            }
        }
    }
    
    func createEmptyCells_(imageView: UIImageView) {
        
        self.paintedPixelsArray = [CGPoint]()
        imageView.image = nil
        imageView.backgroundColor = UIColor.white
        imageView.layer.borderWidth = self.lineWidth
        imageView.layer.borderColor = UIColor.gray.cgColor
        let height = imageView.frame.height / CGFloat(self.imageModel.size)
        self.width = height
        
        for x in 0...self.imageModel.size - 1{
            for y in 0...self.imageModel.size - 1{
                UIGraphicsBeginImageContext(imageView.frame.size)
                let context = UIGraphicsGetCurrentContext()
                imageView.image?.draw(in: imageView.bounds)
                self.setContext(context, x, y, height)
                context?.strokePath()
                imageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
            }
        }
    }
    
    private func setContext(_ context:CGContext?,_ xCoordinate:Int,_ yCoordinate:Int, _ width:CGFloat) {
        context?.setLineWidth(self.lineWidth)
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill( CGRect(x: CGFloat(xCoordinate) * width , y: CGFloat(yCoordinate) * width , width: width, height: width ))
        UIColor.black.set()
        context?.addRect( CGRect(x: CGFloat(xCoordinate) * width, y: CGFloat(yCoordinate) * width, width: width , height: width ))
    }
    
    
    func drawCell_(imageView: UIImageView, currentPoint: CGPoint,currentButtonTag:Int?) {
        
        guard let width = width else {return}
        
        for x in 0...self.imageModel.size - 1  {
            for y in 0...self.imageModel.size - 1{
                if currentPoint.x >= CGFloat(x) * width && currentPoint.x <= (CGFloat(x) * width) + width && currentPoint.y >= CGFloat(y) * width && currentPoint.y <= (CGFloat(y) * width) + width
                {
                    
                    var currentAction:Action?
                    let previousColor = imageView.layer.colorOfPoint(point: currentPoint)
                    
                    UIGraphicsBeginImageContext(imageView.frame.size)
                    let context = UIGraphicsGetCurrentContext()
                    imageView.image?.draw(in: imageView.bounds)
                    
                    if self.isErase {
                
                        let setedWhiteColor = UIColor.white.cgColor
                        currentAction = Action(setedColor: setedWhiteColor, previousColor: previousColor, x: CGFloat(x), y: CGFloat(y))
                        
                        context?.clear(CGRect(x: CGFloat(x) * width, y: CGFloat(y) * width, width: width, height: width))
                        self.setContext(context, x, y, width)
                        for (index,deletePoint) in self.paintedPixelsArray.enumerated() {
                            if deletePoint == currentPoint {
                                self.paintedPixelsArray.remove(at: index)
                            }
                        }
                    }
                    else if self.isPipete {
                        self.getColorFromPipete(imageView,currentPoint)
                        return
                    }
                    else{
                        
                        let setedColor:CGColor?
                        
                        if let currentWhiteButtonTag = currentButtonTag,currentWhiteButtonTag == 9, whiteColorButtonWasChanged {
                            context?.setFillColor(self.currentColorAtWhiteButton.cgColor)
                            setedColor = self.currentColorAtWhiteButton.cgColor
                        }
                        else{
                            context?.setFillColor(self.color.cgColor)
                            setedColor = self.color.cgColor
                        }
                        context?.fill(CGRect(x: CGFloat(x) * width, y: CGFloat(y) * width, width: width , height: width ))
                        self.paintedPixelsArray.append(CGPoint(x: CGFloat(x) * width, y: CGFloat(y) * width))
                        
                        if let setedColor_ = setedColor {
                            currentAction = Action(setedColor: setedColor_, previousColor: previousColor, x: CGFloat(x), y: CGFloat(y))
                        }
                    }
                    context?.strokePath()
                    imageView.image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    
                    if let currentAction_ = currentAction {
                        previousTenActions.insert(currentAction_, at: 0)
                        if previousTenActions.count > 10 {
                            previousTenActions.remove(at: previousTenActions.count - 1)
                        }
                    }
                }
            }
        }
    }
    
    func setCurrentColor_(colorButton: UIButton) {
        guard let pencil = Pencil(tag:colorButton.tag) else {
          return
        }
        self.color = pencil.color
    }
    
    func eraseButton() {
        self.isErase = true
    }
    func unTapEraseButton() {
        self.isErase = false
    }
    func tapPipeteButton() {
        self.isPipete = true
    }
    
    func unTapPipeteButton() {
        self.isPipete = false
    }
    
    func changeColorAtWhiteButton(color: UIColor) {
        self.currentColorAtWhiteButton = color
        self.whiteColorButtonWasChanged = true
    }
    
    func changeSizeCells(newSize: Int, imageView: UIImageView) {
        imageModel.size = newSize
        self.createEmptyCells_(imageView: imageView)
    }
    
    func changeExtension(newExtension: String) {
        self.imageModel.imageExtension = newExtension
    }
    
    func saveImage(imageView: UIImageView, title: String) {
        self.imageModel.title = "\(title).\(self.imageModel.imageExtension)"
        if !self.namesImages.contains("\(title).\(self.imageModel.imageExtension)") {
            self.saveDataImage(imageView)
        }
        else {
            var sameNames = [String]()
            
            for name in self.namesImages {// search same names
                if name.contains(title) {
                    sameNames.append(name)
                }
            }
            if sameNames.count == 1 {
                self.imageModel.title = "\(title)1.\(self.imageModel.imageExtension)"
            }
            else {
            sameNames.sort()
                let lastBiggerName = sameNames[sameNames.count - 1]
                if let biggerNumberString = lastBiggerName.matchingStrings(regex:"\(title)([0-9]+).\(self.imageModel.imageExtension)").first?[1],let biggerNumber = Int(biggerNumberString) {
                    self.imageModel.title = "\(title)\(biggerNumber + 1).\(self.imageModel.imageExtension)"
                }
            }
            self.saveDataImage(imageView)
        }
    }
    
    private func saveDataImage(_ imageView: UIImageView) {
        for _ in 0...4{
         self.fillEmptyPixels(imageView)
        }
        guard let image = imageView.image else  {return}
            if let data = self.imageModel.imageExtension == "png" ? image.pngData() : image.jpegData(compressionQuality: 0.8),let title = self.imageModel.title {
                self.save(fileName: title , imageData: data)
                self.createNewImage()
            }
            else {
                presenter?.failureSavingImage(errorMessage:  "Coudnt save the image,please repeat it again")
            }
    }
    
    private func fillEmptyPixels(_ imageView: UIImageView!) {
        guard let width = width else {return}
        
        for x in 0...self.imageModel.size - 1  {
            for y in 0...self.imageModel.size - 1{
                if self.paintedPixelsArray.contains(CGPoint(x: CGFloat(x) * width, y: CGFloat(y) * width)) {
                    continue
                }
                else {
                    UIGraphicsBeginImageContext(imageView.frame.size)
                    let context = UIGraphicsGetCurrentContext()
                    context?.clear(CGRect(x: CGFloat(x) * width, y: CGFloat(y) * width, width: width + self.lineWidth, height: width + self.lineWidth))
                    imageView.image?.draw(in: imageView.bounds)
                    context?.setFillColor(UIColor.white.cgColor)
                    context?.fill( CGRect(x: CGFloat(x) * width , y: CGFloat(y) * width , width: width , height: width  ))
                    context?.strokePath()
                    imageView.image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                }
            }
        }
    }
    
    private func save(fileName:String,imageData:Data) {
        let fileURL = documentsUrl.appendingPathComponent(fileName)
           try? imageData.write(to: fileURL, options: .atomic)
    }
    
    private func createNewImage() {
        getSavedImageNames(namesArray: &namesImages)
        guard let name = self.imageModel.title else {return}
        self.namesImages.append(name)
        if let savedNames = try? NSKeyedArchiver.archivedData(withRootObject: namesImages, requiringSecureCoding: false) {
            self.defaults.set(savedNames, forKey: Constants.imageNamesUserDefaultKey)
        }
        else{
            presenter?.failureSavingImage(errorMessage: "Coudnt save image")
            self.deleteImagefromDocument(name: name)
        }
    }
    
    private func deleteImagefromDocument(name:String) {
        let fileManager = FileManager.default
        let imagePath = getDocumenetsDirectory().appendingPathComponent(name)
        do {
            try fileManager.removeItem(at: imagePath)
        } catch {
            presenter?.failureDeleteImageFromDocument(errorMessage: "Deletion error image from your device")
        }
    }
    
    private func getColorFromPipete(_ imageView:UIImageView,_ point:CGPoint) {
        let currentColor = imageView.layer.colorOfPoint(point: point)
        presenter?.colorFromPipete(color: currentColor)
        self.whiteColorButtonWasChanged = true
        self.currentColorAtWhiteButton = UIColor(cgColor: currentColor)
    }
    
    func loadImageForEditing(imageName: String, imageView: UIImageView) {
        let fileURL = documentsUrl.appendingPathComponent(imageName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            imageView.image = UIImage(data: imageData)
        } catch {
            presenter?.failureLoadImageForEditing(errorMessage: "Coudnt load this image, try it again!")
        }
    }
    
    func makePreviousAction(imageView: UIImageView) {
        
        guard previousTenActions.count > 0 else {return}
        let previousAction = previousTenActions[0]
        self.draw(imageView: imageView, color: previousAction.previousColor, x: previousAction.x, y: previousAction.y)
        
        if previousAction.previousColor == UIColor.white.cgColor {
            guard let width = width else {return}
            for (index,point) in paintedPixelsArray.enumerated() {
                if point.x == previousAction.x * width && point.y == previousAction.y * width {
                    paintedPixelsArray.remove(at: index)
                    break
                }
            }
        }
        
        deletedPreviousTenActions.insert(previousTenActions[0], at: 0)
        previousTenActions.remove(at: 0)
    }
    
    func cancelPreviousAction(imageView: UIImageView) {
        
        guard deletedPreviousTenActions.count > 0 else {return}
        let deletedPreviousAction = deletedPreviousTenActions[0]
        self.draw(imageView: imageView, color: deletedPreviousAction.setedColor, x: deletedPreviousAction.x, y: deletedPreviousAction.y)
        
        if deletedPreviousAction.setedColor != UIColor.white.cgColor {
            guard let width = width else {return}
            paintedPixelsArray.append(CGPoint(x: deletedPreviousAction.x * width, y: deletedPreviousAction.y * width))
        }
        
        previousTenActions.insert(deletedPreviousTenActions[0], at: 0)
        deletedPreviousTenActions.remove(at: 0)
        
    }
    
    private func draw(imageView:UIImageView,color:CGColor,x:CGFloat,y:CGFloat) {
        guard let width = width else {return}
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        imageView.image?.draw(in: imageView.bounds)
        context?.setFillColor(color)
        context?.fill(CGRect(x: x * width, y: y * width, width: width , height: width ))
        context?.strokePath()
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
}
