//
//  MainDisplay.swift
//  Qrono
//
//  Created by Justin Reusch on 10/26/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import SwiftUI
import RotatableStack

/**
 Main display content for clocks and date
 */
struct MainDisplay: View {

    @ObservedObject var qrono: Qrono

    /// Global app settings
    var timeEmitter: ClockTimeEmitter { qrono.timeEmitter }

    /// Global app settings
    var settings: QronoSettings { qrono.settings }

    private var theme: QronoTheme.Settings { qrono.settings.theme.settings }
    
    private var visibleModules: VisibleModules { qrono.settings.visibleModules }
    
    var body: some View {
        RotatableStack {
            Spacer()
            if qrono.settings.visibleModules.analogClock {
                AnalogClockView(
                    timeEmitter: timeEmitter,
                    settings: settings
                )
                    .padding()
            }
            if visibleModules.digitalClock || visibleModules.dateDisplay {
                VStack {
                    Spacer()
                    if visibleModules.digitalClock {
                        DigitalClockView(
                            timeEmitter: timeEmitter,
                            settings: settings
                        )
                            .padding()
                        Spacer()
                    }
                    if visibleModules.dateDisplay {
                        DateDisplayView(
                            timeEmitter: timeEmitter,
                            settings: settings
                        )
                            .padding()
                        Spacer()
                    }
                }
            }
        }
        .navigationBarItems(
            trailing: SettingsLink(color: theme.settingsLinkColor)
        )
    }
}

struct MainDisplay_Previews: PreviewProvider {
    static var previews: some View {
        MainDisplay(qrono: Qrono.shared)
            .environmentObject(Qrono.shared)
    }
}
