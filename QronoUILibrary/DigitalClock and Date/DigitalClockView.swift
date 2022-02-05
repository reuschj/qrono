//
//  DigitalClockView.swift
//  Qrono
//
//  Created by Justin Reusch on 10/16/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import SwiftUI
import Combine
import TimeKeeper
import Percent

struct DigitalClockView: View {
    
    /// Emits the current time and date at regular intervals
    @ObservedObject var timeEmitter: ClockTimeEmitter
    
    /// Global app settings
    @ObservedObject var settings: QronoSettings
    
    private var theme: Theme { settings.theme.settings.digital }
    private var colors: Theme.Colors { theme.colors }
    
    /// Type of clock, 12-hour, 24-hour or decimal
    var type: ClockType { settings.clockType }
    
    /// The emitted time from the `timeEmitter`
    var time: TimeKeeper { timeEmitter.time }
    
    /// Gets the time text for the hours place
    private var hourTimeText: String? {
        switch type {
        case .twelveHour:
            return time.hour12String
        case .twentyFourHour:
            return time.hour24String
        case .decimal:
            return time.hourDecimalString
        }
    }
    
    /// Gets the time text for the minutes place
    private var minuteTimeText: String? {
        switch type {
        case .twelveHour, .twentyFourHour:
            return time.paddedMinute
        case .decimal:
            return time.paddedDecimalMinute
        }
    }
    
    /// Gets the time text for the seconds place
    private var secondTimeText: String? {
        switch type {
        case .twelveHour, .twentyFourHour:
            return time.paddedSecond
        case .decimal:
            return time.paddedDecimalSecond
        }
    }
    
    private let timeDigitFontRange: ClosedRange<CGFloat> = 8...50
    
    private func getTimeDigitFont(within container: CGFloat) -> Font {
        theme.timeDigits.getFont(within: container, limitedTo: timeDigitFontRange, modifier: nil)
    }
    
    private func getSeparatorFont(within container: CGFloat) -> Font {
        theme.timeSeparators.getFont(within: container, limitedTo: timeDigitFontRange, modifier: nil)
    }
    
    private func getPeriodFont(within container: CGFloat) -> Font? {
        theme.periodDigits?.getFont(within: container, limitedTo: timeDigitFontRange, modifier: nil)
    }
    
    
    private func makeDigitalDisplay(within width: CGFloat) -> some View {
        let timeDigitFont: Font = getTimeDigitFont(within: width)
        let periodFont: Font = getPeriodFont(within: width) ?? timeDigitFont
        let separatorFont: Font = getSeparatorFont(within: width)
        let _separator_ = DigitalClockSeparator(
            width: theme.separatorWidth,
            color: colors.timeSeparators,
            font: separatorFont,
            character: type == .decimal ? theme.separatorCharacterDecimal : theme.separatorCharacter
        )
        func digit(
            _ text: String?,
            font: Font = timeDigitFont,
            color: Color = colors.timeDigits
        ) -> TimeTextBlock {
            TimeTextBlock(
                text: text,
                color: color,
                font: font
            )
        }
        return HStack(
            alignment: theme.verticalAlignment,
            spacing: .zero
        ) {
            Spacer()
            digit(hourTimeText)
            _separator_
            digit(minuteTimeText)
            _separator_
            digit(secondTimeText)
            if type == .twelveHour {
                digit(time.periodString, font: periodFont, color: colors.period)
                    .padding(.leading, 4)
            }
            Spacer()
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.makeDigitalDisplay(within: geometry.size.width)
        }
    }
    
    struct Theme {
        var colors: Colors = Colors()
        var timeDigits: ClockFont = FixedClockFont(.title)
        var timeSeparators: ClockFont = FixedClockFont(.title)
        var separatorWidth: UIMeasurement? = nil
        var periodDigits: ClockFont? = nil
        var separatorCharacter: Character = ":"
        var separatorCharacterDecimal: Character = "."
        var verticalAlignment: VerticalAlignment = .firstTextBaseline
        
        struct Colors {
            var timeDigits: Color = .primary
            var timeSeparators: Color = .gray
            var period: Color = .gray
        }
    }
}

struct DigitalClockView_Previews: PreviewProvider {
    static var previews: some View {
        Qrono.shared.settings.theme = .altTheme
        return Group {
            DigitalClockView(
                timeEmitter: Qrono.shared.timeEmitter,
                settings: Qrono.shared.settings
            )
                .preferredColorScheme(.dark)
                .padding()
        }
    }
}
