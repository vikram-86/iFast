//
//  PushView.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 14.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

protocol PushViewDelegate{
  func view(didSelect hour: String, minutes: String, inView pushView: PushView)
  func viewWillClose(pushView: PushView)
}

class PushView: UIView {

  @IBOutlet weak var pickerView: UIPickerView!
  @IBOutlet weak var primaryButton: FastPrimaryButton!

  var hours : [String] {
    var h = [String]()
    for i in 0...23{
      h.append(String(format: "%02d", i))
    }
    return h
  }

  var minutes: [String] {
    var m = [String]()
    for i in 0...59{
      m.append(String(format: "%02d", i))
    }
    return m
  }

  var selectedHour		: String = ""
  var selectedMinutes	: String = ""

  var delegate	: PushViewDelegate?

  var view: UIView!
  //MARK: Initializers

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup(){
    view = loadViewFromNib()
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.backgroundColor = UIColor.FastPaleGreyTwo
    setupUIPicker()
    addSubview(view)
  }

  private func loadViewFromNib()-> UIView{
    let bundle = Bundle(for: type(of:self))
    let nib = UINib(nibName: "PushView", bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    return view
  }
}

//MARK: - Event Handler
extension PushView {

  @IBAction func primaryButtonPressed(){
    delegate?.view(didSelect: selectedHour, minutes: selectedMinutes, inView: self)
  }

  @IBAction func closeButtonPressed(){
    delegate?.viewWillClose(pushView: self)
  }
}

//MARK: - UIPicker - 
extension PushView: UIPickerViewDataSource, UIPickerViewDelegate{
  fileprivate func setupUIPicker(){
    pickerView.delegate = self
    pickerView.dataSource = self

    let calender = Calendar.current
    let calendarComponents = calender.dateComponents([.hour, .minute], from: Date())
    guard let hour = calendarComponents.hour,
      let minutes = calendarComponents.minute else { return }

    pickerView.selectRow(hour, inComponent: 0, animated: true)
    pickerView.selectRow(minutes, inComponent: 1, animated: true)
  }

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 2
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return component == 0 ? hours.count : minutes.count
  }

  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

    let label = UILabel()
    label.font = TextModifier.regular.font(with: 26)
    label.textColor = UIColor.FastDarkSlateBlue
    label.text = component == 0 ? hours[row] : minutes[row]
    label.textAlignment = .center
    return label
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if component == 0 {
      selectedHour = hours[row]
    }else{
      selectedMinutes = minutes[row]
    }
  }
}
