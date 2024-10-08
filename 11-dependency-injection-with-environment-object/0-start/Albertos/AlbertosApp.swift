import SwiftUI
import Combine

@main
struct AlbertosApp: App {
    
    let orderController = OrderController()

    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .bottom) {
                NavigationView {
                    MenuList(viewModel: .init(menuFetching: MenuFetcher()))
                        .navigationTitle("Alberto's 🇮🇹")
                }
                .environmentObject(orderController)
            }
        }
    }
}
