//
//  PhotoCell.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 05.03.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    static let identifier 		= "photoCell"
    static let cameraIdentifier = "cameraCell"

    @IBOutlet weak var imageView: UIImageView!

    func configureCell(viewModel: PhotoCellViewModel){
        if viewModel.imageName == "camera"{
            imageView.contentMode = .center
        }

        imageView.image = UIImage(named: viewModel.imageName)
        imageView.contentMode = .scaleAspectFill
    }
}
