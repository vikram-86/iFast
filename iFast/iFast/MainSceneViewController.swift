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
    
  }
  
  private func setupOnLoad(){
    
    swipeView.delegate = self
    // Add Tapp Gesture to TimerView
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(timerViewTapped(gesture:)))
    tapGesture.numberOfTapsRequired = 1
    timerView.addGestureRecognizer(tapGesture)
  }
}

//MARK: - Display Logic -
extension MainSceneViewController {

}

// MARK: - Event Handler - 
extension MainSceneViewController {
  
  @IBAction func infoButtonPressed(){
    
  }
  
  @IBAction func profileButtonPressed(){
    
  }
  
  func timerViewTapped(gesture: UITapGestureRecognizer){
    print("Timer View Tapped!")
  }
}

//MARK: - SwipeView Delegate
extension MainSceneViewController: SwipeViewDelegate{
  func swipeDidChange(progress: CGFloat) {
    timerView.currentProgess = progress
  }
}
