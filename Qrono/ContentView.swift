//
//  ContentView.swift
//  Qrono
//
//  Created by Justin Reusch on 1/5/22.
//

import SwiftUI
import Combine
import AppBackgroundView

struct ContentView: View {

    @EnvironmentObject var qrono: Qrono

    private var theme: QronoTheme.Settings { qrono.settings.theme.settings }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                AppBackgroundView(theme.appBackground ?? Color.clear) {
                    MainDisplay(qrono: qrono)
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
