//
//  EventViewModel.swift
//  Astronomy Calendar
//
//  Created by Jon Sinwell on 10/3/23.
//

import Foundation

class EventViewModel: ObservableObject {
    @Published var events: [AstronomyEvent] = []
    
    init() {
        loadEvents()
    }
    
    func loadEvents() {
        if let url = Bundle.main.url(forResource: "events", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                self.events = try decoder.decode([AstronomyEvent].self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
}
