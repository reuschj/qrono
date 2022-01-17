//
//  strings.swift
//  Qrono
//
//  Created by Justin Reusch on 10/25/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import Foundation

fileprivate func from(key: String, comment: String? = nil) -> String {
    return NSLocalizedString(key, comment: comment ?? "")
}

let strings = (
    analogClock: from(key: "analogClock"),
    digitalClock: from(key: "digitalClock"),
    dateDisplay: from(key: "dateDisplay"),
    settings: from(key: "settings"),
    showModules: from(key: "showModules"),
    clockType: from(key: "clockType"),
    twelveHour: from(key: "twelveHour"),
    twentyFourHour: from(key: "twentyFourHour"),
    decimal: from(key: "decimal"),
    precision: from(key: "precision"),
    low: from(key: "low"),
    medium: from(key: "medium"),
    high: from(key: "high"),
    updatesSing: from(key: "updatesSing"),
    updatesPlu: from(key: "updatesPlu"),
    otherOptions: from(key: "otherOptions"),
    showTickMarks: from(key: "showTickMarks"),
    showPeriodDisplay: from(key: "showPeriodDisplay"),
    showTickTockDisplay: from(key: "showTickTockDisplay"),
    theme: from(key: "theme"),
    standard: from(key: "standard"),
    impact: from(key: "impact")
)
