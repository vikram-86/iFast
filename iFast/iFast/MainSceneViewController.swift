//
//  MainSceneViewController.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 19.02.2017.
//  Copyright (c) 2017 Suthananth Arulanatham. All rights reserved.
//


import UIKit

protocol MainSceneViewControllerInput
{
  
}

protocol MainSceneViewControllerOutput
{

}

class MainSceneViewController: UIViewController, MainSceneViewControllerInput
{
  var output: MainSceneViewControllerOutput!
  var router: MainSceneRouter!
  
  static var viewController: MainSceneViewController? {
    let storyboard = UIStoryboard(name: String.init(describing: self), bundle: nil)
    return storyboard.instantiateInitialViewController() as? MainSceneViewController
  }
  // MARK: - Object lifecycle
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
    MainSceneConfigurator.sharedInstance.configure(viewController: self)
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()

  }
}

//MARK: - Display Logic -
extension MainSceneViewController {

}

// MARK: - Event Handler - 
extension MainSceneViewController {

}
