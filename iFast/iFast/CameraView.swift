//
//  CameraView.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 06.03.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

protocol CameraViewDelegate {
    func cameraView(didFinishWith image: UIImage)
    func cameraViewDidEndSession()
}

class CameraView: UIView {

    var view: UIView!

    @IBOutlet weak var shutterButton					: UIButton!
    @IBOutlet weak var saveButton						: UIButton!
    @IBOutlet weak var retakeButton						: UIButton!
    @IBOutlet weak var buttonContainerHeightConstraint	: NSLayoutConstraint!
    @IBOutlet weak var previewView						: UIView!
    @IBOutlet weak var buttonContainerView				: UIView!
    @IBOutlet weak var previewImageView					: UIImageView!



    var delegate : CameraViewDelegate?

    fileprivate let imageViewOffset			: CGFloat = 500
    fileprivate let buttonContainerOffset	: CGFloat = 48

    fileprivate let cameraService = FastCameraService()

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
        view.frame 				= bounds
        view.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
        addSubview(view)
        buttonContainerView.transform = CGAffineTransform(translationX: 0, y: buttonContainerOffset)
		previewImageView.alpha = 0
        previewImageView.transform = CGAffineTransform(translationX: imageViewOffset, y: 0)
        cameraService.delegate = self
        cameraService.setupSession(in: previewView)
    }

    private func loadFromNib()->UIView{
        let bundle 	= Bundle(for: type(of:self))
        let nib 	= UINib(nibName: "CameraView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
}

//MARK: - Event Handler

extension CameraView {

    @IBAction func shutterButtonPressed(){
        cameraService.captureImage()
    }

    @IBAction func close(){
        cameraService.stop()
        delegate?.cameraViewDidEndSession()
    }

    @IBAction func retakePicture(){
        cameraService.setupSession(in: previewView)
        UIView.animate(withDuration: 0.33, animations: { 
            self.buttonContainerView.transform = CGAffineTransform(translationX: 0, y: self.buttonContainerOffset)
			self.previewImageView.alpha = 0
        }) { (_) in
            self.previewImageView.transform = CGAffineTransform(translationX: self.imageViewOffset, y: 0)
            self.previewImageView.image = nil
        }
    }

    @IBAction func saveImage(){
        guard let image = previewImageView.image else { return }
        delegate?.cameraView(didFinishWith: image)
    }
}

extension CameraView: FastCameraServiceDelegate{

    func serviceDidFinish(with imageData: Data) {
        guard let image = UIImage(data: imageData) else { return }
        previewImageView.image = image
        cameraService.stop()
        previewImageView.transform = .identity
        UIView.animate(withDuration: 0.33) { 
            self.previewImageView.alpha = 1
            self.buttonContainerView.transform = .identity
        }
    }
}
