//
//  FastPickerViewDelegate.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 03.03.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

class FastModalView: UIView {
    var delegate: FastPickerViewDelegate?
}

protocol FastPickerViewDelegate{

    func pickerViewDidCancel()
    func pickerViewDidSelect(weight: Measurement<UnitMass>)
    func pickerViewDidSelect(hour: Int)
    func pickerViewDidSelectPush(hour: String, minutes: String)
}

//TODO: Convert This to class so that we can override functions afterwards?
//protocol FastPickerView{
//    var delegate : FastPickerViewDelegate? { get set }
//}

class FastPickerViewManager: FastPickerViewDelegate{

    func pickerViewDidCancel() {}
    func pickerViewDidSelect(weight: Measurement<UnitMass>) {}
    func pickerViewDidSelect(hour: Int) {}
    func pickerViewDidSelectPush(hour: String, minutes: String) {}
}
