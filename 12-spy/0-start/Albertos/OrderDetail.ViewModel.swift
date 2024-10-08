import Combine
import HippoPayments

extension OrderDetail {

    struct ViewModel {

        let headerText = "Your Order"
        let menuListItems: [MenuItem]
        let emptyMenuFallbackText = "Add dishes to the order to see them here"
        let totalText: String?
        let checkoutButtonText = "Checkout"
        
        private let paymentProcessor: PaymentProcessing
        private let orderController: OrderController

        init(
            orderController: OrderController,
            paymentProcessor: PaymentProcessing = HippoPaymentsProcessor(apiKey: "A1B2C3")
        ) {
            self.orderController = orderController
            self.paymentProcessor = paymentProcessor
            
            totalText = orderController.order.items.isEmpty
                ? .none
                : "Total: $\(String(format: "%.2f", orderController.order.total))"

            menuListItems = orderController.order.items
        }
        
        func checkout() {
            paymentProcessor.process(order: orderController.order)
        }
    }
}
