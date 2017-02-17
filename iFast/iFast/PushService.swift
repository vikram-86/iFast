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
  
  class func createNotifications(hour: Int, minutes: Int, completion: @escaping(Bool)->Void){
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    let notificationText = "Prepare to start your fast in 1 hour.\nKeep up the good work!"
    
    
    let dateComponents = DateComponents( hour: hour, minute: minutes)
    guard let triggerDaily = Calendar.current.date(from: dateComponents)?.addingTimeInterval(-3600) else { return }
    let triggerComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: triggerDaily)
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: true)
    
    let content = UNMutableNotificationContent()
    content.title = "Your fast is beginning soon"
    content.body = notificationText
    let request = UNNotificationRequest(identifier: "fast-begins", content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request) { (error) in
      if let error = error {
        print(error.localizedDescription)
        completion(false)
      }else{
        completion(true)
      }
    }
    
  }
}
