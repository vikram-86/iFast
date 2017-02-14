//
//  PushView.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 14.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

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

  }
}

//MARK: - UIPicker - 
extension PushView: UIPickerViewDataSource, UIPickerViewDelegate{
  fileprivate func setupUIPicker(){
    pickerView.delegate = self
    pickerView.dataSource = self
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
}
