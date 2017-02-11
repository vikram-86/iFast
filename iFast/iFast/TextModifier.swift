//
//  TextModifier.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 08.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

enum TextModifier: String {
  
  case regular  = "AvenirNext-Regular"
  case demiBold = "AvenirNext-DemiBold"
  case medium		= "AvenirNext-Medium"
  
  func font(with size: CGFloat = 18) -> UIFont{
    guard let font = UIFont(name: self.rawValue, size: size) else {
      return UIFont.systemFont(ofSize: size)
    }
    return font
  }
}
