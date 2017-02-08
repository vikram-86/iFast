//: Playground - noun: a place where people can play

import UIKit

func getFont()->UIFont{
  guard let font = UIFont(name: "AvenirNext-Regular", size: 20)else {
    return UIFont.systemFont(ofSize: 20)
  }
  return font
}


getFont()