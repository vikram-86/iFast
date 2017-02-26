//
//  InfoDetailSceneViewController.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 26.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

class InfoDetailSceneViewController: UIViewController {

  @IBOutlet weak var headerImageView									: UIImageView!
  @IBOutlet weak var textView													: UITextView!
  @IBOutlet weak var headerImageViewHeightConstraint	: NSLayoutConstraint!

  let maxHeaderHeight	: CGFloat = 300
  let minHeaderHeight	: CGFloat = 80

  override var prefersStatusBarHidden: Bool{
    return true
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    textView.delegate = self
  }
}

extension InfoDetailSceneViewController: UITextViewDelegate{

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    let newConstraint = maxHeaderHeight - scrollView.contentOffset.y
    guard newConstraint >= minHeaderHeight else {
			print(newConstraint)
      print(headerImageViewHeightConstraint.constant)
      return }
    guard newConstraint <= maxHeaderHeight else { return }

    headerImageViewHeightConstraint.constant = newConstraint
    UIView.animate(withDuration: 0.0) { 
      self.view.layoutIfNeeded()
    }
  }
}
