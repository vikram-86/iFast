//
//  PhotoDetailViewController.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 07.03.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var upperPhotoView: PhotoView!
    @IBOutlet weak var lowerPhotoView: PhotoView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupOnAppear()
    }

    private func setupOnAppear(){
        upperPhotoView.imageView.image = UIImage(named: "1")
        lowerPhotoView.imageView.image = UIImage(named: "2")
    }
}

extension PhotoDetailViewController{

    @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }
}
