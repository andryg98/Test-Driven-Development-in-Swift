//
//  MenuList.ViewModelTests.swift
//  AlbertosTests
//
//  Created by Andrea Garau on 27/09/24.
//

@testable import Albertos
import XCTest

class MenuListViewModelTests: XCTestCase {
    func testCallsGivenGroupingFunction() {
        var called = false
        let inputSections = [MenuSection.fixture()]
        let spyClosure: ([MenuItem]) -> [MenuSection] = { items in
            called = true
            return inputSections
        }
        
        let viewModel = MenuList.ViewModel(menu: [.fixture()], menuGrouping: spyClosure)
        let sections = viewModel.sections
        XCTAssertTrue(called)
        XCTAssertEqual(sections, inputSections)
    }
}
