//
//  OnboardingSceneConfigurator.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 11.02.2017.
//  Copyright (c) 2017 Suthananth Arulanatham. All rights reserved.


import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension OnboardingSceneViewController: OnboardingScenePresenterOutput
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    // router.passDataToNextScene(segue: segue)
  }
}

extension OnboardingSceneInteractor: OnboardingSceneViewControllerOutput
{
}

extension OnboardingScenePresenter: OnboardingSceneInteractorOutput
{
}

class OnboardingSceneConfigurator
{
  // MARK: - Object lifecycle
  
  static let sharedInstance = OnboardingSceneConfigurator()
  
  private init() {}
  
  // MARK: - Configuration
  
  func configure(viewController: OnboardingSceneViewController)
  {
    let router = OnboardingSceneRouter()
    router.viewController = viewController
    
    let presenter = OnboardingScenePresenter()
    presenter.output = viewController
    
    let interactor = OnboardingSceneInteractor()
    interactor.output = presenter
    
    viewController.output = interactor
    viewController.router = router
  }
}
