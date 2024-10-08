import SwiftUI

struct MenuList: View {

    @ObservedObject var viewModel: ViewModel
    
    @EnvironmentObject var orderController: OrderController

    var body: some View {
        switch viewModel.sections {
        case .success(let sections):
            List {
                ForEach(sections) { section in
                    Section(header: Text(section.category)) {
                        ForEach(section.items) { item in
                            NavigationLink(destination: destination(for: item)) {
                                MenuRow(viewModel: .init(item: item))
                            }
                        }
                    }
                }
            }
        case .failure(let error):
            Text("An error occurred:")
            Text(error.localizedDescription).italic()
        }
    }
    
    func destination(for item: MenuItem) -> MenuItemDetail {
        return MenuItemDetail(viewModel: .init(item: item, orderController: orderController))
    }
}
