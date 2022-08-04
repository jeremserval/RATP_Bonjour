//
//  PublicToiletDetailView.swift
//  RATP_test
//
//  Created by Jeremie Serval on 04/08/2022.
//

import SwiftUI

struct PublicToiletDetailView: View {
    var model: PublicToiletModel

    var body: some View {
        Text("Hello, World! \(model.fields.adresse)")
            .transition(.move(edge: .leading))
    }
}

struct PublicToiletDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PublicToiletDetailView(model: .mock)
    }
}
