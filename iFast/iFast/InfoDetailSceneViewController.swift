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

  fileprivate let normalHeaderHeight	: CGFloat = 310
  fileprivate let minHeaderHeight     : CGFloat = 80
  fileprivate let maxHeaderHeight     : CGFloat = 380

  override var prefersStatusBarHidden: Bool{
    return true
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    textView.delegate = self
  }
}

//MARK: -Event Handling
extension InfoDetailSceneViewController{
  fileprivate func updateHeaderView(_ contentOffset: CGPoint){
    //print("contentOffset: \(contentOffset.y)")
    let contentY =  normalHeaderHeight + (-contentOffset.y)
    print(contentY)
    let heightPercent = (contentY / normalHeaderHeight)
    if heightPercent > 0.98{
      UIView.animate(withDuration: 0.1, animations: {
        self.headerImageView.transform = CGAffineTransform(scaleX: heightPercent, y: heightPercent)
      })
      
    }else if contentY > minHeaderHeight{
      headerImageViewHeightConstraint.constant = contentY
      UIView.animate(withDuration: 0.1, animations: {
        self.view.layoutIfNeeded()
      })
      
    }
  }
  
  fileprivate func resetHeaderView(){
    if headerImageViewHeightConstraint.constant > normalHeaderHeight - 100{
      headerImageViewHeightConstraint.constant = normalHeaderHeight
      UIView.animate(withDuration: 0.33, animations: {
        self.view.layoutIfNeeded()
        self.headerImageView.transform = CGAffineTransform.identity
      })
    }
  }
}

//MARK: - UITextfield Delegate
extension InfoDetailSceneViewController: UITextViewDelegate{

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    updateHeaderView(scrollView.contentOffset)
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    print("Scrolling Decelerated")
    resetHeaderView()
  }
}
