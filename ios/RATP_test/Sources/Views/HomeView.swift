//
//  ContentView.swift
//  RATP_test
//
//  Created by Jeremie Serval on 01/08/2022.
//

import Combine
import SwiftUI

struct HomeView: View {
    @ObservedObject var model: HomeViewModel

    var body: some View {

        VStack(alignment: .center) {
            title

            filter

            Divider()

            ScrollView(.vertical, showsIndicators: false) {
                content()
            }
            .padding(.bottom)
            .onAppear {
                model.refreshItems()
            }
            .sheet(isPresented: $model.showError) {
                Text(L10n.errorMessage(message: model.error?.localizedDescription ?? L10n.errorDefaultMessage))
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)

    }

    var title: some View {
        Text(L10n.mainTitle)
            .font(.system(.title))
            .foregroundColor(.black)
            .padding()
    }

    var filter: some View {
        HStack {
            Image(systemName: "person")
            Toggle(L10n.disability, isOn: $model.accessibilityFilter)
        }
        .foregroundColor(.black)
        .padding()
    }

    @ViewBuilder
    private func content() -> some View {
        if let items = model.itemsFiltered() {
            LazyVStack(alignment : .leading) {
                ForEach(items, id: \.id) { item in
                    PublicToiletCell(viewModel: PublicToiletCellViewModel(model: item, coordinate: model.coordinate))
                        .padding()
                }
            }
        } else {
            ProgressView()
                .padding()
        }
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(model: .init())
    }
}
#endif
