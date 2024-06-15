//
//  DateViewAI.swift
//  HurdTravel
//
//  Created by clydies freeman on 2/18/24.
//

import SwiftUI

struct DateViewAI: View {
    let date: Date
    let index: Int
    @Binding var selectedSegment: Int
    
    var body: some View {
        VStack {
            Text(formatNum(date:date))
                .font(.system(size: 18))
                .fontWeight(.bold)
            
            Text(formatDay(date:date))
                .font(.caption)
        }
        .frame(width: 40)
        .padding(10)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .background(RoundedRectangle(cornerRadius: 10).fill( isDateSelected() ? .purple.opacity(0.3) : .white))
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
    DateViewAI(date: Date.now, index: 0, selectedSegment: .constant(0))
}
