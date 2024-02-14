//
//  CustomDatePicker.swift
//  HurdTravel
//
//  Created by clydies freeman on 1/31/24.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var hourSelection: Int
    @Binding var minuteSelection: Int
    
    static private let maxHours = 24
    static private let maxMinutes = 60
    private let hours = [Int](0...Self.maxHours)
    private let minutes = [Int](0...Self.maxMinutes)
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: .zero) {
                Picker(selection: $hourSelection, label: Text("Duration")) {
                    ForEach(hours, id: \.self) { value in
                        Text("\(value) hr")
                            .tag(value)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 2, alignment: .center)
                
                Picker(selection: $minuteSelection, label: Text("")) {
                    ForEach(minutes, id: \.self) { value in
                        Text("\(value) min")
                            .tag(value)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 2, alignment: .center)
            }
        }
    }
}

#Preview {
    CustomDatePicker(hourSelection: .constant(22), minuteSelection: .constant(30))
}
