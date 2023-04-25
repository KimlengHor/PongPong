//
//  PongPongApp.swift
//  PongPong
//
//  Created by Kimleng Hor on 4/4/23.
//

import SwiftUI
import FBSDKCoreKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FBSDKCoreKit.ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions
                )
        return true
    }
}

@main
struct PongPongApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            WelcomeView().onOpenURL { (url) in
                guard let urlScheme = url.scheme else { return }
                if urlScheme.hasPrefix("fb") {
                    ApplicationDelegate.shared.application(UIApplication.shared,
                                                           open: url,
                                                           sourceApplication: nil,
                                                           annotation: UIApplication.OpenURLOptionsKey.annotation) }
            }
        }
    }
}
