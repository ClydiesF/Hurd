//
//  HurdManagementView.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/23/23.
//

import SwiftUI

struct HurdManagementView: View {
    @State var lockModeISOn: Bool = false
    @State var capacity: Int = 5
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
  
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5){
            Text("Organizer")
                .fontWeight(.bold)
            HurdAdminView(user: User.mockUser2)
            
            Toggle("lock hurd", isOn: $lockModeISOn)
            
            Stepper("Hurd Capacity: \(capacity)", value: $capacity, in: 0...10, step: 1)
            
            Text("Members")
                .fontWeight(.bold)
            
            LazyVGrid(columns: columns, spacing: 20) {
                HurdMemberView(user: User.mockUser3)
                HurdMemberView(user: User.mockUser3)
            }
        
              
            }
        .padding(.horizontal, 10)
        .navigationTitle("Hurd Management")
            
        }
    }

struct HurdManagementView_Previews: PreviewProvider {
    static var previews: some View {
        HurdManagementView()
    }
}
