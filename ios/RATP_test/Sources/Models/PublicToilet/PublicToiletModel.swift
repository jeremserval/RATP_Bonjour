//
//  PublicToiletModel.swift
//  RATP_test
//
//  Created by Jeremie Serval on 02/08/2022.
//

import Foundation

public class PublicToiletModel: Identifiable, Codable {
    public var id: String
    public var datasetId: String
    public var recordTimestamp: String
    public var geometry: PublicToiletGeometry
    public var fields: PublicToiletFields

    public var isPrm: Bool {
        fields.pmr == "Oui"
    }

    public init(id: String,
                recordId: String,
                recordTimestamp: String,
                geometry: PublicToiletGeometry,
                fields: PublicToiletFields) {
        self.id = id
        self.datasetId = recordId
        self.recordTimestamp = recordTimestamp
        self.geometry = geometry
        self.fields = fields
    }


    public enum CodingKeys: String, CodingKey {
        case id = "recordid"
        case datasetId = "datasetid"
        case recordTimestamp = "record_timestamp"
        case geometry
        case fields
    }
}

extension PublicToiletModel {
    static var mock: PublicToiletModel {
        PublicToiletModel(id: "01", recordId: "01", recordTimestamp: "",
              geometry: PublicToiletGeometry(type: "TOILETTES", coordinates: [0, 0]),
              fields: PublicToiletFields.mock)
    }
}
