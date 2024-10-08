@testable import Albertos
import XCTest

class OrderTests: XCTestCase {

    func testTotalSumsPricesOfEachItem() {
        let order = Order(
            items: [.fixture(price: 1.0), .fixture(price: 2.0), .fixture(price: 3.5)]
        )

        XCTAssertEqual(order.total, 6.5)
    }
    
    func testOrderEmptyCreatesHippoPaymentPayloadEmpty() {
        let expectedHippoPaymentPayload: HippoPaymentPayload = HippoPaymentPayload(items: [])
        let order = Order(items: [])
        
        let hippoPaymentPayload = order.convertToHippoPaymentPayload()
        
        XCTAssertEqual(hippoPaymentPayload, expectedHippoPaymentPayload)
    }
    
    func testOrderWithItemsCreatesHippoPaymentPayloadWithItems() {
        let expectedHippoPaymentPayload: HippoPaymentPayload = HippoPaymentPayload(items: ["Arancini balls", "Penne all'arrabbiata"])
        let order = Order(items: [.fixture(name: "Arancini balls"), .fixture(name: "Penne all'arrabbiata")])
        
        let hippoPaymentPayload = order.convertToHippoPaymentPayload()
        
        XCTAssertEqual(hippoPaymentPayload, expectedHippoPaymentPayload)
    }
}
