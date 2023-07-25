//
//  TripDateView.swift
//  Hurd
//
//  Created by clydies freeman on 2/5/23.
//

import SwiftUI

struct TripDateView: View {
    var tripDate: Double
    
    var body: some View {
        VStack {
            Text(returnDateNumber())
                .font(.system(size: 18))
                .foregroundColor(Color("textColor"))
                .fontWeight(.bold)
            
            Text(returnDateMonth().uppercased())
            
                .foregroundColor(Color("textColor"))
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10).fill(Color("backgroundColor").gradient)
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 3, y: 3))
    }
    
    // Func
    private func  returnDateNumber() -> String {
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
        
        let dateFromDouble = Date(timeIntervalSince1970: tripDate)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: localTimeZoneAbbreviation) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd" //Specify your format that you want
        let strDate = dateFormatter.string(from: dateFromDouble)
        
        return strDate
    }
    
    private func  returnDateMonth() -> String {
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
        let dateFromDouble = Date(timeIntervalSince1970: tripDate)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: localTimeZoneAbbreviation) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMM" //Specify your format that you want
        let strDate = dateFormatter.string(from: dateFromDouble)
        
        return strDate
    }
}

struct TripDateView_Previews: PreviewProvider {
    static var previews: some View {
        TripDateView(tripDate: 183839835389)
    }
}
