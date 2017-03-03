//
//  ProfileSceneConfigurator.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 02.03.2017.
//  Copyright (c) 2017 Suthananth Arulanatham. All rights reserved.


import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension ProfileSceneViewController: ProfileScenePresenterOutput
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    // router.passDataToNextScene(segue: segue)
  }
}

extension ProfileSceneInteractor: ProfileSceneViewControllerOutput
{
}

extension ProfileScenePresenter: ProfileSceneInteractorOutput
{
}

class ProfileSceneConfigurator
{
  // MARK: - Object lifecycle
  
  static let sharedInstance = ProfileSceneConfigurator()
  
  private init() {}
  
  // MARK: - Configuration
  
  func configure(viewController: ProfileSceneViewController)
  {
    let router = ProfileSceneRouter()
    router.viewController = viewController
    
    let presenter = ProfileScenePresenter()
    presenter.output = viewController
    
    let interactor = ProfileSceneInteractor()
    interactor.output = presenter
    
    viewController.output = interactor
    viewController.router = router
  }
}
