import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct pawpawWidgetEntryView: View {
    var entry: SimpleEntry
    var body: some View {
            VStack {
                Image("widget_ready")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 160, height: 160)
                    .clipped()
            }
            .containerBackground(for: .widget){
                Color(red: 54/255, green: 219/255, blue: 191/255)
            }
        }
}

struct pawpawWidget: Widget {
    let kind: String = "pawpawWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PawpawTimelineProvider()) { entry in
            pawpawWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Pawpaw Widget")
        .description("This widget displays an image of pawpaw.")
    }
}

struct PawpawTimelineProvider: TimelineProvider {
    typealias Entry = SimpleEntry

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let entries: [SimpleEntry] = [
            SimpleEntry(date: Date())
        ]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
