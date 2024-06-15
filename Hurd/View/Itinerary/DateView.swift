//
//  DateView.swift
//  HurdTravel
//
//  Created by clydies freeman on 2/13/24.
//

import SwiftUI

struct DateView: View {
    
    let date: Date
    let index: Int
    @Binding var selectedSegment: Int
    
    var body: some View {
            VStack {
                Text(formatNum(date:date))
                    .font(.title2)
                    .fontWeight(.thin)
                Text(formatDay(date:date))
            }
            .frame(width: 40)
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).fill(isDateSelected() ? .green.opacity(0.2) : .white))
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.2), lineWidth: 2))
        


    }
    
    // MARK: Methods
    
    func isDateSelected() -> Bool { index == selectedSegment }
    
    func formatNum(date: Date?) -> String {
        guard let date else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"//"MMM d, yy - E"
        return dateFormatter.string(from: date)
    }
    
    func formatDay(date: Date?) -> String {
        guard let date else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEEEE"//"MMM d, yy - E"
        return dateFormatter.string(from: date)
    }
    
}

#Preview {
    DateView(date: Date(), index: 0, selectedSegment: .constant(0))
}
