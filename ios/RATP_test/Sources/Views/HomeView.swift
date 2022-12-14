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
    @State var shouldPresentDetail: Bool = false
    @State var selectedItem: PublicToiletModel? = nil

    var body: some View {
        VStack(alignment: .center) {
            title

            filter

            Divider()

            scrollView

            NavigationLink(destination: destination(), isActive: $shouldPresentDetail, label: {})
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }

    var scrollView: some View {
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

    @ViewBuilder
    func destination() -> some View {
        if let selectedItem = selectedItem {
            PublicToiletDetailView(model: selectedItem)
        } else {
            EmptyView()
        }
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
                    PublicToiletCell(viewModel: PublicToiletCellViewModel(model: item,
                                                                          coordinate: model.coordinate,
                                                                          completion: {
                        selectedItem = item
                        shouldPresentDetail.toggle()
                    }))
                    .padding()

                    Divider()
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
