//
//  PublicToiletCellViewModel.swift
//  RATP_test
//
//  Created by Jeremie Serval on 02/08/2022.
//

import RATPL10n
import Foundation

class PublicToiletCellViewModel {

    let model: PublicToiletModel

    init(model: PublicToiletModel) {
        self.model = model
    }

    var fullAddress: String {
        if let arrondissement = model.fields.arrondissement {
            return "\(model.fields.adresse), \(arrondissement)"
        }
        return "\(model.fields.adresse)"
    }

    var openingHour: String {
        model.fields.horaire
    }

    var prmAccess: String {
        L10n.prmAccess
    }

    var isPrmAccess: Bool { model.fields.pmr == "Oui" }
}

extension PublicToiletCellViewModel {
    static var mock: PublicToiletCellViewModel {
        PublicToiletCellViewModel(model: .mock)
    }
}
