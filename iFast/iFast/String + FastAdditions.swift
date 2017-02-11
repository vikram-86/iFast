//
//  String + FastAdditions.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 11.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

extension String {

  // Creates a string with stroke effect
  func textWithStroke(textColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat, font: UIFont) -> NSAttributedString{
    let attributes: [String: Any] = [NSFontAttributeName: font, NSForegroundColorAttributeName: textColor,
                      NSStrokeWidthAttributeName: -strokeWidth, NSStrokeColorAttributeName: strokeColor]
    return NSAttributedString(string: self, attributes: attributes)

  }
}
