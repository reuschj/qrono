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
        TabView {
            AnalogClockView(
                timeEmitter: qrono.timeEmitter,
                settings: qrono.settings
            ).padding(8)
            DigitalClockView(
                timeEmitter: qrono.timeEmitter,
                settings: qrono.settings
            ).padding(8)
        }.ignoresSafeArea(edges: .all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(qrono: Qrono.shared)
    }
}
