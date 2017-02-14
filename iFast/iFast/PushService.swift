//
//  PushService.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 13.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit
import UserNotifications

enum PushServiceStatus{

  case authorized
  case notDetermined
  case denied

  static func createStatus(settingsStatus: UNAuthorizationStatus) -> PushServiceStatus{
    switch settingsStatus{
    case .authorized:
      return .authorized
    case .notDetermined:
      return .notDetermined
    case .denied:
      return .denied
    }
  }
}

class PushService {

  class func getCurrentAuthorization(status:@escaping (PushServiceStatus)->Void) {
    UNUserNotificationCenter.current().getNotificationSettings { (settings) in
      status(PushServiceStatus.createStatus(settingsStatus: settings.authorizationStatus))
    }
  }

  class func requestNotificationAuthorization(completion: @escaping (Bool, Error?)->Void){
    let options: UNAuthorizationOptions = [.alert, .sound]
    UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
      completion(success, error)
    }
  }
}
