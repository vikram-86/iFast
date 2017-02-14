//: Playground - noun: a place where people can play

import UIKit

func getFont()->UIFont{
  guard let font = UIFont(name: "AvenirNext-Regular", size: 20)else {
    return UIFont.systemFont(ofSize: 20)
  }
  return font
}




getFont()


func createStrokeFonts(text: String, fontColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat)->NSAttributedString{
  let attributes: [String: Any] = [NSFontAttributeName: UIFont.systemFont(ofSize: 72), NSForegroundColorAttributeName: fontColor,
                                   NSStrokeColorAttributeName: strokeColor, NSStrokeWidthAttributeName: strokeWidth]
  return NSAttributedString(string: text, attributes: attributes)
}

let text = createStrokeFonts(text: "Hallo", fontColor: .white, strokeColor: .red, strokeWidth: -1.0)

let test = String(format: "%02d",1)