//
//  OnboardingSceneViewController.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 11.02.2017.
//  Copyright (c) 2017 Suthananth Arulanatham. All rights reserved.
//


import UIKit

protocol OnboardingSceneViewControllerDelegate {
  func controllerDidSkipPage(controller: OnboardingSceneViewController)
  func controllerDidPressPrimaryButton(controller: OnboardingSceneViewController)
  func controllerWillShowPushView(controller: OnboardingSceneViewController)
  func controllerWillHidePushView(controller: OnboardingSceneViewController)
}

protocol OnboardingSceneViewControllerInput
{
  func presentButtonConfigurations(viewModel: OnboardingScene.OnboardingViewModel.ButtonViewModel)

}

protocol OnboardingSceneViewControllerOutput
{
  func setupButtonTitle(request: OnboardingScene.OnboardingRequest.ButtonTitleRequest)
}

class OnboardingSceneViewController: UIViewController, OnboardingSceneViewControllerInput
{
  var output		: OnboardingSceneViewControllerOutput!
  var router		: OnboardingSceneRouter!
  var delegate	: OnboardingSceneViewControllerDelegate?

  static var viewController: OnboardingSceneViewController? {
    let storyboard = UIStoryboard(name: String.init(describing: self), bundle: nil)
    return storyboard.instantiateInitialViewController() as? OnboardingSceneViewController
  }

  //MARK: IBOutlets
  @IBOutlet weak var textLabel						: FastLabel!
  @IBOutlet weak var backgroundImageView	: UIImageView!
  @IBOutlet weak var primaryButton				: FastPrimaryButton!
  @IBOutlet weak var secondaryButton			: UIButton!


  var backgroundImage	: UIImage?
  var text						: String = ""

  var page 		= 0
  var isLast	= false


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

    backgroundImageView.image	= backgroundImage
    textLabel.attributedText 	= createAttributedString()

    textLabel.sizeToFit()
    setupButtonTitles()
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

  fileprivate func setupButtonTitles(){
    let request = OnboardingScene.OnboardingRequest.ButtonTitleRequest(page: page)
    output.setupButtonTitle(request: request)
  }

  func presentButtonConfigurations(viewModel: OnboardingScene.OnboardingViewModel.ButtonViewModel) {
    primaryButton.customTitle	= viewModel.buttonTitle
    primaryButton.fontSize		= 20
    primaryButton.isHidden 		= viewModel.primaryIsHidden
    secondaryButton.isHidden 	= viewModel.secondaryIsHidden
  }
}

// MARK: - Event Handler - 
extension OnboardingSceneViewController {

  @IBAction func skipButtonPressed(){
    delegate?.controllerDidSkipPage(controller: self)
  }

  @IBAction func primaryButtonPressed(){
    //delegate?.controllerDidPressPrimaryButton(controller: self)
    if page == 2 {
      delegate?.controllerWillShowPushView(controller: self)
      createPushView()
    }else{
      delegate?.controllerDidPressPrimaryButton(controller: self)
    }
  }

  private func createPushView(){
    let pushView = PushView(frame: CGRect(x: 0, y: view.frame.height, width: view.bounds.width, height: 400))
    pushView.delegate = self
    view.addSubview(pushView)
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
      pushView.frame.origin.y -= pushView.bounds.height
    }, completion: nil)
  }

  fileprivate func removePushView(pushView: PushView){
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
      pushView.frame.origin.y += pushView.bounds.height
    }) { (completed) in
      self.delegate?.controllerWillHidePushView(controller: self)
      pushView.removeFromSuperview()
    }
  }
}

//MARK: - PushView Delegate
extension OnboardingSceneViewController: PushViewDelegate{

  func view(didSelect hour: String, minutes: String, inView pushView: PushView) {
		PushService.getCurrentAuthorization { (status) in
      switch status {
      case .notDetermined:
        // Request Authorization
        print("Not Determined")
        PushService.requestNotificationAuthorization(completion: { (success, error) in
          if !success {
            print("Access not granted!")
            return
          }
        })
      case .denied:
        // Inform user that User needs to set Authorization
        print("Denied")
      case .authorized:
        // Everything OK.. Create Local Notifications
        print("Authorized")
      }
    }
    removePushView(pushView: pushView)
  }

  func viewWillClose(pushView: PushView) {
    removePushView(pushView: pushView)
  }
}
