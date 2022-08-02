//
//  ContentModel.swift
//  RATP_test
//
//  Created by Jeremie Serval on 02/08/2022.
//

import Combine
import Foundation
import RATPNetwork

class HomeViewModel: ObservableObject {
    @Published var items: [PublicToiletModel]?
    @Published var showError: Bool = false

    var error: RATPNetworkError? = nil
    var cancellables: Set<AnyCancellable> = []

    func refreshItems() {
        RATPNetwork<PublicToiletResponse>()
            .request(url: URL(string: "https://data.ratp.fr/api/records/1.0/search/?dataset=sanisettesparis2011")!)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.showError.toggle()
                    self.error = error
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.error = nil
                self.items = response.records
            }
            .store(in: &cancellables)

    }
}
