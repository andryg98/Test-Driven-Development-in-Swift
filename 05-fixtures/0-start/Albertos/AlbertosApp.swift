import SwiftUI

@main
struct AlbertosApp: App {

    var body: some Scene {
        WindowGroup {
            NavigationView {
                MenuList(sections: groupMenuByCategory(menu))
                    .navigationTitle("Alberto's 🇮🇹")
            }
        }
    }
}

// In this first iteration the menu is an hard-coded array
let menu = [
    MenuItem(category: "starters", name: "Caprese Salad", spicy: false, price: 10.00),
    MenuItem(category: "starters", name: "Arancini Balls", spicy: false, price: 11.00),
    MenuItem(category: "pastas", name: "Penne all'Arrabbiata", spicy: true, price: 12.00),
    MenuItem(category: "pastas", name: "Spaghetti Carbonara", spicy: false, price: 13.00),
    MenuItem(category: "drinks", name: "Water", spicy: false, price: 14.00),
    MenuItem(category: "drinks", name: "Red Wine", spicy: false, price: 10.00),
    MenuItem(category: "desserts", name: "Tiramisù", spicy: false, price: 10.00),
    MenuItem(category: "desserts", name: "Crema Catalana", spicy: false, price: 10.00),
]
