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
            Text(L10n.mainTitle)
                .font(.system(.title))
                .foregroundColor(.black)

            ScrollView(.vertical) {
                content()
            }.onAppear {
                model.refreshItems()
            }
            .sheet(isPresented: $model.showError) {
                Text(L10n.errorMessage(message: model.error?.localizedDescription ?? L10n.errorDefaultMessage))
            }
        }.frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private func content() -> some View {
        if let items = model.items {
            LazyVStack(alignment : .leading) {
                ForEach(items.filter({ $0.fields.pmr == "Non" })) { item in
                    Button  {

                    } label: {
                        PublicToiletCell(viewModel: PublicToiletCellViewModel(model: item, coordinate: model.coordinate))
                            .padding()
                    }
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
