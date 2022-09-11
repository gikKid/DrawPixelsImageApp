//
//  GalleryViewController.swift
//  PixelVIPER
//
//  Created by MacBook Air 13 Retina 2018 on 20.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import UIKit

protocol GalleryViewControllerProtocol {
    func passEditImage(imageName:String)
}

final class GalleryViewController: UIViewController {
    
    var namesImages = [String]()
    let defaults = UserDefaults.standard
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    var delegate:GalleryViewControllerProtocol?
    
    let noOneImagesImageView = UIImageView()
    let noOneImagesTextLabel = UILabel()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    var rootTabBar:UITabBarController
    
    var presenter:(ViewToPresenterGalleryProtocol & InteractorToPresenterGalleryProtocol)?
    
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
        presenter?.checkTheme(view:self.view, collectionView: collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getSavedImageNames(namesArray: &namesImages)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.presenter?.checkTheme(view: self.view, collectionView: self.collectionView)
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        noOneImagesImageView.translatesAutoresizingMaskIntoConstraints = false
        noOneImagesImageView.image = UIImage(systemName: "eye.slash")
        noOneImagesImageView.contentMode = .scaleToFill
        
        noOneImagesTextLabel.text = "There are no images :("
        noOneImagesTextLabel.translatesAutoresizingMaskIntoConstraints = false
        noOneImagesTextLabel.textColor = UIColor(named: Constants.blueColorButton)
        noOneImagesTextLabel.font = .boldSystemFont(ofSize: 25)
        
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identefier)
        collectionView.register(GalleryCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GalleryCollectionReusableView.identefier)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


}


//MARK: - CollectionDelegate
extension GalleryViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.namesImages.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identefier, for: indexPath) as? GalleryCollectionViewCell {
            cell.delegate = self
            cell.setupCell()
            cell.nameLabel.text = self.namesImages[indexPath.row]
            presenter?.loadImage(imageName: self.namesImages[indexPath.row], imageView: cell.imageView)
            return cell
        }
        fatalError("Unable to dequeue note cell")
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize (width: view.frame.size.width - 30, height: view.frame.size.height / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GalleryCollectionReusableView.identefier, for: indexPath) as? GalleryCollectionReusableView {
            header.setupView()
            return header
        }
        fatalError("Unable to dequeue header")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.size.width, height: 50)
    }
    
    
}


//MARK: - PresenterToViewProtocol
extension GalleryViewController:PresenterToViewGalleryProtocol {
    func failureShowActivityView(errorMessage: String) {
        present(errorAlertController(errorMessage),animated: true)
    }
    
    func showSaveActivityView(activityVC: UIActivityViewController) {
        present(activityVC,animated: true)
    }
    
    func showDeleteAlert(alertController: UIAlertController) {
        present(alertController,animated: true)
    }
    
    func successfulReloadContent(newImageNamesArray:[String]) {
        self.namesImages = newImageNamesArray
        DispatchQueue.main.async {
        }
        self.collectionView.reloadData()
    }
    
    func showFailureDeleteImage(errorMessage: String) {
        present(errorAlertController(errorMessage),animated: true)
    }
    
    func errorLoadImage(errorMessage: String) {
        present(errorAlertController(errorMessage),animated: true)
    }
    
    
}

//MARK: GalleryCellDelegate
extension GalleryViewController:GalleryCellProtocol {
    func editImage(imageName: String) {
        delegate?.passEditImage(imageName:imageName)
        rootTabBar.selectedIndex = 0
    }
    
    func failureEditImage(errorMessage: String) {
        present(errorAlertController(errorMessage),animated: true)
    }
    
    func failureSaveImage(errorMessage: String) {
        present(errorAlertController(errorMessage),animated: true)
    }
    
    func saveImage(imageName:String) {
        presenter?.savePicture(imageName: imageName)
    }
    
    func deleteImage(imageName: String) {
        presenter?.deleteImage(imageName: imageName)
    }
    
    func failureDeleteImage(errorMessage: String) {
        present(errorAlertController(errorMessage),animated: true)
    }
    
    
}
