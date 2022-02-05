//
//  MainWatchDisplay.swift
//  Qrono WatchKit Extension
//
//  Created by Justin Reusch on 1/23/22.
//

import SwiftUI

struct MainWatchDisplay: View {

    /// Global app settings
    var timeEmitter: ClockTimeEmitter
    
    /// Global app settings
    @ObservedObject var settings: QronoSettings
    
    private var theme: QronoTheme.Settings { settings.theme.settings }

    var body: some View {
        TabView {
            // Analog clock tab ----------------- /
            AnalogClockView(
                timeEmitter: timeEmitter,
                settings: settings
            )
                .padding(.top, UIMeasurement(5).value)
                .padding(.bottom, UIMeasurement(3).value)
                .ignoresSafeArea(edges: .all)

            // Digital + date tab ----------------- /
            VStack {
                Spacer(minLength: UIMeasurement(3).value)
                // Digital clock ----- /
                DigitalClockView(
                    timeEmitter: timeEmitter,
                    settings: settings
                )
                // Date display ----- /
                DateDisplayView(
                    timeEmitter: timeEmitter,
                    settings: settings
                )
                Spacer()
            }

            // Settings tab --------------------- /
            WatchSettingsPanel(
                timeEmitter: timeEmitter,
                settings: settings
            )

        }
        .ignoresSafeArea(edges: .all)
    }
}

struct MainWatchDisplay_Previews: PreviewProvider {
    static var previews: some View {
        MainWatchDisplay(
            timeEmitter: Qrono.shared.timeEmitter,
            settings: Qrono.shared.settings
        )
    }
}
