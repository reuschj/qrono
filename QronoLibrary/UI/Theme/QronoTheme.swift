//
//  QronoTheme.swift
//  Qrono
//
//  Created by Justin Reusch on 5/12/20.
//  Copyright © 2020 Justin Reusch. All rights reserved.
//

import SwiftUI
import Percent

/// Class to hold theme for the clock app
class QronoTheme: Hashable, Comparable {

    /// A unique key to identify the theme
    var key: String
    
    /// A user-facing label for the string (ideally, localized)
    var label: String
    
    /// Optionally, add a sorting integer to sort the themes for the UI list.  By default, all sorting is alphabetical. This allows an integer to be added that overrides the alphabetical sorting
    var sortClass: Int8? = nil
    
    /// Holds all settings for theme
    var settings: Settings
    
    // Initializers ---------------------------- /
    
    init(
        key: String,
        label: String,
        sortClass: Int8? = nil,
        _ settings: Settings
    ) {
        self.key = key
        self.label = label
        self.sortClass = sortClass
        self.settings = settings
        Self.themes[key] = self
        print("Created a new theme with label \"\(label)\" and key \"\(key)\"")
    }
    
    /// All settings to build a clock theme
    struct Settings {
        var appBackground: Color? = nil
        var settingsLinkColor: Color = .accentColor
        var analog: AnalogClockView.Theme = AnalogClockView.Theme()
        var digital: DigitalClockView.Theme = DigitalClockView.Theme()
        var date: DateDisplayView.Theme = DateDisplayView.Theme()
    }
    
    // Methods ---------------------------- /
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
    
    static func == (lhs: QronoTheme, rhs: QronoTheme) -> Bool {
        (lhs.key == rhs.key) && (lhs.label == rhs.label)
    }
    
    static func < (lhs: QronoTheme, rhs: QronoTheme) -> Bool {
        let left = lhs.sortClass ?? Int8.max
        let right = rhs.sortClass ?? Int8.max
        guard left == right else { return left < right }
        return lhs.key < rhs.key
    }
    
    // Static ---------------------------- /
    
    /// Holds a lookup dictionary of all themes created
    static private(set) var themes: [String:QronoTheme] = [:]
    
    /// Loads all themes to the dictionary above ☝️
    static func loadThemes() -> [String:QronoTheme] {
        let themeList: [QronoTheme] = [.standardTheme, .altTheme]
        _ = themeList.map { themes[$0.key] = $0 }
        return Self.themes
    }
    
    // Themes ---------------------------- /
    
    /// The default theme
    static let standardTheme = QronoTheme(
        key: "standard_theme",
        label: strings.standard,
        sortClass: 0,
        Settings(
            appBackground: nil,
            settingsLinkColor: .accentColor,
            analog: AnalogClockView.Theme(
                shape: .circle,
                colors: AnalogClockView.Theme.Colors(
                    clock: ClockElementColor(outline: .secondary),
                    clockNumbers: .primary,
                    clockMajorTicks: .secondary,
                    clockMinorTicks: .gray,
                    hourHand: ClockElementColor(fill: .accentColor),
                    minuteHand: ClockElementColor(fill: .primary),
                    secondHand: ClockElementColor(fill: .secondary),
                    periodHand: ClockElementColor(fill: .gray),
                    periodText: .primary,
                    tickTockHand: ClockElementColor(fill: .gray),
                    pivot: ClockElementColor(fill: .accentColor)
                ),
                outlineWidth: 2,
                numbers: FlexClockFont(scale: UIPercent(oneOver: 18, of: .container(.diameter, of: "clock"))),
                hourHand: ClockHand.Hour.defaultDimensions,
                minuteHand: ClockHand.Minute.defaultDimensions,
                secondHand: ClockHand.Second.defaultDimensions,
                periodHand: ClockHand.Period.defaultDimensions,
                periodText: FlexClockFont(scale: UIPercent(oneOver: 30, of: .container(.diameter, of: "clock"))),
                pivotScale: UIPercent(oneOver: 25, of: .container(.diameter, of: "clock")),
                pivotShape: .circle,
                pivotOutlineWidth: 1
            ),
            digital: DigitalClockView.Theme(
                colors: DigitalClockView.Theme.Colors(
                    timeDigits: .primary,
                    timeSeparators: .secondary
                ),
                timeDigits: FlexClockFont(scale: UIPercent(oneOver: 6, of: .container(.diameter, of: "clock"))),
                timeSeparators: FlexClockFont(scale: UIPercent(oneOver: 8, of: .container(.diameter, of: "clock"))),
                separatorWidth: UIMeasurement(3),
                periodDigits: FlexClockFont(scale: UIPercent(oneOver: 16, of: .container(.diameter, of: "clock"))),
                separatorCharacter: ":"
            ),
            date: DateDisplayView.Theme(
                colors: DateDisplayView.Theme.Colors(
                    dateText: .secondary
                ),
                dateText: FixedClockFont(.body)
            )
        )
    )
    
    /// A bold, yellow theme
    static let altTheme = QronoTheme(
        key: "impact_theme",
        label: strings.impact,
        Settings(
            appBackground: .impactBackground,
            settingsLinkColor: .impact,
            analog: AnalogClockView.Theme(
                shape: .circle,
                colors: AnalogClockView.Theme.Colors(
                    clock: ClockElementColor(fill: .impact10, outline: .impact75),
                    clockNumbers: .impact,
                    clockMajorTicks: .impact,
                    clockMinorTicks: .impact50,
                    hourHand: ClockElementColor(fill: .impact10, outline: .impact),
                    minuteHand: ClockElementColor(fill: .impact10, outline: .impact75),
                    secondHand: ClockElementColor(fill: .impact10, outline: .impact75),
                    periodHand: ClockElementColor(fill: .impact50),
                    periodText: .impact75,
                    tickTockHand: ClockElementColor(fill: .impact90),
                    pivot: ClockElementColor(fill: .impact)
                ),
                outlineWidth: 2,
                numbers: FlexClockFont(
                    name: CustomFonts.MajorMonoDisplay.regular,
                    scale: UIPercent(oneOver: 13, of: .container(.diameter, of: "clock"))
                ),
                hourHand: ClockHand.Hour.getDefaultDimensions(outlineWidth: 2),
                minuteHand: ClockHand.Minute.defaultDimensions,
                secondHand: ClockHand.Second.defaultDimensions,
                periodHand: ClockHand.Period.defaultDimensions,
                periodText: FlexClockFont(
                    name: CustomFonts.Montserrat.regular,
                    scale: UIPercent(oneOver: 30, of: .screen(.width))
                ),
                pivotScale: UIPercent(oneOver: 25, of: .container(.diameter, of: "clock")),
                pivotShape: .circle,
                pivotOutlineWidth: 1
            ),
            digital: DigitalClockView.Theme(
                colors: DigitalClockView.Theme.Colors(
                    timeDigits: .impact,
                    timeSeparators: .impact25
                ),
                timeDigits: FlexClockFont(
                    name: CustomFonts.MajorMonoDisplay.regular,
                    scale: UIPercent(
                        oneOver: 7, of: .screen(.width)
                    )
                ),
                timeSeparators: FlexClockFont(
                    name: CustomFonts.MajorMonoDisplay.regular,
                    scale: UIPercent(
                        oneOver: 11, of: .screen(.width)
                    )
                ),
                separatorWidth: nil,
                periodDigits: FlexClockFont(
                    name: CustomFonts.Montserrat.light,
                    scale: UIPercent(oneOver: 18, of: .screen(.width))
                ),
                separatorCharacter: ":"
            ),
            date: DateDisplayView.Theme(
                colors: DateDisplayView.Theme.Colors(
                    dateText: .impact50
                ),
                dateText: FlexClockFont(
                    name: CustomFonts.Montserrat.regular,
                    scale: UIPercent(oneOver: 10, of: .screen(.width))
                ),
                smallFormatDateText: FlexClockFont(
                    name: CustomFonts.Montserrat.regular,
                    scale: UIPercent(oneOver: 9, of: .screen(.width))
                )
            )
        )
    )
}

struct Theme_Previews: PreviewProvider {
    static var previews: some View {
        Qrono.shared.settings.theme = .altTheme
        Qrono.shared.settings.clockType = .twelveHour
        return Group {
            DigitalClockView(
                timeEmitter: Qrono.shared.timeEmitter,
                settings: Qrono.shared.settings
            )
            DigitalClockView(
                timeEmitter: Qrono.shared.timeEmitter,
                settings: Qrono.shared.settings
            )
            .padding(8)
            .frame(
                width: 396 / 2,
                height: 484 / 2,
                alignment: .center
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.red, lineWidth: 1)
            )
        }
        .preferredColorScheme(.dark)
        .padding()
    }
}
