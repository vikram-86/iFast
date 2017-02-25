//
//  InfoSceneConfigurator.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 24.02.2017.
//  Copyright (c) 2017 Suthananth Arulanatham. All rights reserved.


import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension InfoSceneViewController: InfoScenePresenterOutput
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    // router.passDataToNextScene(segue: segue)
  }
}

extension InfoSceneInteractor: InfoSceneViewControllerOutput
{
}

extension InfoScenePresenter: InfoSceneInteractorOutput
{
}

class InfoSceneConfigurator
{
  // MARK: - Object lifecycle
  
  static let sharedInstance = InfoSceneConfigurator()
  
  private init() {}
  
  // MARK: - Configuration
  
  func configure(viewController: InfoSceneViewController)
  {
    let router = InfoSceneRouter()
    router.viewController = viewController
    
    let presenter = InfoScenePresenter()
    presenter.output = viewController
    
    let interactor = InfoSceneInteractor()
    interactor.output = presenter
    
    viewController.output = interactor
    viewController.router = router
  }
}
