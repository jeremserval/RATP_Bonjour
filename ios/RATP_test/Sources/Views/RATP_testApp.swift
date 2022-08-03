//
//  RATP_testApp.swift
//  RATP_test
//
//  Created by Jeremie Serval on 01/08/2022.
//

import SwiftUI

@main
struct RATP_testApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView(model: HomeViewModel())
                    .background(Color.white)
                    .navigationBarHidden(true)
            }
            .background(Color.white)
        }
    }
}
