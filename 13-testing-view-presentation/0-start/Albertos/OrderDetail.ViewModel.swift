import Combine
import SwiftUI
import HippoPayments

extension OrderDetail {

    class ViewModel: ObservableObject {
        
        private var cancellables = Set<AnyCancellable>()

        let headerText = "Your Order"
        let menuListItems: [MenuItem]
        let emptyMenuFallbackText = "Add dishes to the order to see them here"
        let totalText: String?

        let shouldShowCheckoutButton: Bool
        let checkoutButtonText = "Checkout"
        
        @Published var alertToShow: Alert.ViewModel?

        private let orderController: OrderController
        private let paymentProcessor: PaymentProcessing
        
        let onAlertDismiss: () -> Void

        init(
            orderController: OrderController,
            onAlertDismiss: @escaping () -> Void,
            paymentProcessor: PaymentProcessing
        ) {
            self.orderController = orderController
            self.onAlertDismiss = onAlertDismiss
            self.paymentProcessor = paymentProcessor

            if orderController.order.items.isEmpty {
                totalText = .none
                shouldShowCheckoutButton = false
            } else {
                totalText = "Total: $\(String(format: "%.2f", orderController.order.total))"
                shouldShowCheckoutButton = true
            }

            menuListItems = orderController.order.items
        }

        func checkout() {
            paymentProcessor.process(order: orderController.order)
                .sink(receiveCompletion: { [weak self] completion in
                    guard case .failure = completion else { return }
                    guard let self = self else { return }
                    
                    self.alertToShow = Alert.ViewModel(
                        title: "",
                        message: "There's been an error with your order. Please contact a waiter.",
                        buttonText: "Ok",
                        buttonAction: self.onAlertDismiss
                    )

                }, receiveValue: { [weak self] _ in
                    guard let self = self else { return }

                    self.alertToShow = Alert.ViewModel(
                        title: "",
                        message: "The payment was successful. Your food will be with you shortly.",
                        buttonText: "Ok",
                        buttonAction: self.onAlertDismiss
                    )
                })
                .store(in: &cancellables)
        }
    }
}
