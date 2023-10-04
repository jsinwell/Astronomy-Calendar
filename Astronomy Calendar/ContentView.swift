import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = EventViewModel()
    @State private var searchText = ""
    
    init() {
        // Setting appearance for scroll edge state
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.backgroundColor = UIColor.black
        scrollEdgeAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        scrollEdgeAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Standard appearance with a blur effect
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithTransparentBackground()
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        
        standardAppearance.backgroundEffect = blurEffect
        standardAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            
        // Applying appearances
        UINavigationBar.appearance().standardAppearance = standardAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
    
        // Search bar styling
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.events.filter {
                        searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased())
                    }) { event in
                        AstronomyEventView(event: event)
                            .padding()
                    }
                }
            }
            .background(Color.black)
            .navigationTitle("Calendar")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search events")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
