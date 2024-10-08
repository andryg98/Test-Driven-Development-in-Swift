import Combine

extension MenuItemDetail {

    class ViewModel: ObservableObject {
        
        private var cancellables = Set<AnyCancellable>()

        let name: String
        let spicy: String?
        let price: String
        
        let item: MenuItem
        @Published private(set) var addOrRemoveFromOrderButtonText = "Remove from order"
        
        private let orderController: OrderController

        init(item: MenuItem, orderController: OrderController) {
            self.item = item
            self.orderController = orderController
            
            name = item.name
            spicy = item.spicy ? "Spicy" : .none
            price = "$\(String(format: "%.2f", item.price))"
            
            self.orderController.$order
                .sink { [weak self] order in
                    guard let self = self else { return }
                    
                    if (order.items.contains { $0 == self.item }) {
                        self.addOrRemoveFromOrderButtonText = "Remove from order"
                        
                    } else {
                        self.addOrRemoveFromOrderButtonText = "Add to order"
                    }
                }
                .store(in: &cancellables)
        }
        
        func addOrRemoveFromOrder() {
            if (orderController.order.items.contains { $0 == self.item }) {
                orderController.removeFromOrder(item: item)
                
            } else {
                orderController.addToOrder(item: item)
            }
        }
    }
}
