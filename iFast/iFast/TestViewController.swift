//
//  TestViewController.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 14.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  @IBAction func buttonPressed(_ sender: Any) {
    print("buttonPressed")
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "test2") as? Test2ViewController else { return }

    present(vc, animated: true) {

      UIView.animate(withDuration: 0.1, animations: {
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
      })
    }
  }
}
