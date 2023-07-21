//
//  AppDelegate.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/12/23.
//

import SwiftUI
import BranchSDK
import Firebase
import FirebaseCore
import FirebaseMessaging

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let gcmMessageIDKey = "gcm.Message_ID"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )

        application.registerForRemoteNotifications()
        
        // Messaging Delegate
        Messaging.messaging().delegate = self

        
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
        
          }
        }
        
        //Branch.setUseTestBranchKey(true)
        //Branch.getInstance().enableLogging()
        // Remove from Production
        // Branch.getInstance().validateSDKIntegration()
 //       Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
//            print(params as? [String: AnyObject] ?? {})
//            print("DEBUG: params String \(params as? [String: AnyObject] ?? [:])")
//            // Access and use deep link data here (nav to page, display content, etc.)
//            guard let paramDict = params as? [String: AnyObject] else { return }
//            
//            if paramDict["nav_to"] as? String == "groupPlannerView" {
//                guard let tripID = paramDict["tripID"], let hurdID = paramDict["hurdID"] else { return }
//                
//               let nc = NetworkCalls()
//                Task {
//                    guard let trip = await nc.fetchTrip(with: tripID as! String),
//                          let hurd = await nc.fetchHurd(with: hurdID as! String) else { return }
//                    
//                    print("DEBUG: We made it past this point-- yaya")
//                    let groupVM = GroupPlannerViewModel(trip: trip, hurd: hurd)
//                    let groupView = GroupPlannerView(vm: groupVM)
//                    
//                }
//              
//            }
//
        return true
        }
        

    }


// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
      // Receive displayed notifications for iOS 10 devices.
      func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  willPresent notification: UNNotification) async
        -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // ...

        // Print full message.
        print(userInfo)

        // Change this to your preferred presentation option
        return [[.alert, .sound]]
      }

      func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo

        // ...

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // Print full message.
        print(userInfo)
      }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
      -> UIBackgroundFetchResult {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)

      return UIBackgroundFetchResult.newData
    }

    
    
}

// MARK: - MessagingDelegate

extension AppDelegate: MessagingDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Yay!, Got a device token \(deviceToken)")
        Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

}
