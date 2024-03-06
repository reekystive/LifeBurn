//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by ReekyStive on 2024-03-06.
//

import SwiftUI
import WidgetKit

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct WidgetExtensionEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            HStack {
                Text(entry.configuration.favoriteEmoji)
                    .font(.largeTitle)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Est. death date")
                        .fontDesign(.rounded)
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 1, green: 0.89, blue: 0.89))
                    Text("Jun 15, 2069")
                        .fontDesign(.rounded)
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }

            Spacer()

            HStack {
                VStack(alignment: .leading) {
                    Text("29%")
                        .fontDesign(.rounded)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("14,348,008 minutes spent")
                        .fontDesign(.rounded)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                Spacer()
            }

            GeometryReader { metrics in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 8)
                        .background(Color(red: 0.3, green: 0.3, blue: 0.29).opacity(0.5))

                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: metrics.size.width * 0.29, height: 8)
                        .background(.white)
                        .cornerRadius(8)
                }
                .cornerRadius(8)
            }
        }
    }
}

struct WidgetExtension: Widget {
    let kind: String = "WidgetExtension"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WidgetExtensionEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.96, green: 0.37, blue: 0.37), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.78, green: 0, blue: 0.61), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                }
                .foregroundColor(.white)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var fire: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🔥"
        return intent
    }

    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemMedium) {
    WidgetExtension()
} timeline: {
    SimpleEntry(date: .now, configuration: .fire)
    SimpleEntry(date: .now, configuration: .starEyes)
}
