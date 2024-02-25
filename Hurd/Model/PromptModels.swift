//
//  PromptModels.swift
//  HurdTravel
//
//  Created by clydies freeman on 2/18/24.
//

import Foundation

struct PromptModels {
   static func getItineries(location: String, days: Int, startDate: TimeInterval) -> String {
        
        let dateRangeString = dateRangeString(from: startDate, numOfDays: days)
        return """
            create an list of 3 activities for a trip in \(location) from \(dateRangeString). Provide the list in a JSON formatted string with no backticks that can be decoded by the following model in swift.
        
        struct Activity: Codable, Hashable {
             let type: String
             let name: String
             let location: String?
             let description: String?
             let link: String?
             let status: String?
             let startTime: Double
             let durationHours: Int?
             let durationMinutes: Int?
             let author: String // User Id
        }

        The type should be of the following from this list:
        [
        "food"
        "transportation"
        "sports"
         "flight"
        "club"
        "bar"
        "park"
        "museum"
        "art"
        "historic site"
        "shopping
]
        
There should be activies for each day
provide a link if possible, if no link available provide nil or leave blank
startTime should be in epoch format and should be for the years specified in the date range

The response should look similar to this.
[
{
"type": "food",
"name": "The French Room",
"location": "1701 Market St, Philadelphia, PA 19103",
"description": "Upscale French restaurant with large windows and city views",
"link": "https://www.fourseasons.com/philadelphia/dining/restaurants/the-french-room/",
"startTime": 1645176400,
"durationHours": 3,
"durationMinutes": 0,
"author": "1"
},
{
"type": "museum",
"name": "Philadelphia Museum of Art",
"location": "Benjamin Franklin Pkwy at 26th St, Philadelphia, PA 19130",
"description": "Art museum with a large collection of paintings, sculptures, and decorative arts",
"link": "https://philamuseum.org/",
"startTime": 1645190800,
"durationHours": 2,
"durationMinutes": 0,
"author": "2"
},
{
"type": "shopping",
"name": "King of Prussia Mall",
"location": "160 N Gulph Rd, King of Prussia, PA 19406",
"description": "Upscale shopping mall with over 400 stores and restaurants",
"link": "https://www.kingofprussiamall.com/",
"startTime": 1645262800,
"durationHours": 3,
"durationMinutes": 0,
"author": "3"
}
]
"""
    }
    
    static func dateRangeString(from epochDate: TimeInterval, numOfDays: Int) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MMM dd yyyy"

      let startDate = Date(timeIntervalSince1970: epochDate)
      let endDate = Calendar.current.date(byAdding: .day, value: numOfDays, to: startDate)!

      let startString = dateFormatter.string(from: startDate)
      let endString = dateFormatter.string(from: endDate)

      return "\(startString) - \(endString)"
    }
}
