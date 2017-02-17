//
//  AlertView.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 14.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

protocol AlertViewDelegate {
  func buttonPressed(view: AlertView)
}

class AlertView: UIView {

  var view: UIView!
  @IBOutlet weak var primaryButton	: FastPrimaryButton!
  @IBOutlet weak var imageBgView		: UIView!
  @IBOutlet weak var alertImageView	: UIImageView!
  @IBOutlet weak var text						: UILabel!
  @IBOutlet weak var alertBGView		: UIView!

  var delgate: AlertViewDelegate?

  //MARK: - Initializers


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
    backgroundColor = .clear
    alertImageView.layer.cornerRadius = alertImageView.bounds.height * 0.5
    imageBgView.layer.cornerRadius = imageBgView.bounds.height * 0.5
    alertBGView.layer.cornerRadius = 20
    isOpaque = false
    addSubview(view)
  }

  private func loadViewFromNib()->UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "AlertView", bundle: bundle)
    return nib.instantiate(withOwner: self, options: nil)[0] as! UIView
  }

  func setupAlert(with text: String, style: AlertStyle){

    self.primaryButton.customBackgroundColor	= style.color
    self.text.text 														= text
    self.alertImageView.image 								= style.image
  }
  @IBAction func buttonPressed() {
    delgate?.buttonPressed(view: self)
  }
}
