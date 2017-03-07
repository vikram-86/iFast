//
//  FastCameraService.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 06.03.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

protocol FastCameraServiceDelegate{

    func serviceDidFinish(with imageData: Data)
}

class FastCameraService: NSObject{
    
    var session				: AVCaptureSession?
    var stillImageOutput	: AVCapturePhotoOutput?
    var videoPreviewLayer 	: AVCaptureVideoPreviewLayer?

    var delegate	: FastCameraServiceDelegate?

    static var isCameraAuthorized: Bool{
        let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        switch authStatus{
        case .authorized, .notDetermined:
            return true
        default:
            return false
        }
    }

    static var isPhotoLibraryAuthorized: Bool {
		let authStatus = PHPhotoLibrary.authorizationStatus()
        switch authStatus{
        case .authorized, .notDetermined:
            return true
        default:
            return false
        }
    }

    func setupSession(in view: UIView){
        // Setup session
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSessionPresetPhoto

        // Select input device
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)

        // Prepare input
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do{
            input = try AVCaptureDeviceInput(device: backCamera)
        }catch let inputError as NSError{
			error = inputError
            input = nil
            print(error!.localizedDescription)
        }

        // Attach input
        if error == nil && session!.canAddInput(input){
            session!.addInput(input)
            // Configure the output
            stillImageOutput = AVCapturePhotoOutput()
            if session!.canAddOutput(stillImageOutput){
                session?.addOutput(stillImageOutput)

                videoPreviewLayer			= AVCaptureVideoPreviewLayer(session: session)
                videoPreviewLayer?.frame	= CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                videoPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
                videoPreviewLayer?.connection.videoOrientation = .portrait
                view.layer.addSublayer(videoPreviewLayer!)
                session?.startRunning()
            }
        }
    }

    func captureImage(){
        print("Taking picture!")
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String : previewPixelType,
                             kCVPixelBufferWidthKey as String: 160,
                             kCVPixelBufferHeightKey as String: 160]
        settings.previewPhotoFormat = previewFormat
        stillImageOutput?.capturePhoto(with: settings, delegate: self)
    }

    func stop(){
        session?.stopRunning()
    }
}

extension FastCameraService: AVCapturePhotoCaptureDelegate{

    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {

        if let error = error{
            print(error.localizedDescription)
            return
        }

        if let sampleBuffer = photoSampleBuffer,
        	let previewBuffer = previewPhotoSampleBuffer,
            let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer){
            delegate?.serviceDidFinish(with: dataImage)
        }
    }
}
