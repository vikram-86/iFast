//
//  UIButton + FastPrimaryButton.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 08.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

@IBDesignable
class FastPrimaryButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initialSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialSetup()
  }
  
  private func initialSetup(){
    layer.cornerRadius  = 10
    backgroundColor     =  UIColor.FastPaleTeal
  }

  @IBInspectable
  var customTitle: String = "" {
    didSet{
      setCustomFastTitle(customTitle)
    }
  }
  
  func setCustomFastTitle(_ title: String){
    let fontAttributes  = [NSForegroundColorAttributeName: UIColor.FastDarkSlateBlue.withAlphaComponent(0.6), NSFontAttributeName: TextModifier.regular.font(with: 24)]
    let attributedTitle = NSAttributedString(string: title, attributes: fontAttributes)
    setAttributedTitle(attributedTitle, for: .normal)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    initialSetup()
  }
  
  override func prepareForInterfaceBuilder() {
    initialSetup()
    setCustomFastTitle("")
  }
}
