//
//  ProfileSceneViewController.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 02.03.2017.
//  Copyright (c) 2017 Suthananth Arulanatham. All rights reserved.
//


import UIKit
import AVFoundation
import Photos

protocol ProfileSceneViewControllerInput
{
  
}

protocol ProfileSceneViewControllerOutput
{

}

class ProfileSceneViewController: UIViewController, ProfileSceneViewControllerInput
{
  	var output: ProfileSceneViewControllerOutput!
  	var router: ProfileSceneRouter!

    var viewController: ProfileSceneViewController? {
        let storyboard = UIStoryboard(name: String.init(describing: self), bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String.init(describing: self)) as? ProfileSceneViewController
    }


    @IBOutlet weak var profileView		: UIView!
    @IBOutlet weak var profileImageView	: UIImageView!

    let picker = UIImagePickerController()
  
  // MARK: - Object lifecycle
  
  	override func awakeFromNib()
 	 {
    	super.awakeFromNib()
        ProfileSceneConfigurator.sharedInstance.configure(viewController: self)
 	 }
  
  // MARK: - View lifecycle
  
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViewOnLoad()
        
    }
}

//MARK: - Display Logic -
extension ProfileSceneViewController {

}

// MARK: - Event Handler - 
extension ProfileSceneViewController {

    @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }

    @IBAction func addWeight(){

        PickerManager.manager.displayAlert(in: self, with: .weight)
    }

    func changeProfileImage(gesture: UITapGestureRecognizer){
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let cameraAction = UIAlertAction(title: "Take Photo", style: .default) { (_) in
            self.getPhoto(from: .camera)
        }
        let libraryAction = UIAlertAction(title: "Select Photo", style: .default) { (_) in
            self.getPhoto(from: .photoLibrary)
        }
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        actionSheet.addAction(cameraAction)
        actionSheet.addAction(libraryAction)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }
}

extension ProfileSceneViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func getPhoto(from source: UIImagePickerControllerSourceType){
        let isAllowed = source == .camera ? checkAuthForCamera() : checkAuthForPhotos()
        if isAllowed{
            DispatchQueue.main.async {
                self.picker.delegate = self
                self.picker.sourceType = source
                self.present(self.picker, animated: true, completion: nil)
            }
        }else{
            DispatchQueue.main.async {
                AlertService().createAlert(title: "Camera/Photos access denied! Please change it in settings", style: .error, in: self)
            }
        }
    }

    private func checkAuthForCamera()->Bool{
        let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        switch authStatus{
        case .authorized, .notDetermined:
            return true
        default:
            return false
        }
    }

    private func checkAuthForPhotos()->Bool{
        let authStatus = PHPhotoLibrary.authorizationStatus()
        switch authStatus {
        case .authorized, .notDetermined:
            return true
        default:
            return false
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        profileImageView.image = chosenImage
        profileImageView.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Util
extension ProfileSceneViewController {

    func setupViewOnLoad(){
        profileView.layer.cornerRadius 	= profileView.bounds.height * 0.5
        profileView.layer.borderWidth 	= 2
        profileView.layer.borderColor	= UIColor.FastFadedBlue.cgColor
        addGesture()
    }

    fileprivate func addGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeProfileImage(gesture:)))
        profileView.addGestureRecognizer(tapGesture)
    }
}
