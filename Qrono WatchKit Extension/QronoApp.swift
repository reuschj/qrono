//
//  QronoApp.swift
//  Qrono WatchKit Extension
//
//  Created by Justin Reusch on 1/5/22.
//

import SwiftUI

@main
struct QronoApp: App {

    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
