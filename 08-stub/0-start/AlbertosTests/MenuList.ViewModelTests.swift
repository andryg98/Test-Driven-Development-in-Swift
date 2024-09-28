@testable import Albertos
import Combine
import XCTest

class MenuListViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    func testWhenFetchingStartsPublishesEmptyMenu() throws{
        let viewModel = MenuList.ViewModel(
            menuFetching: MenuFetchingStub(returning: .success([.fixture()]))
        )
        
        let sections = try viewModel.sections.get()

        XCTAssertTrue(sections.isEmpty)
    }

    func testWhenFecthingSucceedsPublishesSectionsBuiltFromReceivedMenuAndGivenGroupingClosure() {
        var receivedMenu: [MenuItem]?
        let expectedSections = [MenuSection.fixture()]

        let spyClosure: ([MenuItem]) -> [MenuSection] = { items in receivedMenu = items
            return expectedSections
        }
        
        let expectedMenu = [MenuItem.fixture()]
        let menuFetchingStub = MenuFetchingStub(returning: .success(expectedMenu))
        
        let viewModel = MenuList.ViewModel(
            menuFetching: menuFetchingStub,
            menuGrouping: spyClosure
        )
        let expectation = XCTestExpectation(
            description: "Publishes sections built from received menu and given grouping closure"
        )
        viewModel
            .$sections
            .dropFirst()
            .sink { value in
                guard case .success(let sections) = value else {
                    return XCTFail("Expected a successfull Result, got \(value)")
                }
                
                // Ensure the grouping closure is called with the received menu
                XCTAssertEqual(receivedMenu, expectedMenu)
                // Ensure the published value is the result of the grouping closure
                XCTAssertEqual(sections, expectedSections)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testWhenFetchingFailsPublishesAnError() {
        let expectedError = TestError(id: 123)
        let menuFetchingStub = MenuFetchingStub(returning: .failure(expectedError))
        
        let viewModel = MenuList.ViewModel(menuFetching: menuFetchingStub, menuGrouping: { _ in [] })
        let expectation = XCTestExpectation(description: "Publishes an error")
        
        viewModel
            .$sections
            .dropFirst()
            .sink { value in
                guard case .failure(let error) = value else {
                    return XCTFail("Expected a failure Result, got \(value)")
                }
                
                XCTAssertEqual(error as? TestError, expectedError)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testWhenFetchingFailsPublishesAnErrorAndRetryPublishesSectionsBuiltFromReceivedMenuAndGivenGroupingClosure() {
        let expectedError = TestError(id: 123)
        let expectedItem = [MenuItem.fixture()]
        let expectedSections = [MenuSection.fixture()]
        
        let multipleMenuFetchingStub = MultipleMenuFetchingStub(returning: [.failure(expectedError), .success(expectedItem)])
        
        let viewModel = MenuList.ViewModel(menuFetching: multipleMenuFetchingStub, menuGrouping: { _ in [MenuSection.fixture()] })
            viewModel.updateSections()
        
        let errorExpectation = XCTestExpectation(description: "Publishes an error")
        let successExpectationAfterRetry = XCTestExpectation(description: "Publishes a success after retry")
        
        viewModel
            .$sections
            .dropFirst()
            .first()
            .sink { value in
                guard case .failure(let error) = value else {
                    return XCTFail("Expected a failure Result, got \(value)")
                }
                
                XCTAssertEqual(error as? TestError, expectedError)
                errorExpectation.fulfill()
            }
            .store(in: &cancellables)
        
        
        viewModel
            .$sections
            .dropFirst(2)
            .sink { value in
                print("Got value \(value)")
                guard case .success(let sections) = value else {
                    return XCTFail("Expected a successfull Result, got \(value)")
                }
                
                // Ensure the published value is the result of the grouping closure
                XCTAssertEqual(sections, expectedSections)
                
                successExpectationAfterRetry.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [errorExpectation, successExpectationAfterRetry], timeout: 1)
    }
}
