//
//  TestViewController.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 14.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var photoViewUpper: PhotoView!
    @IBOutlet weak var photoViewLower: PhotoView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photoViewUpper.imageView.image = UIImage(named: "1")
        photoViewLower.imageView.image = UIImage(named: "2")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
