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
  
  //MARK: IBOutlets
  @IBOutlet weak var numberOfCurrentStreakLabel : UILabel!
  @IBOutlet weak var numberOfLongestStreakLabel : UILabel!
  @IBOutlet weak var timerView                  : TimerView!
  @IBOutlet weak var timerViewLabel             : UILabel!
  @IBOutlet weak var swipeView                  : SwipeView!
  
  
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
    swipeView.delegate = self

  }
}

//MARK: - Display Logic -
extension MainSceneViewController {

}

// MARK: - Event Handler - 
extension MainSceneViewController {

}

//MARK: - SwipeView Delegate
extension MainSceneViewController: SwipeViewDelegate{
  func swipeDidChange(progress: CGFloat) {
    timerView.currentProgess = progress
  }
}
