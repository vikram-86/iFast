//
//  TimerViewUtil.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 19.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

public class TimerViewUtil: NSObject {
  
  class func drawCanvas(frame: CGRect = CGRect(x: 0, y: 0, width: 320, height: 320), progress: CGFloat = 0.412) {
    //// General Declarations
    // This non-generic function dramatically improves compilation times of complex expressions.
    func fastFloor(_ x: CGFloat) -> CGFloat { return floor(x) }
    
    //// Color Declarations
    let bgColor = UIColor(red: 0.588, green: 0.569, blue: 0.584, alpha: 0.400)
    let fillColor = UIColor(red: 0.506, green: 0.890, blue: 0.843, alpha: 1.000)
    
    //// Variable Declarations
    let resultAngle: CGFloat = -1 * progress * 360 + 90
    
    //// bg Drawing
    let bgPath = UIBezierPath(ovalIn: CGRect(x: frame.minX + fastFloor((frame.width - 300) * 0.47500) + 0.5, y: frame.minY + fastFloor((frame.height - 300) * 0.52500) + 0.5, width: 300, height: 300))
    bgColor.setStroke()
    bgPath.lineWidth = 5
    bgPath.stroke()
    //// fill Drawing
    let fillRect = CGRect(x: frame.minX + fastFloor((frame.width - 300) * 0.50000 + 0.5), y: frame.minY + fastFloor((frame.height - 300) * 0.50000 + 0.5), width: 300, height: 300)
    let fillPath = UIBezierPath()
    fillPath.addArc(withCenter: CGPoint(x: fillRect.midX, y: fillRect.midY), radius: fillRect.width / 2, startAngle: -90 * CGFloat.pi/180, endAngle: -resultAngle * CGFloat.pi/180, clockwise: true)
    
    fillColor.setStroke()
    fillPath.lineWidth = 5
    fillPath.stroke()
  }
}
