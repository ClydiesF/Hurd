//
//  ActivityView.swift
//  HurdTravel
//
//  Created by clydies freeman on 2/2/24.
//

import SwiftUI

struct ActivityView: View {
    
    let activity: Activity
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.eight) {
            HStack {
                if let startTime = activity.startTime {
                    Text(convertEpochDateIntoDateComponentString(epoch: Int(startTime)))
                        .font(.title3)
                        .fontWeight(.semibold)
                } else {
                    Text("TBD")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.red)
                }
         
                Spacer()
                //TODO: Possible add the Author when more than one author is responsible for an activity.
                Image(systemName: activity.iconName)
                    .BadgeStyle()
            }
         
            HStack {
                VStack(alignment: .leading) {
                    Text(activity.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    if let location = activity.location {
                        Text(location)
                            .font(.caption)
                            .foregroundStyle(.blue)
                    }
                }
                Spacer()
                // TODO: Convert this into a button and convert link into a URL
                if let link = activity.link {
                    if !link.isEmpty {
                        Image(systemName: "link")
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                            .font(.system(size: 15))
                            .frame(width: 30, height: 30)
                    }
                }
                if let hours = activity.durationHours, let minutes = activity.durationMinutes {
                    Text(returnDurationString(hours: hours, minutes: minutes))
                        .font(.system(size: 12))
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Capsule().fill(.gray.opacity(0.2)))
                }
     
            }
       
            if let description = activity.description {
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
    }
    
    // Functions
    func convertEpochDateIntoDateComponentString(epoch: Int) -> String {
        let epochTimeSeconds = TimeInterval(epoch)
        let date = Date(timeIntervalSince1970: epochTimeSeconds)
        
        let userTimeZone = TimeZone.current
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = userTimeZone

        
        dateFormatter.dateFormat = "h:mm a" // 2023-09-21
        
        let formattedDateString = dateFormatter.string(from: date)
        print("DEBUG: Formatted Date String -- \(formattedDateString)")
        return formattedDateString
    }
    
    func returnDurationString(hours: Int?, minutes: Int?) -> String {
        switch (hours, minutes) {
        case (0, let minutes):
            return "\(minutes ?? 0)min"
        case (let hours, 0):
            return "\(hours ?? 0)hr"
        case (let hours, let minutes):
            return "\(hours ?? 0)hr \(minutes ?? 0)min"
        }
    }
}

struct ActivityViewAI: View {
    
    let activity: ActivityAI
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.eight) {
            HStack {
                    Text(convertEpochDateIntoDateComponentString(epoch: Int(activity.startTime)))
                        .font(.title3)
                        .fontWeight(.bold)
              
                
                Spacer()
                //TODO: Possible add the Author when more than one author is responsible for an activity.
                Image(systemName: activity.iconName)
                    .BadgeStyle()
            }
         
            HStack {
                VStack(alignment: .leading) {
                    Text(activity.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    if let location = activity.location {
                        Text(location)
                            .font(.caption)
                            .foregroundStyle(.blue)
                    }
                }
                Spacer()
                // TODO: Convert this into a button and convert link into a URL
                if let link = activity.link {
                    if !link.isEmpty {
                        Image(systemName: "link")
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                            .font(.system(size: 15))
                            .frame(width: 30, height: 30)
                    }
                }
        
                Text(returnDurationString(hours: activity.durationHours, minutes: activity.durationMinutes))
                    .font(.system(size: 12))
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(Capsule().fill(.gray.opacity(0.2)))
            }
       
            if let description = activity.description {
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
    }
    
    // Functions
    func convertEpochDateIntoDateComponentString(epoch: Int) -> String {
        let epochTimeSeconds = TimeInterval(epoch)
        let date = Date(timeIntervalSince1970: epochTimeSeconds)
        
        let userTimeZone = TimeZone.current
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = userTimeZone

        
        dateFormatter.dateFormat = "h:mm a" // 2023-09-21
        
        let formattedDateString = dateFormatter.string(from: date)
        print("DEBUG: Formatted Date String -- \(formattedDateString)")
        return formattedDateString
    }
    
    func returnDurationString(hours: Int?, minutes: Int?) -> String {
        switch (hours, minutes) {
        case (0, let minutes):
            return "\(minutes ?? 0)min"
        case (let hours, 0):
            return "\(hours ?? 0)hr"
        case (let hours, let minutes):
            return "\(hours ?? 0)hr \(minutes ?? 0)min"
        }
    }
}

#Preview {
    ActivityView(activity: Activity.mockActivity)
}
