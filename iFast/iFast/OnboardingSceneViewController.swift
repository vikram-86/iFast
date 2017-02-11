//
//  OnboardingSceneViewController.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 11.02.2017.
//  Copyright (c) 2017 Suthananth Arulanatham. All rights reserved.
//


import UIKit

protocol OnboardingSceneViewControllerInput
{
  
}

protocol OnboardingSceneViewControllerOutput
{

}

class OnboardingSceneViewController: UIViewController, OnboardingSceneViewControllerInput
{
  var output: OnboardingSceneViewControllerOutput!
  var router: OnboardingSceneRouter!

  static var viewController: OnboardingSceneViewController? {
    let storyboard = UIStoryboard(name: String.init(describing: self), bundle: nil)
    return storyboard.instantiateInitialViewController() as? OnboardingSceneViewController
  }

  //MARK: IBOutlets
  @IBOutlet weak var textLabel: FastLabel!
  @IBOutlet weak var backgroundImageView: UIImageView!

  var backgroundImage: UIImage?
  var text: String = ""
  var page = 0
  var isLast = false


  // MARK: - Object lifecycle
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
    OnboardingSceneConfigurator.sharedInstance.configure(viewController: self)
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    backgroundImageView.image = backgroundImage
    textLabel.attributedText = createAttributedString()
    textLabel.sizeToFit()
  }
}

//MARK: - Display Logic -
extension OnboardingSceneViewController {

  fileprivate func createAttributedString()-> NSAttributedString{

    let textSize: CGFloat	= isLast ? 18 : 24
    let font 							= TextModifier.regular.font(with: textSize)

    return  text.textWithStroke(textColor: UIColor.FastDarkSlateBlue, strokeColor: UIColor.FastPurpleyGrey, strokeWidth: 1
      , font: font)
  }

}

// MARK: - Event Handler - 
extension OnboardingSceneViewController {

}
