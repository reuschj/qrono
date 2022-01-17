//
//  ContentView.swift
//  Qrono
//
//  Created by Justin Reusch on 1/5/22.
//

import SwiftUI
import AppBackgroundView

struct ContentView: View {

    /// Global app settings
    @ObservedObject var settings: QronoSettings = Qrono.shared.settings

    private var theme: QronoTheme.Settings { settings.theme.settings }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                AppBackgroundView(theme.appBackground ?? Color.clear) {
                    MainDisplay()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
