//
//  PublicToiletGeometry.swift
//  RATP_test
//
//  Created by Jeremie Serval on 02/08/2022.
//

import Foundation

public class PublicToiletGeometry: Codable {
    public init(type: String, coordinates: [Double]) {
        self.type = type
        self.coordinates = coordinates
    }

    public var type: String
    public var coordinates: [Double]

    public enum CodingKeys: String, CodingKey {
        case type
        case coordinates
    }
}

public class PublicToiletShape: Codable {
    public init(type: String, coordinates: [[Double]]) {
        self.type = type
        self.coordinates = coordinates
    }

    public var type: String
    public var coordinates: [[Double]]

    public enum CodingKeys: String, CodingKey {
        case type
        case coordinates
    }
}
