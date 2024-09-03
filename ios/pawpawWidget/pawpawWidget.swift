import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
    let widgetFamily: WidgetFamily
    let filename: String
}

struct PawpawWidgetEntryView: View {
    var entry: SimpleEntry
    
    var body: some View {
        VStack {
            if entry.filename == "widget_ready" {
                Image("widget_ready")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 160, height: 160)
                    .clipped()
            }
            else if let image = UIImage(contentsOfFile: entry.filename) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 160, height: 160)
                    .clipped()
            }
        }
        .containerBackground(for: .widget) {
            Color(red: 54/255, green: 219/255, blue: 191/255)
        }
    }
}

struct pawpawWidget: Widget {
    let kind: String = "pawpawWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PawpawTimelineProvider()) { entry in
            PawpawWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("매일 산책")
        .description("매일 우리집 강아지 산책을 완료하고 사진을 감상해 보세요.")
        .supportedFamilies([.systemSmall])
    }
}

struct PawpawTimelineProvider: TimelineProvider {
    typealias Entry = SimpleEntry
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), widgetFamily: context.family, filename: "widget_ready")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry: SimpleEntry
        if context.isPreview {
            entry = placeholder(in: context)
        } else {
            let userDefaults = UserDefaults(suiteName: "group.pawpaw")
            let image = userDefaults?.string(forKey: "title") ?? "widget_ready"
            entry = SimpleEntry(date: Date(), widgetFamily: context.family, filename: image)
        }
        
        
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getSnapshot(in: context) { entry in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}

