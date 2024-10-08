import Combine

extension MenuList {

    class ViewModel: ObservableObject {

        @Published private(set) var sections: Result<[MenuSection], Error> = .success([])
        
        private let menuFetching: MenuFetching
        private let menuGrouping: ([MenuItem]) -> [MenuSection]
        
        private var cancellables = Set<AnyCancellable>()
        
        init(
            menuFetching: MenuFetching,
            menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = groupMenuByCategory
        ) {
            self.menuFetching = menuFetching
            self.menuGrouping = menuGrouping
            
            updateSections()
        }
        
        public func updateSections() {
            menuFetching
                .fetchMenu()
                .map(menuGrouping)
                .sink(
                    receiveCompletion: { [weak self] completion in
                        guard case .failure(let error) = completion else { return }
                        
                        self?.sections = .failure(error)
                    },
                    receiveValue: { [weak self] value in
                        self?.sections = .success(value)
                    }
                )
                .store(in: &cancellables)
        }
    }
}
