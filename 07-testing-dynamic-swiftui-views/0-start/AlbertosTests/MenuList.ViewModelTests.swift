@testable import Albertos
import XCTest
import Combine

class MenuListViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func testCallsGivenGroupingFunction() throws {
        try XCTSkipIf(true, "skipping this for now, keeping it to reuse part of the code later")
        var called = false
        let inputSections = [MenuSection.fixture()]
        let probeClosure: ([MenuItem]) -> [MenuSection] = { _ in
            called = true
            return inputSections
        }

        let viewModel = MenuList.ViewModel(menuFetching: MenuFetchingPlaceholder(), menuGrouping: probeClosure)
        let sections = viewModel.sections

        // Check that the given closure was called
        XCTAssertTrue(called)
        // Check that the returned value was build with the closure
        XCTAssertEqual(sections, inputSections)
    }
    
    func testWhenFetchingStartsPublishesEmptyMenu() {
        let viewModel = MenuList.ViewModel(menuFetching: MenuFetchingPlaceholder())
        
        XCTAssertTrue(viewModel.sections.isEmpty)
    }
    
    func testWhenFetchingSucceedsPublishesSectionsBuiltFromReceivedMenuAndGivenGroupingClosure() {
        var receivedMenu: [MenuItem]?
        let expectedSections = [MenuSection.fixture()]
        let spyClosure: ([MenuItem]) -> [MenuSection] = { items in
            receivedMenu = items
            
            return expectedSections
        }
        
        let viewModel = MenuList.ViewModel(menuFetching: MenuFetchingPlaceholder(), menuGrouping: spyClosure)
        
        let emptyArrayExpectation = XCTestExpectation(description: "Publishes empty array of sections")
        let expectation = XCTestExpectation(description: "Publishes sections built from received menu and given grouping closure")
        
        viewModel
            .$sections
            .first()
            .sink { value in
                XCTAssertEqual(value, [])
                
                emptyArrayExpectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel
            .$sections
            .dropFirst()
            .sink { value in
                XCTAssertEqual(receivedMenu, menu)
                XCTAssertEqual(value, expectedSections)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [emptyArrayExpectation, expectation], timeout: 1)
    }
    
    func testWhenFetchingFailsPublishesAnError() {
        
    }
}
