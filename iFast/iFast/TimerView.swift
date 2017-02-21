//
//  TimerView.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 19.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

class TimerView: UIView {

  var currentProgess: CGFloat = 0 {
    didSet{
      setNeedsDisplay()
    }
  }
  override func draw(_ rect: CGRect) {
    // Drawing code
    TimerViewUtil.drawCanvas(frame: rect, progress: currentProgess)
  }
}
