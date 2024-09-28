import Combine
import Foundation

class MenuFetchingPlaceholder: MenuFetching {
    var counter = 0
    
    func fetchMenu() -> AnyPublisher<[MenuItem], Error> {
        defer { counter += 1 }
        
        if counter == 0 {
            return Future { $0(.failure(NSError(domain: "domain", code: 123))) }
                // Use a delay to simulate async fetch
                .delay(for: 0.5, scheduler: RunLoop.main)
                .eraseToAnyPublisher()
        } else {
            return Future { $0(.success(menu) )}
                // Use a delay to simulate async fetch
                .delay(for: 0.5, scheduler: RunLoop.main)
                .eraseToAnyPublisher()
        }
    }
}
