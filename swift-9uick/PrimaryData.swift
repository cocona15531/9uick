//
//  PrimaryData.swift
//  swift-9uick
//
//  Created by Issei Ueda on 2023/02/09.
//

import SwiftUI
import WidgetKit

struct PrimaryData {
    @AppStorage("swift-9uick", store: UserDefaults(suiteName: "group.isseiueda")) var primaryData : Data = Data()
    let storeData : StoreData
    
    func encodeData() {
        guard let data = try? JSONEncoder().encode(storeData) else {
            return
        }
//        print(storeData)
        primaryData = data
        UserDefaults.standard.set(storeData.showText, forKey: "memo")
        WidgetCenter.shared.reloadAllTimelines()
    }
}

