import Combine

extension MenuList {

    class ViewModel: ObservableObject {

        @Published private(set) var sections: [MenuSection]
        
        var cancellables = Set<AnyCancellable>()

        init(
            menuFetching: MenuFetching,
            menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = groupMenuByCategory
        ) {
            self.sections = []
            
            menuFetching
                .fetchMenu()
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { [weak self] value in
                        self?.sections = menuGrouping(value)
                    }
                )
            .store(in: &cancellables)
        }
    }
}
