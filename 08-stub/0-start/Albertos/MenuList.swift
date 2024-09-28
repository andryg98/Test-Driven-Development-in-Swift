import SwiftUI

struct MenuList: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        switch viewModel.sections {
        case let .success(sections):
            List {
                ForEach(sections) { section in
                    Section(header: Text(section.category)) {
                        ForEach(section.items) { item in
                            MenuRow(viewModel: .init(item: item))
                        }
                    }
                }
            }
            
        case let .failure(error):
            VStack {
                Text("An error has occurred")
                Text(error.localizedDescription).italic()
                Button("Retry") {
                    viewModel.updateSections()
                }
            }
        }
    }
}
