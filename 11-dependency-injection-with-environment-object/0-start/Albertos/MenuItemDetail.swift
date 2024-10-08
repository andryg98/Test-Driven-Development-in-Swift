import SwiftUI

struct MenuItemDetail: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.name)
                .fontWeight(.bold)

            if let spicy = viewModel.spicy {
                Text(spicy)
                    .font(Font.body.italic())
            }

            Text(viewModel.price)

            Spacer()
            
            HStack(alignment: .center) {
                Button(viewModel.addOrRemoveFromOrderButtonText) {
                    viewModel.addOrRemoveFromOrder()
                }
            }
        }
        .padding(8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
