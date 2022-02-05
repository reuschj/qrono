//
//  ContentView.swift
//  Qrono WatchKit Extension
//
//  Created by Justin Reusch on 1/5/22.
//

import SwiftUI
import Combine

struct ContentView: View {

    @ObservedObject var qrono: Qrono
    
    var body: some View {
        
        NavigationView {
            ZStack {
                MainWatchDisplay(
                    timeEmitter: Qrono.shared.timeEmitter,
                    settings: Qrono.shared.settings
                )
            }
        }
        .environmentObject(qrono)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(qrono: Qrono.shared)
    }
}
