//
//  PublicToiletCellViewModelTest.swift
//  RATP_testTests
//
//  Created by Jeremie Serval on 04/08/2022.
//

@testable import RATP_test
import CoreLocation
import XCTest

class PublicToiletCellViewModelTest: XCTestCase {

    func testDistance() throws {

        let model = PublicToiletCellViewModel(model: .mock, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0)) {}
        let current = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let destination = model.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
        
        XCTAssertEqual(model.distance, L10n.distance(RATPLocationManager.distanceInKilometer(current: current, destination: destination)))
    }
}
