import SwiftUI

@main
struct AlbertosApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MenuList(
                    sections: groupMenuByCategory(menu)
                ).navigationTitle("Alberto's 🇮🇹")
            }
        }
    }
}

let menu = [
    MenuItem(category: "starters", name: "Caprese Salad"),
    MenuItem(category: "starters", name: "Arancini balls"),
    MenuItem(category: "pastas", name: "Penne all'Arrabbiata"),
    MenuItem(category: "pastas", name: "Spaghetti Carbonara"),
    MenuItem(category: "drinks", name: "Water"),
    MenuItem(category: "drinks", name: "Wine"),
    MenuItem(category: "desserts", name: "Tiramisù"),
    MenuItem(category: "desserts", name: "Crema Catalana"),
]
