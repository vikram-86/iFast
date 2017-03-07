//
//  PhotoView.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 06.03.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit


class PhotoView: UIView {

    var view : UIView!

    @IBOutlet weak var imageView	: UIImageView!
    
    @IBOutlet weak var weekLabel	: FastLabel!
    @IBOutlet weak var weightLabel	: FastLabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup(){
        view 					= loadFromNib()
        view.frame				= bounds
        view.autoresizingMask	= [.flexibleWidth, .flexibleHeight]

        weekLabel.attributedText 	= createAttributedString(with: "Week: 1")
        weightLabel.attributedText	= createAttributedString(with: "Weight: 75 Kg")

        addSubview(view)
    }

    private func loadFromNib()->UIView {
        let bundle	= Bundle(for: type(of: self))
        let nib		= UINib(nibName: "PhotoView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }

    private func createAttributedString(with string: String)->NSAttributedString{
        let attributes: [String:Any] = [NSFontAttributeName: TextModifier.medium.font(with: 24),
                          NSForegroundColorAttributeName: UIColor.FastFadedBlue,
                          NSStrokeColorAttributeName: UIColor.white,
                          NSStrokeWidthAttributeName: -2.0]

        return NSAttributedString(string: string, attributes: attributes)

    }
}
