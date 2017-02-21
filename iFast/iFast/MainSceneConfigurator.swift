//
//  MainSceneConfigurator.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 19.02.2017.
//  Copyright (c) 2017 Suthananth Arulanatham. All rights reserved.


import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension MainSceneViewController: MainScenePresenterOutput
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    // router.passDataToNextScene(segue: segue)
  }
}

extension MainSceneInteractor: MainSceneViewControllerOutput
{
}

extension MainScenePresenter: MainSceneInteractorOutput
{
}

class MainSceneConfigurator
{
  // MARK: - Object lifecycle
  
  static let sharedInstance = MainSceneConfigurator()
  
  private init() {}
  
  // MARK: - Configuration
  
  func configure(viewController: MainSceneViewController)
  {
    let router = MainSceneRouter()
    router.viewController = viewController
    
    let presenter = MainScenePresenter()
    presenter.output = viewController
    
    let interactor = MainSceneInteractor()
    interactor.output = presenter
    
    viewController.output = interactor
    viewController.router = router
  }
}
