//
//  NotificaitonNames.swift
//  iFast
//
//  Created by Suthananth Arulanatham on 04.03.2017.
//  Copyright © 2017 Suthananth Arulanatham. All rights reserved.
//

import Foundation

enum FastNotificationName{
    case timerPicked
    case pushCreated

    var notificationName: Notification.Name {
        switch self {
        case .timerPicked:
            return Notification.Name("timerPicked")
        case .pushCreated:
            return Notification.Name("pushCreated")
        }
    }
}
