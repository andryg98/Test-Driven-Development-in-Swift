@testable import Albertos
import XCTest

class MenuItemDetailViewModelTests: XCTestCase {

    func testNameIsItemName() {
        let orderController = OrderController()
        XCTAssertEqual(
            MenuItemDetail.ViewModel(item: .fixture(name: "a name"), orderController: orderController).name,
            "a name"
        )
    }

    func testWhenItemIsSpicyShowsSpicyMessage() {
        let orderController = OrderController()

        XCTAssertEqual(
            MenuItemDetail.ViewModel(item: .fixture(spicy: true), orderController: orderController).spicy,
            "Spicy"
        )
    }

    func testWhenItemIsNotSpicyDoesNotShowSpicyMessage() {
        let orderController = OrderController()

        XCTAssertNil(MenuItemDetail.ViewModel(item: .fixture(spicy: false), orderController: orderController).spicy)
    }

    func testPriceIsFormattedItemPrice() {
        let orderController = OrderController()

        XCTAssertEqual(
            MenuItemDetail.ViewModel(item: .fixture(price: 1.0), orderController: orderController).price,
            "$1.00"
        )
        XCTAssertEqual(
            MenuItemDetail.ViewModel(item: .fixture(price: 2.5), orderController: orderController).price,
            "$2.50"
        )
        XCTAssertEqual(
            MenuItemDetail.ViewModel(item: .fixture(price: 3.45), orderController: orderController).price,
            "$3.45"
        )
        XCTAssertEqual(
            MenuItemDetail.ViewModel(item: .fixture(price: 4.123), orderController: orderController).price,
            "$4.12"
        )
    }
    
    func testWhenItemIsInOrderButtonSaysRemove() {
        let item = MenuItem.fixture()
        let orderController = OrderController()
        orderController.addToOrder(item: item)
        let viewModel = MenuItemDetail.ViewModel(item: item, orderController: orderController)
        
        let text = viewModel.addOrRemoveFromOrderButtonText
        
        XCTAssertEqual(text, "Remove from order")
    }
    
    func testWhenItemIsNotInOrderButtonSaysAdd() {
        let item = MenuItem.fixture()
        let orderController = OrderController()
        
        let viewModel = MenuItemDetail.ViewModel(item: item, orderController: orderController)
        
        let text = viewModel.addOrRemoveFromOrderButtonText
        XCTAssertEqual(text, "Add to order")
    }
    
    func testWhenItemIsInOrderButtonActionRemovesIt() {
        let item = MenuItem.fixture()
        let orderController = OrderController()
        orderController.addToOrder(item: item)
        let viewModel = MenuItemDetail.ViewModel(item: item, orderController: orderController)
        
        viewModel.addOrRemoveFromOrder()
        
        XCTAssertFalse(orderController.order.items.contains { $0 == item })
    }
    
    func testWhenItemIsNotInOrderButtonActionAddsIt() {
        let item = MenuItem.fixture()
        let orderController = OrderController()
        let viewModel = MenuItemDetail.ViewModel(item: item, orderController: orderController)
        
        viewModel.addOrRemoveFromOrder()
        
        XCTAssertTrue(orderController.order.items.contains { $0 == item })
    }
}
