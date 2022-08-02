//
//  PublicToiletResponse.swift
//  RATP_test
//
//  Created by Jeremie Serval on 02/08/2022.
//

import Foundation

public struct PublicToiletResponseParameters: Codable {
    public var dataset: String
    public var rows: Int
    public var start: Int
    public var format: String
    public var timezone: String
}

public struct PublicToiletResponse: Codable {
    public var nhits: Int
    public var parameters: PublicToiletResponseParameters
    public var records: [PublicToiletModel]
}
