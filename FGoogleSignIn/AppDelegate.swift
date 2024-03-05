//
//  AppDelegate.swift
//  FGoogleSignIn
//
//  Created by Rambali Kumar on 03/03/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import iZootoiOSSDK
//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        FirebaseApp.configure()
//        
//        
//        return true
//    }
//
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
//    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
//      return GIDSignIn.sharedInstance.handle(url)
//    }
//
//
//}



//import UIKit


@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, iZootoNotificationOpenDelegate, iZootoNotificationReceiveDelegate, iZootoLandingURLDelegate {
  // handle deeplink
  func onNotificationOpen(action: Dictionary<String, Any>) {
    print(action)
  }
  
  // Handle url
  func onHandleLandingURL(url: String) {
    // setlandingURL
    print("ClickURL",url)
  }
  
  // Notification Received
  func onNotificationReceived(payload: Payload) {
    print("Payload",payload.alert?.body! as Any )
  }
  
  var i = 0
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
    // for setting
    let iZootoInitSettings = ["auto_prompt": true,"nativeWebview": true, "provisionalAuthorization":false]
    iZooto.initialisation(izooto_id: "6f72e55ef8191561ec89ef550be312f0b9e685a4", application: application, iZootoInitSettings:iZootoInitSettings)
    
    UNUserNotificationCenter.current().delegate = self
    iZooto.notificationOpenDelegate = self
    iZooto.notificationReceivedDelegate = self
    iZooto.landingURLDelegate = self
      
      // for google sign in
      FirebaseApp.configure()// for firebase google sing in
      guard let clientID = FirebaseApp.app()?.options.clientID else { return false }
      print("ClientID: \(clientID)")
      // Create Google Sign In configuration object.
      let config = GIDConfiguration(clientID: clientID)
      GIDSignIn.sharedInstance.configuration = config
      
      //end google sign in
      return true
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    iZooto.getToken(deviceToken: deviceToken)
  }
  
  @available(iOS 10.0, *)
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)     {
    iZooto.handleForeGroundNotification(notification: notification, displayNotification: "None", completionHandler: completionHandler)
  }
  
  // @available(iOS 10.0, *)
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    iZooto.notificationHandler(response: response) //iZooto.notificationHandler
    completionHandler()
  }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
    // Helper function to get the topmost view controller
//    private func getTopViewController() -> UIViewController? {
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//            let sceneDelegate = windowScene.delegate as? SceneDelegate else {
//            return nil
//        }
//
//        var topViewController = sceneDelegate.window?.rootViewController
//
//        while let presentedViewController = topViewController?.presentedViewController {
//            topViewController = presentedViewController
//        }
//
//        return topViewController
//    }
    
//    func googleSignIn(){
//        DispatchQueue.main.async {
//            //This will run on the main queue, after the previous code in outer block
//            
//            GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
//                if error != nil || user == nil {
//                    // Show the app's signed-out state.
//                    print("signed out")
//                    GIDSignIn.sharedInstance().signIn(withPresenting: self) { signInResult, error in
////                        guard error == nil else { return }
//                        guard error == nil else {
//                                // Handle the error, e.g., user canceled sign-in
//                                print("Google Sign-In canceled or failed with error: \(error)")
//                            UserDefaults.standard.set("false", forKey: "isLogedIn")
//                                return
//                            }
//                        print("signing in.......")
//                        let userName = signInResult?.user.profile?.name
//                        let email = signInResult?.user.profile?.email
//                        print("Name: \(userName)")
//                        print("Email: \(email)")
//                        UserDefaults.standard.set("true", forKey: "isLogedIn")
//                        let a = UserDefaults.standard.value(forKey: "isLogedIn")
//                        print("a = \(a)")
//                        
//                        iZooto.syncUserDetailsEmail(email: email!, fName: userName!, lName: "")
//                        // If sign in succeeded, display the app's main content View.
//                    }
//                } else {
//                    // Show the app's signed-in state.
//                    UserDefaults.standard.set("true", forKey: "isLogedIn")
//                    print("Signed In")
//                    
//                }
//            }
//        }
//    }
}
