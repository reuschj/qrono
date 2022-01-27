//
//  MainDisplay.swift
//  Qrono
//
//  Created by Justin Reusch on 10/26/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import SwiftUI
import Combine
import RotatableStack

/**
 Main display content for clocks and date
 */
struct MainDisplay: View {

    /// Global app settings
    var timeEmitter: ClockTimeEmitter

    /// Global app settings
    @ObservedObject var settings: QronoSettings

    private var theme: QronoTheme.Settings { settings.theme.settings }
    
    private var visibleModules: VisibleModules { settings.visibleModules }
    
    var body: some View {
        RotatableStack {
            Spacer()
            if visibleModules.analogClock {
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
                        Spacer()
                        DigitalClockView(
                            timeEmitter: timeEmitter,
                            settings: settings
                        )
                            .padding()
                        Spacer()
                    }
                    if visibleModules.dateDisplay {
                        Spacer()
                        DateDisplayView(
                            timeEmitter: timeEmitter,
                            settings: settings
                        )
                            .padding()
                        Spacer()
                    }
                    Spacer()
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
        MainDisplay(
            timeEmitter: Qrono.shared.timeEmitter,
            settings: Qrono.shared.settings
        )
    }
}
