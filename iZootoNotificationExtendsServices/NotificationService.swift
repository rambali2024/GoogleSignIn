//
//  NotificationService.swift
//  iZootoNotificationExtendsServices
//
//  Created by Rambali Kumar on 04/03/24.
//

import UserNotifications
import iZootoiOSSDK

class NotificationService: UNNotificationServiceExtension {
  var contentHandler: ((UNNotificationContent) -> Void)?
  var bestAttemptContent: UNMutableNotificationContent?
  var receivedRequest: UNNotificationRequest!
  
  override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
    print("Response",request)
    self.receivedRequest = request;
    self.contentHandler = contentHandler
    bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
    
    if let bestAttemptContent = bestAttemptContent {
      iZooto.didReceiveNotificationExtensionRequest(bundleName :"izooto.FGoogleSignIn", soundName: "", isBadge: true, request: receivedRequest, bestAttemptContent: bestAttemptContent,contentHandler: contentHandler)
    }
  }
  
  override func serviceExtensionTimeWillExpire() {
    if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {
      contentHandler(bestAttemptContent)
    }
  }
}
