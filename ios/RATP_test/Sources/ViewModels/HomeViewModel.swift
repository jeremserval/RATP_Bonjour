//
//  ContentModel.swift
//  RATP_test
//
//  Created by Jeremie Serval on 02/08/2022.
//

import Combine
import Foundation
import CoreLocation

class HomeViewModel: ObservableObject {
    @Published var items: [PublicToiletModel]?
    @Published var showError: Bool = false
    @Published var coordinate: CLLocationCoordinate2D? = nil
    @Published var accessibilityFilter: Bool = false
    
    private var locationManager: RATPLocationManager = .init()
    private let urlToilet: URL = URL(string: "https://data.ratp.fr/api/records/1.0/search/?dataset=sanisettesparis2011")!
    
    var error: RATPNetworkError? = nil
    var cancellables: Set<AnyCancellable> = []

    init() {
        setupLocation()
    }

    func itemsFiltered() -> [PublicToiletModel]? {
        guard let items = items else {
            return nil
        }

        if accessibilityFilter {
            return items.filter { $0.isPrm }
        }
        
        return items
    }

    private func setupLocation() {
        locationManager.requestLocation()
        locationManager.$coordinate
            .sink { [weak self] coordinate in
                if let coordinate = coordinate {
                    self?.coordinate = coordinate
                }
            }
            .store(in: &cancellables)
    }

    func refreshItems() {
        RATPNetwork<PublicToiletResponse>()
            .request(url: urlToilet)
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
