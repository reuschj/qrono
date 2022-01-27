//
//  WatchSettingsPanel.swift
//  Qrono WatchKit Extension
//
//  Created by Justin Reusch on 1/23/22.
//

import SwiftUI

/// A shortcut to use on this page to get the app settings instance
fileprivate var qronoSettings: QronoSettings = Qrono.shared.settings

struct WatchSettingsPanel: View {

    /// This will keep the current time, updated on a regular interval
    @ObservedObject var timeEmitter: ClockTimeEmitter

    /// Global app settings
    @ObservedObject var settings: QronoSettings
    
    init(timeEmitter: ClockTimeEmitter, settings: QronoSettings) {
        self.timeEmitter = timeEmitter
        self.settings = settings
        qronoSettings = settings
    }
    
    /// Theme to use
    private var theme = Binding<QronoTheme>(
        get: { qronoSettings.theme },
        set: { qronoSettings.theme = $0 }
    )
    
    /// Type of clock, 12 or 24-hour
    private var clockType = Binding<ClockType>(
        get: { qronoSettings.clockType },
        set: {
            qronoSettings.clockType = $0
            Qrono.shared.timeEmitter.clockType = $0
        }
    )
    
    /// How often the emitter updates the current time to the clock
    private var clockPrecision = Binding<ClockPrecision>(
        get: { qronoSettings.precision },
        set: {
            qronoSettings.precision = $0
            Qrono.shared.timeEmitter.precision = qronoSettings.actualPrecision
        }
    )
    
    /// Show the tick marks
    private var showTickMarks = Binding<Bool>(
        get: { qronoSettings.analogClockOptions.tickMarks },
        set: { qronoSettings.analogClockOptions.tickMarks = $0 }
    )
    
    /// Show the AM/PM period display
    private var showPeriodDisplay = Binding<Bool>(
        get: { qronoSettings.analogClockOptions.periodDisplay },
        set: { qronoSettings.analogClockOptions.periodDisplay = $0 }
    )
    
    /// Show the tick/tock pendulum
    private var showTickTockDisplay = Binding<Bool>(
        get: { qronoSettings.analogClockOptions.tickTockDisplay },
        set: { qronoSettings.tickTockDisplay = $0 }
    )
    
    /// Makes a string of text describing the current clock precision
    private func getPrecisionText() -> String {
        let updatesPerSecond = Int(round(1 / timeEmitter.interval))
        return "\(updatesPerSecond) \(updatesPerSecond > 1 ? strings.updatesPlu : strings.updatesSing)"
    }
    
    private let frameHeight: UIMeasurement = .init(8)

    var body: some View {
        ScrollView {
            Picker(
                strings.theme,
                selection: theme,
                content: {
                    ForEach(
                        QronoTheme.themes.values.sorted(by: <),
                        id: \.key
                    ) {
                        Text($0.label)
                            .tag($0)
                    }
                }
            )
                .frame(height: frameHeight.value)

            Picker(
                selection: clockType,
                label: Text(strings.clockType),
                content: {
                    Text(strings.twelveHour)
                        .tag(ClockType.twelveHour)
                    Text(strings.twentyFourHour)
                        .tag(ClockType.twentyFourHour)
                    Text(strings.decimal)
                        .tag(ClockType.decimal)
                }
            )
                .frame(height: frameHeight.value)
            
            Picker(
                selection: clockPrecision,
                label: Text(strings.precision),
                content: {
                    Text(strings.low).tag(ClockPrecision.low)
                    Text(strings.medium).tag(ClockPrecision.medium)
                    Text(strings.high).tag(ClockPrecision.high)
                }
            )
                .frame(height: frameHeight.value)
            
            Toggle(isOn: showTickMarks) {
                Text(strings.showTickMarks)
            }
            .padding(.vertical, UIMeasurement(2).value)
            .padding(.trailing, UIMeasurement().value)

            Toggle(isOn: showPeriodDisplay) {
                Text(strings.showPeriodDisplay)
            }
            .padding(.vertical, UIMeasurement(2).value)
            .padding(.trailing, UIMeasurement().value)

            Toggle(isOn: showTickTockDisplay) {
                Text(strings.showTickTockDisplay)
            }
            .padding(.vertical, UIMeasurement(2).value)
            .padding(.trailing, UIMeasurement().value)

        }
        .padding(.horizontal, UIMeasurement(2).value)
    }
}

struct WatchSettingsPanel_Previews: PreviewProvider {
    static var previews: some View {
        WatchSettingsPanel(
            timeEmitter: Qrono.shared.timeEmitter,
            settings: Qrono.shared.settings
        )
    }
}
