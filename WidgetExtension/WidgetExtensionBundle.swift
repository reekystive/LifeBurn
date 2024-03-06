//
//  WidgetExtensionBundle.swift
//  WidgetExtension
//
//  Created by ReekyStive on 2024-03-06.
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
