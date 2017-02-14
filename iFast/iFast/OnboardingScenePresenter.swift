//
//  OnboardingScenePresenter.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 11.02.2017.
//  Copyright (c) 2017 Suthananth Arulanatham. All rights reserved.
//


import UIKit

protocol OnboardingScenePresenterInput
{
  func setupButtonTitle(response: OnboardingScene.OnboardingResponse.ButtonTitleResponse)
}

protocol OnboardingScenePresenterOutput: class
{
  func presentButtonConfigurations(viewModel: OnboardingScene.OnboardingViewModel.ButtonViewModel)
}

class OnboardingScenePresenter: OnboardingScenePresenterInput
{
  weak var output: OnboardingScenePresenterOutput!
  
  // MARK: - Presentation logic
  func setupButtonTitle(response: OnboardingScene.OnboardingResponse.ButtonTitleResponse) {

    let primaryIsHidden 	= !response.shouldEnablePrimaryButton
    let secondaryIsHidden	= !response.shouldEnableSecondaryButton

    let viewModel = OnboardingScene.OnboardingViewModel.ButtonViewModel(primaryIsHidden: primaryIsHidden, secondaryIsHidden: secondaryIsHidden, buttonTitle: response.title)

    output.presentButtonConfigurations(viewModel: viewModel)
  }

}
