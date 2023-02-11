//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by Issei Ueda on 2023/02/09.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    @AppStorage("swift-9uick", store: UserDefaults(suiteName: "group.isseiueda")) var primaryData : Data = Data()
    func placeholder(in context: Context) -> SimpleEntry {
        let storeData = StoreData(showText: "-")
        return SimpleEntry(storeData : storeData, configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        guard let storeData = try? JSONDecoder().decode(StoreData.self, from: primaryData) else {
            return
        }
        let entry = SimpleEntry(storeData: storeData, configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        guard let primaryData = UserDefaults(suiteName: "group.isseiueda")?.data(forKey: "swift-9uick") else { return }
        
        guard let storeData = try? JSONDecoder().decode(StoreData.self, from: primaryData) else {
          return
        }
        let entry = SimpleEntry(storeData: storeData, configuration: configuration)
        
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date = Date()
    let storeData : StoreData
    let configuration: ConfigurationIntent
}

struct WidgetExtensionEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack{
            Color(red: 255 / 255, green: 253 / 255, blue: 152 / 255)
            Text(entry.storeData.showText)
                .foregroundColor(.black)
        }
    }
}

struct WidgetExtension: Widget {
    let kind: String = "WidgetExtension"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetExtensionEntryView(entry: entry)
        }
        .configurationDisplayName("9uick")
        .description("まるで付箋のようなウィジェット")
    }
}

struct WidgetExtension_Previews: PreviewProvider {
    static let storeData =  StoreData(showText: "-")
    static var previews: some View {
        WidgetExtensionEntryView(entry: SimpleEntry(storeData: storeData, configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
