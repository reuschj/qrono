//
//  DigitalClockComponents.swift
//  Qrono
//
//  Created by Justin Reusch on 10/16/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import SwiftUI

/**
 Renders a visual separator between digital clock components (hours, minutes, seconds)
 */
struct DigitalClockSeparator: View {
    
    /// The width of the separation including visual character and padding
    var width: UIMeasurement? = nil
    
    /// The color of the visual character in the separator
    var color: Color = .secondary
    
    /// The font of the separator
    var font: Font = .title
    
    /// The character to use as a separator
    var character: Character = ":"
    
    var body: some View {
        HStack {
            Text(String(character))
                .font(font)
                .foregroundColor(color)
        }
        .frame(maxWidth: width?.value, alignment: .center)
    }
}

/**
 Renders a digital clock or date component from `String`  text
 */
struct TimeTextBlock: View {
    
    /// The text to display in the component
    var text: String?
    
    /// The color of the text
    var color: Color = .primary
    
    /// The font to use fo the text
    var font: Font = .title
    
    /// A string of characters to display _before_ the component text
    var pre: String? = nil
    
    /// A string of characters to display _after_ the component text
    var post: String? = nil
    
    /// Computed value with pre and post strings added around base text
    private var fullText: String { "\(self.pre ?? "")\(self.text ?? "")\(self.post ?? "")" }
    
    var body: some View {
        HStack {
            Text(fullText)
                .font(font)
            .foregroundColor(color)
        }
    }
}

/**
 Renders a digital clock or date component from a numerical (`Int`) value
 */
struct TimeNumberBlock: View {
    
    /// The number value to display in the component
    var number: Int?
    
    /// The color of the text
    var color: Color = .primary
    
    /// The font to use fo the text
    var font: Font = .title
    
    /// A string of characters to display _before_ the component text
    var pre: String? = nil
    
    /// A string of characters to display _after_ the component text
    var post: String? = nil
    
    var body: some View {
        TimeTextBlock(text: "\(number ?? 0)", color: color, font: font, pre: pre, post: post)
            .fixedSize()
            .allowsTightening(true)
            .overlay(Rectangle().stroke(.green, lineWidth: 1))
    }
}
