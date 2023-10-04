import Foundation

struct AstronomyEvent: Identifiable, Decodable, Equatable {
    var id: UUID
    var name: String
    var date: Date
    var description: String
    var imageName: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        let dateString = try container.decode(String.self, forKey: .date)
        
        // Extract first date if multiple dates are present
        let firstDateString = dateString.split(separator: ",").first.map(String.init) ?? dateString
        
        // Append the year to the date string
        let currentYear = Calendar.current.component(.year, from: Date())
        let yearAppendedDateString = "\(firstDateString.trimmingCharacters(in: .whitespacesAndNewlines)), \(currentYear)"
        
        // Convert the date string with year to a Date object
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "MMMM d, yyyy"
        guard let date = inputFormatter.date(from: yearAppendedDateString) else {
            throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Date string does not match format.")
        }
        
        self.date = date
        

        id = UUID()
        description = ""
        
        switch name {
            case "Full Moon": // Should randomly select from a preset of images
                let fullMoonImages = ["full-moon", "full-moon2", "full-moon3"]
                    imageName = fullMoonImages.randomElement() ?? "full-moon"
            case let x where x.contains("Meteor Shower"):
                let meteorShowerImages = ["meteor-shower", "meteor-shower2", "meteor-shower3", "meteor-shower4", "meteor-shower5"]
                    imageName = meteorShowerImages.randomElement() ?? "meteor-shower"
            case let x where x.contains("Jupiter"):
                    imageName = "jupiter"
            case let x where x.contains("Mercury"):
                    imageName = "mercury"
            case let x where x.contains("Solstice") || x.contains("Equinox"):
                    imageName = "earth"
            case "New Moon":
                imageName = "new-moon"
            case let x where x.contains("Lunar Eclipse"):
                imageName = "lunar-eclipse"
            case "Annular Solar Eclipse":
                imageName = "annular"
            default:
                imageName = ""
        }
     
    }

}

