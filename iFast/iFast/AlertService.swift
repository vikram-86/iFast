//
//  AlertService.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 17.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

enum AlertStyle {

  case success
  case error
  case information

  var image: UIImage {
    switch self {
    case .error				: return #imageLiteral(resourceName: "alert_Error")
    case .information	: return #imageLiteral(resourceName: "alert_Warning")
    case .success			: return #imageLiteral(resourceName: "alert_OK")
    }
  }

  var color : UIColor {
    switch self {
    case .success 		: return UIColor.FastPaleTeal
    case .error				:	return UIColor.FastGreyishPink
    case .information	:	return UIColor.FastSquash

    }
  }

}
protocol AlertServiceDelegate {
  func alertDidGetRemoved(with style: AlertStyle)
}
class AlertService {
  //static let current = AlertService()

  fileprivate var bgView: UIView!
  fileprivate var alertView : AlertView!
  var delegate: AlertServiceDelegate?
  var currentStyle: AlertStyle!
  func createAlert(title: String, style: AlertStyle, in controller: UIViewController){
    bgView = UIView(frame: CGRect(x:0,y:0,
                                      width: controller.view.bounds.width,
                                      height: controller.view.bounds.height))
    bgView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    bgView.isOpaque = false
    bgView.alpha = 0
		controller.view.addSubview(bgView)

    alertView = AlertView(frame: CGRect(x: 0, y:0, width: 300, height: 299))
    bgView.addSubview(alertView)
    alertView.delgate = self
    alertView.center = bgView.center
    alertView.view.isOpaque = false
		alertView.alpha = 1
    alertView.setupAlert(with: title, style: style)
    alertView.transform = CGAffineTransform(translationX: 0, y: 700)
    currentStyle = style


    UIView.animate(withDuration: 0.22, delay: 0, options: [], animations: {
      self.bgView.alpha = 1
    }) { (_) in
    }

    UIView.animate(withDuration: 0.25, delay: 0.22, usingSpringWithDamping: 0.6, initialSpringVelocity: 15, options: [.curveEaseInOut], animations: {
      self.alertView.transform = CGAffineTransform.identity
    }, completion: nil)
  }
}


extension AlertService: AlertViewDelegate {
  func buttonPressed(view: AlertView) {
    UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: {
      self.alertView.transform = CGAffineTransform(translationX: 0, y: 700)
      self.bgView.alpha = 0
    }) { (_) in
      self.bgView.removeFromSuperview()
      self.delegate?.alertDidGetRemoved(with: self.currentStyle)
    }
  }
}
