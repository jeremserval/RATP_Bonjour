//
//  HomeViewModelTest.swift
//  RATP_testTests
//
//  Created by Jeremie Serval on 04/08/2022.
//

@testable import RATP_test
import XCTest

class HomeViewModelTest: XCTestCase {

    func testItemsFiltered() throws {
        let publicToiletA: PublicToiletModel = .mock
        let publicToiletB: PublicToiletModel = .mockWithPMR

        let model: HomeViewModel = HomeViewModel()

        model.items = [publicToiletA, publicToiletB]

        XCTAssertEqual(model.itemsFiltered(), [publicToiletA, publicToiletB])

        model.accessibilityFilter = true

        XCTAssertEqual(model.itemsFiltered(), [publicToiletB])

    }

}
