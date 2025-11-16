//
//  NatGeoProjectApp.swift
//  NatGeoProject
//
//  Created by Mami RavaLoarison on 10/27/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct NatGeoProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var manageLocation = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(manageLocation: manageLocation)
                .environment(ViewsManager())
        }
    }
}
