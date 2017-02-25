//
//  InfoSceneViewController.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 24.02.2017.
//  Copyright (c) 2017 Suthananth Arulanatham. All rights reserved.
//


import UIKit

protocol InfoSceneViewControllerInput
{
  
}

protocol InfoSceneViewControllerOutput
{

}

class InfoSceneViewController: UIViewController, InfoSceneViewControllerInput
{
  var output: InfoSceneViewControllerOutput!
  var router: InfoSceneRouter!

  var viewController : InfoSceneViewController? {
    let storyboard = UIStoryboard(name: String.init(describing: self), bundle: nil)
    return storyboard.instantiateInitialViewController() as? InfoSceneViewController
  }
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
    InfoSceneConfigurator.sharedInstance.configure(viewController: self)
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()

  }
}

//MARK: - Display Logic -
extension InfoSceneViewController {

}

// MARK: - Event Handler - 
extension InfoSceneViewController {

  @IBAction func closeButtonPressed(){
    dismiss(animated: true, completion: nil)
  }
}
