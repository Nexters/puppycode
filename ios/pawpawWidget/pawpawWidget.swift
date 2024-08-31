import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
    let widgetFamily: WidgetFamily // 위젯 크기 추가
    let filename: String
}

struct PawpawWidgetEntryView: View {
    var entry: SimpleEntry
    
    var body: some View {
        VStack {
            if let image = UIImage(contentsOfFile: entry.filename) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 160, height: 160)
                    .clipped()

            } else {
                Image("widget_ready")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 160, height: 160)
                    .clipped()
            }
        }
        .containerBackground(for: .widget) {
            Color.white
            //Color(red: 54/255, green: 219/255, blue: 191/255)
        }
    }
}

struct pawpawWidget: Widget {
    let kind: String = "pawpawWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PawpawTimelineProvider()) { entry in
            PawpawWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Pawpaw Widget")
        .description("This widget displays an image of pawpaw.")
        .supportedFamilies([.systemSmall]) // 지원하는 위젯 크기 설정
    }
}

struct PawpawTimelineProvider: TimelineProvider {
    typealias Entry = SimpleEntry
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), widgetFamily: context.family, filename: "No screenshot available") // 위젯 크기 설정
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry: SimpleEntry
        if context.isPreview {
            entry = placeholder(in: context)
        } else {
            let userDefaults = UserDefaults(suiteName: "group.pawpaw")
            let image = userDefaults?.string(forKey: "title") ?? "No screenshot available"
            entry = SimpleEntry(date: Date(), widgetFamily: context.family, filename: image) // 위젯 크기 설정
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

