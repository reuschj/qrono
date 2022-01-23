//
//  QronoApp.swift
//  Qrono
//
//  Created by Justin Reusch on 1/5/22.
//

import SwiftUI
import Combine

@main
struct QronoApp: App {
    
    @StateObject var qrono: Qrono = .shared

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(qrono)
        }
    }
}
