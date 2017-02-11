//
//  FastLabel.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 11.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

@IBDesignable
class FastLabel: UILabel {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()

  }

  @IBInspectable var strokeWidth: Float = 0.0 {
    didSet{
      configure()
    }
  }

  @IBInspectable var strokeColor: UIColor = UIColor.clear {
    didSet{
      configure()
    }
  }

  private func configure(){
    guard let titleText = text else { return }
    let attributedTitleText = titleText.textWithStroke(textColor: self.textColor, strokeColor: strokeColor, strokeWidth: CGFloat(strokeWidth), font: self.font)
    self.attributedText = attributedTitleText
  }

  //Interfacebuilder
  override func prepareForInterfaceBuilder() {
    configure()
  }
}
