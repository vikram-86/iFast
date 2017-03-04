//
//  ProfileSceneViewController.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 02.03.2017.
//  Copyright (c) 2017 Suthananth Arulanatham. All rights reserved.
//


import UIKit

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
}

// MARK: - Util
extension ProfileSceneViewController {

    func setupViewOnLoad(){
        profileView.layer.cornerRadius = profileView.bounds.height * 0.5
    }
}
