//
//  PublicToiletCellViewModel.swift
//  RATP_test
//
//  Created by Jeremie Serval on 02/08/2022.
//

import Combine
import CoreLocation
import Foundation
import UIKit

class PublicToiletCellViewModel: ObservableObject {

    let openingHour: String
    let isPrmAccess: Bool
    let fullAddress: String
    var longitude: Double? = nil
    var latitude: Double? = nil
    var prmAccess: String { L10n.prmAccess }
    var completion: (() -> Void)

    @Published var coordinate: CLLocationCoordinate2D? = nil

    init(model: PublicToiletModel, coordinate: CLLocationCoordinate2D? = nil, completion: @escaping (() -> Void)) {
        self.coordinate = coordinate
        self.completion = completion

        self.openingHour = model.fields.horaire
        self.isPrmAccess = model.isPrm

        if model.geometry.coordinates.count == 2 {
            self.longitude = model.geometry.coordinates[0]
            self.latitude = model.geometry.coordinates[1]
        }

        if let arrondissement = model.fields.arrondissement {
            self.fullAddress = "\(model.fields.adresse), \(arrondissement)"
        } else {
            self.fullAddress = "\(model.fields.adresse)"
        }

    }

    var distance: String {
        guard let coordinate = coordinate, let latitude = latitude, let longitude = longitude else {
            return ""
        }

        let destination: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude,
                                                                         longitude: longitude)
        return L10n.distance(RATPLocationManager.distanceInKilometer(current: coordinate, destination: destination))
    }

    func openMap() {
        guard let latitude = latitude, let longitude = longitude else {
            return
        }

        let url = URL(string: "maps://?saddr=&daddr=\(latitude),\(longitude)")
        if UIApplication.shared.canOpenURL(url!) {
              UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
}

extension PublicToiletCellViewModel {
    static var mock: PublicToiletCellViewModel {
        PublicToiletCellViewModel(model: .mock, completion: {})
    }
}
