//
//  QronoApp.swift
//  Qrono
//
//  Created by Justin Reusch on 1/5/22.
//

import SwiftUI

@main
struct QronoApp: App {
    
    var qrono: Qrono = .shared

    var body: some Scene {
        WindowGroup {
            ContentView(qrono: qrono)
        }
    }
}
