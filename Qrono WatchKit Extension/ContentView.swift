//
//  ContentView.swift
//  Qrono WatchKit Extension
//
//  Created by Justin Reusch on 1/5/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AnalogClockView(
                timeEmitter: Qrono.shared.timeEmitter,
                settings: Qrono.shared.settings
            ).padding(8)
            DigitalClockView(
                timeEmitter: Qrono.shared.timeEmitter,
                settings: Qrono.shared.settings
            ).padding(8)
        }.ignoresSafeArea(edges: .all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
