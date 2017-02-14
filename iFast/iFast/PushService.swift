//
//  PushService.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 13.02.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import UIKit
import UserNotifications

class PushService {

  class func getCurrentAuthorization(status:@escaping (UNAuthorizationStatus)->Void) {
    UNUserNotificationCenter.current().getNotificationSettings { (settings) in
      status(settings.authorizationStatus)
    }
  }

  class func requestNotificationAuthorization(completion: @escaping (Bool, Error?)->Void){
    let options: UNAuthorizationOptions = [.alert, .sound]
    UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
      completion(success, error)
    }
  }
}
