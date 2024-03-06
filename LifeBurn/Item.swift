//
//  Item.swift
//  LifeBurn
//
//  Created by ReekyStive on 2024-03-05.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
