//
//  OnboardingSceneModels.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 11.02.2017.
//  Copyright (c) 2017 Suthananth Arulanatham. All rights reserved.


import UIKit

struct OnboardingScene
{
  struct OnboardingRequest{
    struct ButtonTitleRequest {
      let page: Int
    }
  }

  struct OnboardingResponse{
    struct ButtonTitleResponse{
      let title												: String
      let page												: Int
      let shouldEnablePrimaryButton		: Bool
      let shouldEnableSecondaryButton	: Bool
    }
  }

  struct OnboardingViewModel{
    struct ButtonViewModel{

      let primaryIsHidden 	: Bool
      let secondaryIsHidden	: Bool
      let buttonTitle				: String
    }
  }
}
