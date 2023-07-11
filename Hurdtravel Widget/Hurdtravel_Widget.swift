//
//  Hurdtravel_Widget.swift
//  Hurdtravel Widget
//
//  Created by clydies freeman on 7/9/23.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> TripEntry {
        TripEntry(date: Date(),title: "Vacation",coutDownInDays: "12", startDate: "12-12-23",image: Image(systemName: "person.fill"), icon:"beach.umbrella", configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (TripEntry) -> ()) {
        let entry = TripEntry(date: Date(),title: "Vacation",coutDownInDays: "12", startDate: "12-22-23",image: Image("mockbackground"), icon:"beach.umbrella", configuration: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [TripEntry] = []
        let userdefaults = UserDefaults(suiteName: "group.widgetTripCache")
        
        let title = userdefaults?.value(forKey: "tripName") as! String
        let startDate =  userdefaults?.value(forKey: "startDate") as! String
        let countDownInDays = String(userdefaults?.value(forKey: "countdownDays") as! Int)
        let photoImage = userdefaults?.value(forKey: "photoImage") as? String
        let icon = userdefaults?.value(forKey: "icon") as? String
        
        var image: Image = Image(systemName: "person.fill")
        
        if let photoImage {
            image = Image(systemName: "person.fill").data(url: URL(string: photoImage)!)
        }

        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = TripEntry(date: entryDate,
                                  title: title,
                                  coutDownInDays: countDownInDays,
                                  startDate: startDate,
                                  image: image,
                                  icon: icon ?? "",
                                  configuration: configuration)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct TripEntry: TimelineEntry {
    let date: Date
    let title: String
    let coutDownInDays: String
    let startDate: String
    let image: Image
    let icon: String
    let configuration: ConfigurationIntent
}

struct Hurdtravel_WidgetEntryView : View {
    var entry: TripEntry
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(entry.title)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                  
                Text(entry.coutDownInDays)
                    .foregroundColor(Color.white)
                    .font(.system(size: 60))
                    .fontWeight(.heavy)
                
                Spacer()
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("Days")
                            .foregroundColor(Color.white)
                        Text(entry.startDate)
                            .foregroundColor(Color.white)
                    }
                    .font(.system(size: 14))
                    Spacer()
                    
                    Image(systemName: entry.icon)
                        .foregroundColor(Color.white)
                        .padding(8)
                        .background(Circle().fill(Color.black.gradient))
                }
            }
            .padding()
        }
        .background(
            entry.image
                .overlay{
                    Color.black.opacity(0.3)
                }
        )
    }
}

struct Hurdtravel_Widget: Widget {
    let kind: String = "Hurdtravel_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Hurdtravel_WidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("Trip CountDown")
        .description("Displays a Countdown timer for your next upcoming trip.")
    }
}

struct Hurdtravel_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Hurdtravel_WidgetEntryView(entry: TripEntry(date: Date(),title: "Vacation",coutDownInDays: "12", startDate: "12-12-23",image: Image(systemName: "person.fill"),icon: "beach.umbrella", configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

extension Image {
    func data(url: URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self.resizable()
    }
}
