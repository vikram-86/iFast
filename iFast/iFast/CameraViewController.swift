//
//  CameraViewController.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 07.03.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {

    @IBOutlet weak var cameraView: CameraView!

    override func viewDidLoad() {
        super.viewDidLoad()

        cameraView.delegate = self
    }
}

extension CameraViewController: CameraViewDelegate{
    func cameraViewDidEndSession() {
        dismiss(animated: true, completion: nil)
    }

    func cameraView(didFinishWith image: UIImage) {
        print("Image received!")
    }
}
