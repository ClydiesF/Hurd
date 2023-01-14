//
//  PlannerButton'.swift
//  Hurd
//
//  Created by clydies freeman on 1/13/23.
//

import SwiftUI

struct PlannerButton_: View {
    
    let iconSystemName: String
    let buttonName: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: iconSystemName)
                .foregroundColor(.white)
                .font(.system(size: 14))
                .fontWeight(.semibold)
            
            
            Text(buttonName)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.system(size: 14))
        }
        .padding(10)
        .background(color)
        .clipShape(Capsule())
    }
}

struct PlannerButton__Previews: PreviewProvider {
    static var previews: some View {
        PlannerButton_(iconSystemName: "cloud", buttonName: "Broadcast", color: .gray.opacity(0.5))
    }
}
