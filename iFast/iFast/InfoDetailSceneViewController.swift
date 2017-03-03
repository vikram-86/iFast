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

  fileprivate let normalHeaderHeight	: CGFloat = 300
  fileprivate let minHeaderHeight			: CGFloat = 180
  fileprivate let actualHeaderHeight	: CGFloat = 400

  override var prefersStatusBarHidden: Bool{
    return true
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    textView.delegate = self
  }
}

//MARK: -UITextViewDelegate
extension InfoDetailSceneViewController: UITextViewDelegate{

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    updateHeader(contentOffset: scrollView.contentOffset)
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let offset = normalHeaderHeight + (-scrollView.contentOffset.y)
    resetHeader(offset: offset)
  }
}


// MARK: Event Handler
extension InfoDetailSceneViewController{

    @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }
}


//MARK: Header Util
extension InfoDetailSceneViewController{

  fileprivate func  updateHeader(contentOffset: CGPoint){
    let contentY 			= normalHeaderHeight + (-contentOffset.y)
    let percent 			= contentY / normalHeaderHeight
    let currentOffset	= actualHeaderHeight + (-contentOffset.y)

    if percent > 0.95{
      scaleHeaderView(percent: percent)
    }else if currentOffset > minHeaderHeight{
      shrinkHeight(offset: currentOffset)
    }
  }

  fileprivate func resetHeader(offset: CGFloat){
    if offset > normalHeaderHeight - 100 {
      headerImageViewHeightConstraint.constant = actualHeaderHeight
      UIView.animate(withDuration: 0.33, delay: 0, options: [.allowUserInteraction], animations: { 
        self.headerImageView.transform = .identity
        self.view.layoutIfNeeded()
      }, completion: nil)
    }
  }

  fileprivate func scaleHeaderView(percent: CGFloat){
    headerImageView.transform = CGAffineTransform(scaleX: percent, y: percent)
  }

  fileprivate func  shrinkHeight(offset: CGFloat){
    headerImageViewHeightConstraint.constant = offset
    UIView.animate(withDuration: 0) {
      self.view.layoutIfNeeded()
    }
  }
}
