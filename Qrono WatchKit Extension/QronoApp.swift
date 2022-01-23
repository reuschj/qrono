//
//  QronoApp.swift
//  Qrono WatchKit Extension
//
//  Created by Justin Reusch on 1/5/22.
//

import SwiftUI

@main
struct QronoApp: App {

    var qrono: Qrono = .shared

    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(qrono: qrono)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
