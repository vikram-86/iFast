//
//  SwipeViewStyleKit.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 20.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

public class SwipeViewStyleKit : NSObject {
  
  //// Drawing Methods
  
  class func drawSwipeView(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 300, height: 48), resizing: ResizingBehavior = .aspectFit, bgColor: UIColor = UIColor(red: 0.702, green: 0.929, blue: 0.824, alpha: 0.188), textColor: UIColor = UIColor(red: 0.588, green: 0.569, blue: 0.584, alpha: 1.000), sliderColor: UIColor = UIColor(red: 0.518, green: 0.867, blue: 0.925, alpha: 1.000), fillColor: UIColor = UIColor(red: 0.706, green: 0.929, blue: 0.824, alpha: 1.000), posX: CGFloat = 0, text : String = "Hello world") {
    //// General Declarations
    let context = UIGraphicsGetCurrentContext()!
    
    //// Resize to Target Frame
    context.saveGState()
    let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 300, height: 48), target: targetFrame)
    context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
    context.scaleBy(x: resizedFrame.width / 300, y: resizedFrame.height / 48)
    
    
    
    //// Variable Declarations
    let width: CGFloat = posX + 47
    
    //// Rectangle Drawing
    let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 300, height: 48), cornerRadius: 24)
    bgColor.setFill()
    rectanglePath.fill()
    
    
    //// Swipe to start fast Drawing
    let swipeToStartFastRect = CGRect(x: 0, y: 14, width: targetFrame.width, height: 21)
    let swipeToStartFastTextContent = text
    let swipeToStartFastStyle = NSMutableParagraphStyle()
    swipeToStartFastStyle.alignment = .center
    let swipeToStartFastFontAttributes = [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 24)!, NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName: swipeToStartFastStyle]
    
    let swipeToStartFastTextHeight: CGFloat = swipeToStartFastTextContent.boundingRect(with: CGSize(width: swipeToStartFastRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: swipeToStartFastFontAttributes, context: nil).height
    context.saveGState()
    context.clip(to: swipeToStartFastRect)
    swipeToStartFastTextContent.draw(in: CGRect(x: swipeToStartFastRect.minX, y: swipeToStartFastRect.minY + (swipeToStartFastRect.height - swipeToStartFastTextHeight) / 2, width: swipeToStartFastRect.width, height: swipeToStartFastTextHeight), withAttributes: swipeToStartFastFontAttributes)
    context.restoreGState()
    
    
    //// Rectangle 2 Drawing
    let rectangle2Path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width, height: 48), cornerRadius: 24)
    fillColor.setFill()
    rectangle2Path.fill()
    
    
    //// Oval Drawing
    let ovalPath = UIBezierPath(ovalIn: CGRect(x: posX, y: 0, width: 48, height: 48))
    sliderColor.setFill()
    ovalPath.fill()
    
    context.restoreGState()
  }
  
  @objc public enum ResizingBehavior: Int {
    case aspectFit /// The content is proportionally resized to fit into the target rectangle.
    case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
    case stretch /// The content is stretched to match the entire target rectangle.
    case center /// The content is centered in the target rectangle, but it is NOT resized.
    
    public func apply(rect: CGRect, target: CGRect) -> CGRect {
      if rect == target || target == CGRect.zero {
        return rect
      }
      
      var scales = CGSize.zero
      scales.width = abs(target.width / rect.width)
      scales.height = abs(target.height / rect.height)
      
      switch self {
      case .aspectFit:
        scales.width = min(scales.width, scales.height)
        scales.height = scales.width
      case .aspectFill:
        scales.width = max(scales.width, scales.height)
        scales.height = scales.width
      case .stretch:
        break
      case .center:
        scales.width = 1
        scales.height = 1
      }
      
      var result = rect.standardized
      result.size.width *= scales.width
      result.size.height *= scales.height
      result.origin.x = target.minX + (target.width - result.width) / 2
      result.origin.y = target.minY + (target.height - result.height) / 2
      return result
    }
  }
}


