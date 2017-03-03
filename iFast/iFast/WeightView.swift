//
//  WeightView.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 03.03.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

class WeightView: UIView{

    fileprivate let weight 				= Array(40...300)
    fileprivate let fraction 			= Array(0...9)
    fileprivate let measurement			= ["KG", "LBS"]



    @IBOutlet weak var picker: UIPickerView!
    var view		: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView(){
        view = loadFromNib()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		picker.dataSource = self
        picker.delegate = self
		addSubview(view)
    }


    private func loadFromNib()->UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "WeightView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}

extension WeightView: UIPickerViewDataSource, UIPickerViewDelegate{

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return weight.count
        }else if component == 1{
			return fraction.count
        }
        return measurement.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label 				= UILabel()
        let fontSize: CGFloat 	= component == 2 ? 20 : 36
        label.font 				= TextModifier.regular.font(with: fontSize)
        label.textColor			= UIColor.FastDarkSlateBlue
        label.text 				= getItem(row: row, component: component)
        label.textAlignment 	= .center
        return label
    }

    fileprivate func getItem(row: Int, component: Int) -> String{
        if component == 0 {
            return "\(weight[row])"
        }else if component == 1{
			return  "\(fraction[row])"
        }
        return measurement[row]
    }
}
