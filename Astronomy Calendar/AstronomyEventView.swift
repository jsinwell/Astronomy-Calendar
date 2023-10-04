//
import SwiftUI

struct AstronomyEventView: View {
    var event: AstronomyEvent

    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(event.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.gray)
                        .opacity(0.2)
                )
            
            VStack(alignment: .leading) {
                Text(eventDate(from: event.date))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(event.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(nil)
            }
            .padding()
        }
    }
    
    private func eventDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter.string(from: date)
    }
}
