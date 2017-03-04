//
//  PickerManager.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 03.03.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

enum PickerStyle{
    case push
    case weight
    case timer

    func getView(frame: CGRect) -> FastModalView {
        switch self {
        case .push:
            return PushView(frame: frame) as! FastModalView
        case .weight:
            return WeightView(frame: frame)
        case .timer:
            return TimePickerView(frame: frame)
        }
    }
}

class PickerManager: FastPickerViewManager{

    static let manager = PickerManager()
    var backgroundView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: UIScreen.main.bounds.width,
                                              height: UIScreen.main.bounds.height))

    fileprivate var pickerView: FastModalView!

    fileprivate func setupBackground(with image: UIImage?){

        backgroundView.backgroundColor = image != nil ? UIColor(patternImage: image!) : .black
        let blurEffect 			= UIBlurEffect(style: .dark)
        let blurEffectView		= UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame	= backgroundView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.addSubview(blurEffectView)
    }

    fileprivate func  getsnapshot(of view: UIView)-> UIImage?{
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    fileprivate func getPickerView(by style: PickerStyle)->FastModalView{
        let frame			= CGRect(x: 0,
                 			         y: UIScreen.main.bounds.height,
                 			         width: UIScreen.main.bounds.width,
                 			         height: 400)

        pickerView = style.getView(frame: frame)
		pickerView.delegate = self
        return pickerView
    }

    override func pickerViewDidSelect(weight: Measurement<UnitMass>) {
        print("did Select: \(weight)")
        dismissAlert()
    }

    override func pickerViewDidCancel() {
        print("Did Cancel")
		dismissAlert()
    }

    override func pickerViewDidSelect(hour: Int) {
        let userDict = ["hour":hour]
        NotificationCenter.default.post(name:
            FastNotificationName.timerPicked.notificationName, object: userDict)
        dismissAlert()
    }

    override func pickerViewDidSelectPush(hour: String, minutes: String) {
        print("Selected hour")
        let userDict = ["hour": hour, "minutes": minutes]
        NotificationCenter.default.post(name: FastNotificationName.pushCreated.notificationName, object: userDict)
        dismissAlert()
    }
}

// MARK: - Public API 
extension PickerManager{
    func displayAlert(in controller: UIViewController, with style: PickerStyle){

        setupBackground(with: getsnapshot(of: controller.view))

        backgroundView.alpha	= 0
        pickerView 				= getPickerView(by: style)
        backgroundView.addSubview(pickerView)
        controller.view.addSubview(backgroundView)

        UIView.animate(withDuration: 0.33) {
            self.backgroundView.alpha = 1
            self.pickerView.transform = CGAffineTransform(translationX: 0, y: -400)
            
        }
    }

    func dismissAlert(){
        UIView.animate(withDuration: 0.33, animations: { 
            self.pickerView.transform = .identity
            self.backgroundView.alpha = 0
        }) { (finished) in
            self.backgroundView.removeFromSuperview()
            self.backgroundView.subviews.forEach{$0.removeFromSuperview()}
            self.pickerView = nil
        }
    }
}
