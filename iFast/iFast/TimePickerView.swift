//
//  TimePickerView.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 21.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

class TimePickerView: UIView{
  
  var view: UIView!
  
  var dataSource: [Int]{
    var times = [Int]()
    for i in 12...24 {
      times.append(i)
    }
    return times
  }
  
  var selectedHour = 12
  
  //MARK: Initialization
  @IBOutlet weak var pickerView: UIPickerView!
  
  private func setup(){
    view = loadFromNib()
    view.frame = bounds
    view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    setupPickerView()
    alpha = 0
    addSubview(view)
  }
  
  
  private func loadFromNib()->UIView{
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "TimePickerView", bundle: bundle)
    return nib.instantiate(withOwner: self, options: nil)[0] as! UIView
  }
  
  @IBAction func buttonPressed() {
    
  }
}

//MARK: UIPickerView DataSource and Delegate
extension TimePickerView: UIPickerViewDelegate, UIPickerViewDataSource{
  fileprivate func setupPickerView(){
    pickerView.delegate = self
    pickerView.dataSource = self
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return dataSource.count
  }
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    
    let label = UILabel()
    label.font = TextModifier.regular.font(with: 40)
    label.textColor = UIColor.FastDarkSlateBlue
    label.text = "\(dataSource[row])"
    label.textAlignment = .center
    return label
  }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectedHour = dataSource[row]
  }
}

// MARK: Present and dismiss Animation
extension TimePickerView {
  func present(in view: UIView){
    
  }
}
