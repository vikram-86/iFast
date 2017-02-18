//
//  OnboardingSceneWorker.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 11.02.2017.
//  Copyright (c) 2017 Suthananth Arulanatham. All rights reserved.


import UIKit

protocol OnboardingSceneWorkerDelegate {
  func didFinishHandlingPush(title: String, style: AlertStyle)
}

class OnboardingSceneWorker
{
  
  var delegate: OnboardingSceneWorkerDelegate?
  // MARK: - Business Logic
  func handlePush(request: OnboardingScene.OnboardingRequest.PushRequest){
    PushService.getCurrentAuthorization { (status) in
      switch status{
      case .denied:
        let title = "Access to show alerts was not granted. Plase change this on your phone's settings"
        self.delegate?.didFinishHandlingPush(title: title, style: .error)
      case .notDetermined:
        self.requestAuhtorizationForPush(hour: request.hour, minutes: request.minutes)
      case .authorized:
        self.createNotification(hour: request.hour, minutes: request.minutes)
      }
    }
  }
  
  private func requestAuhtorizationForPush(hour: Int, minutes: Int){
    PushService.requestNotificationAuthorization { (success, error) in
      if !success {
        let title = "Access to show alerts was not granted. Please change this on your phone's settings"
        self.delegate?.didFinishHandlingPush(title: title, style: .error)
      }else{
        self.createNotification(hour: hour, minutes: minutes)
      }
    }
  }
  
  private func createNotification(hour: Int, minutes: Int){
    PushService.createNotifications(hour: hour, minutes: minutes) { (success) in
      let title = success ? "Nice! iFast will notify you 1 hour before your fast begins":
                            "Ouch! Something went wrong! Please try again"
      let style : AlertStyle = success ? .success : .error
      self.delegate?.didFinishHandlingPush(title: title, style: style)
    }
  }
}
