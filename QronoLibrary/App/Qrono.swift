//
//  Qrono.swift
//  Qrono
//
//  Created by Justin Reusch on 1/5/22.
//

import Foundation

/// Represents the app
class Qrono: ObservableObject {
    
    /// Loads themes to app
    @Published var themes: [String:QronoTheme]
    
    /// Clock settings with defaults
    @Published var settings: QronoSettings
    
    /// Emits current time and date on a regular interval
    @Published var timeEmitter: ClockTimeEmitter
    
    init(
        themes: [String:QronoTheme] = QronoTheme.loadThemes(),
        settings: QronoSettings = QronoSettings.getFromDefaults(),
        timeEmitter: ClockTimeEmitter = .standard
    ) {
        self.themes = themes
        self.settings = settings
        self.timeEmitter = timeEmitter
        //
        self.timeEmitter.clockType = settings.clockType
        self.timeEmitter.precision = settings.actualPrecision
    }
    
    static var shared: Qrono = .init()
}
