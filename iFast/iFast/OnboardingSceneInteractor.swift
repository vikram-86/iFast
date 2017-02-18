//
//  OnboardingSceneInteractor.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 11.02.2017.
//  Copyright (c) 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit

protocol OnboardingSceneInteractorInput
{
  func setupButtonTitle(request: OnboardingScene.OnboardingRequest.ButtonTitleRequest)
  func handlePush(request: OnboardingScene.OnboardingRequest.PushRequest)
}

protocol OnboardingSceneInteractorOutput
{
  func setupButtonTitle(response: OnboardingScene.OnboardingResponse.ButtonTitleResponse)
  func prepareAlert(response: OnboardingScene.OnboardingResponse.PushResponse)
}

class OnboardingSceneInteractor: OnboardingSceneInteractorInput
{
  var output: OnboardingSceneInteractorOutput!
  var worker: OnboardingSceneWorker!
  
  // MARK: - Business logic
  func setupButtonTitle(request: OnboardingScene.OnboardingRequest.ButtonTitleRequest) {

    let title									: String
    let shouldEnablePrimary		: Bool
    let shouldEnableSecondary	: Bool
    if request.page == 2 {
      title 								= "Enable Notifications"
      shouldEnablePrimary 	= true
      shouldEnableSecondary	= true
    }else if request.page == 3{
      title									= "Start iFast"
      shouldEnableSecondary	= false
      shouldEnablePrimary		= true
    }else{
      title								 	= ""
      shouldEnablePrimary		= false
      shouldEnableSecondary	= false
    }

    let response = OnboardingScene.OnboardingResponse.ButtonTitleResponse(title: title,
                                                                          page: request.page,
                                                                          shouldEnablePrimaryButton: shouldEnablePrimary,
                                                                          shouldEnableSecondaryButton: shouldEnableSecondary)
    output.setupButtonTitle(response: response)
  }
  
  func handlePush(request: OnboardingScene.OnboardingRequest.PushRequest) {
    worker = OnboardingSceneWorker()
    worker.delegate = self
    worker.handlePush(request: request)
  }
}

extension OnboardingSceneInteractor: OnboardingSceneWorkerDelegate{
  func didFinishHandlingPush(title: String, style: AlertStyle) {
    let response = OnboardingScene.OnboardingResponse.PushResponse(title: title,
                                                                   alertStyle: style)
    output.prepareAlert(response: response)
  }
}
