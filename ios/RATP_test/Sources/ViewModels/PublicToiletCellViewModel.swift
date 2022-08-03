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
    let model: PublicToiletModel

    @Published var coordinate: CLLocationCoordinate2D? = nil

    init(model: PublicToiletModel, coordinate: CLLocationCoordinate2D? = nil) {
        self.model = model
        self.coordinate = coordinate
    }

    var fullAddress: String {
        if let arrondissement = model.fields.arrondissement {
            return "\(model.fields.adresse), \(arrondissement)"
        }
        return "\(model.fields.adresse)"
    }

    var openingHour: String { model.fields.horaire }
    var prmAccess: String { L10n.prmAccess }
    var isPrmAccess: Bool { model.fields.pmr == "Oui" }
    var distance: String {

        guard let coordinate = coordinate else {
            return ""
        }

        let destination: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: model.geometry.coordinates[1],
                                                                         longitude: model.geometry.coordinates[0])

        return L10n.distance(RATPLocationManager.distanceInKilometer(current: coordinate, destination: destination))
    }

    func openMap() {
        let url = URL(string: "maps://?saddr=&daddr=\(model.geometry.coordinates[1]),\(model.geometry.coordinates[0])")
        if UIApplication.shared.canOpenURL(url!) {
              UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
}

extension PublicToiletCellViewModel {
    static var mock: PublicToiletCellViewModel {
        PublicToiletCellViewModel(model: .mock)
    }
}
