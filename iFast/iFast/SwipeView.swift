//
//  SwipeView.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 20.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

protocol SwipeViewDelegate {
  func swipeDidChange(progress: CGFloat)
}

class SwipeView: UIView {

  var xPos          : CGFloat = 0
  var lastLocation  : CGPoint = CGPoint.zero
  var gestureFrame  : UIView!
  var currentTitle  : String = "Swipe to start fast"
  var delegate      : SwipeViewDelegate?
  
  // Only override draw() if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func draw(_ rect: CGRect) {
      // Drawing code
    SwipeViewStyleKit.drawSwipeView(posX: xPos, text: currentTitle)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
  private func setupView(){
    // Create gesture view
    gestureFrame = UIView(frame: CGRect(x: xPos, y: 0, width: 50, height: 50))
    gestureFrame.backgroundColor = .clear
    addSubview(gestureFrame)
    
    // create gesture
    let gesture = UIPanGestureRecognizer(target: self, action: #selector(swiped(gesture:)))
    gestureFrame.addGestureRecognizer(gesture)
  }
  

}

//MARK: - Gesture recognizer
extension SwipeView{
  
  func swiped(gesture: UIPanGestureRecognizer){
    let translation = gesture.translation(in: self)
    var newPos = lastLocation.x + translation.x
    newPos = newPos > (300 - 48) ? (300 - 48) : newPos
    newPos = newPos < 0 ?  0 : newPos
    
    if gesture.state == .ended{
      resetSwipe()
      return
      
    }
    xPos = newPos
    gestureFrame.frame.origin.x = newPos
    let progress = newPos / (frame.width - 48)//newPos == 0 ? 0 : ((newPos + 48) / frame.width)
    delegate?.swipeDidChange(progress: progress)
    setNeedsDisplay()
  }
  
  private func resetSwipe(){
    xPos = 0
    lastLocation = CGPoint.zero
    delegate?.swipeDidChange(progress: 0)
    gestureFrame.frame.origin.x = xPos
  }
}
