//
//  ContentView.swift
//  LifeBurn
//
//  Created by ReekyStive on 2024-03-05.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    @State private var birthDate = Date()
    // World average, this can be adjusted.
    @State private var lifeExpectancy = 82

    var body: some View {
        VStack {
            DatePicker("Enter your birth date", selection: $birthDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            Button("Set Life Progress") {
                calculateLifeProgress(birthDate: birthDate, lifeExpectancy: lifeExpectancy)
            }
        }
    }

    func calculateLifeProgress(birthDate: Date, lifeExpectancy: Int) {
        // TODO: Implement this function
    }
}

#Preview {
    ContentView()
}
