//
//  PublicToiletField.swift
//  RATP_test
//
//  Created by Jeremie Serval on 02/08/2022.
//

import Foundation

public class PublicToiletFields: Codable {
    public var complementAdresse: String
    public var shape: PublicToiletShape
    public var horaire: String
    public var pmr: String
    public var arrondissement: Int?
    public var geo2d: [Double]
    public var source: String
    public var gestionnaire: String
    public var adresse: String
    public var type: PublicToiletType

    public init(complementAdresse: String,
                shape: PublicToiletShape,
                horaire: String,
                pmr: String,
                arrondissement: Int? = nil,
                geo2d: [Double],
                source: String,
                gestionnaire: String,
                adresse: String,
                type: PublicToiletType) {
        self.complementAdresse = complementAdresse
        self.shape = shape
        self.horaire = horaire
        self.pmr = pmr
        self.arrondissement = arrondissement
        self.geo2d = geo2d
        self.source = source
        self.gestionnaire = gestionnaire
        self.adresse = adresse
        self.type = type
    }

    public enum CodingKeys: String, CodingKey {
        case complementAdresse = "complement_adresse"
        case shape = "geo_shape"
        case horaire
        case pmr = "acces_pmr"
        case arrondissement
        case geo2d = "geo_point_2d"
        case source
        case gestionnaire
        case adresse
        case type
    }
}

extension PublicToiletFields {
    static var mockWithPMR: PublicToiletFields {
        .init(complementAdresse: "numero_de_voie nom_de_voie",
              shape: PublicToiletShape(type: "MultiPoint", coordinates: [[2.34445799806018, 48.899388215542245]]),
              horaire: "6 h - 22 h", pmr: "Oui", arrondissement: 75012, geo2d: [48.899388215542245, 2.34445799806018],
              source: "http://opendata.paris.fr", gestionnaire: "Toilette publique de la Ville de Paris",
              adresse: "1  AVENUE RENE COTY", type: .sanisette)
    }

    static var mock: PublicToiletFields {
        .init(complementAdresse: "numero_de_voie nom_de_voie",
              shape: PublicToiletShape(type: "MultiPoint", coordinates: [[2.34445799806018, 48.899388215542245]]),
              horaire: "6 h - 22 h", pmr: "Non", arrondissement: 75012, geo2d: [48.899388215542245, 2.34445799806018],
              source: "http://opendata.paris.fr", gestionnaire: "Toilette publique de la Ville de Paris",
              adresse: "1  AVENUE RENE COTY", type: .sanisette)
    }

}
