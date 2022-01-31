//
//  DateDisplayView.swift
//  Qrono
//
//  Created by Justin Reusch on 10/20/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import SwiftUI
import Combine
import TimeKeeper

/**
 A date display view module
 */
struct DateDisplayView: View {
    
    /// Emits the current time and date at regular intervals
    @ObservedObject var timeEmitter: ClockTimeEmitter
    
    /// Global app settings
    @ObservedObject var settings: QronoSettings

    /// The emitted time from the `timeEmitter`
    var time: TimeKeeper { timeEmitter.time }

    private var theme: Theme { settings.theme.settings.date }
    private var colors: Theme.Colors { theme.colors }
    
    private let dateFontRange: ClosedRange<CGFloat> = 14...48
    
    private func getFont(within width: CGFloat) -> Font {
        let baseFont = width < 100
            ? theme.dateTextForSmallFormat
            : theme.dateText
        return baseFont.getFont(within: width, limitedTo: dateFontRange)
    }
    
    private func makeDateDisplay(within width: CGFloat) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Spacer()
            TimeTextBlock(
                text: time.dateString,
                color: colors.dateText,
                font: getFont(within: width)
            )
            Spacer()
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.makeDateDisplay(within: geometry.size.width)
        }
    }
    
    struct Theme {
        var colors: Colors = Colors()
        var dateText: ClockFont = FixedClockFont(.body)
        var smallFormatDateText: ClockFont? = nil
        
        var dateTextForSmallFormat: ClockFont {
            smallFormatDateText ?? dateText
        }
        
        struct Colors {
            var dateText: Color = .primary
        }
    }
}

struct DateDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DateDisplayView(
            timeEmitter: Qrono.shared.timeEmitter,
            settings: Qrono.shared.settings
        )
            .padding()
    }
}
