//
//  WidgetExtensionBundle.swift
//  WidgetExtension
//
//  Created by Issei Ueda on 2023/02/09.
//

import WidgetKit
import SwiftUI

@main
struct WidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        WidgetExtension()
        WidgetExtensionLiveActivity()
    }
}
