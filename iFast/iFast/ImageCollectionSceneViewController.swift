//
//  ImageCollectionSceneViewController.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 05.03.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

class ImageCollectionSceneViewController: UIViewController {

    let imagePreviewSegueIdentifier = "imagePreview"
    let cameraSegueIdentifier		= "cameraSegue"
    
    @IBOutlet weak var photoCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnLoad()
    }

    private func setupOnLoad(){
        photoCollection.dataSource  = self
        photoCollection.delegate	= self
    }
}

//MARK: - Event handler
extension ImageCollectionSceneViewController{

    @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDatasource
extension ImageCollectionSceneViewController: UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0{
            return collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.cameraIdentifier, for: indexPath) as! PhotoCell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
            let imageName = "\(indexPath.row)"
            let viewModel = PhotoCellViewModel(imageName: imageName)
            cell.configureCell(viewModel: viewModel)
            return cell
        }
    }
}

//MARK: - UICollectionView Delegate

extension ImageCollectionSceneViewController: UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell else { return }
        if cell.reuseIdentifier == PhotoCell.cameraIdentifier{
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                performSegue(withIdentifier: cameraSegueIdentifier, sender: nil)
            }
        }
    }
}
