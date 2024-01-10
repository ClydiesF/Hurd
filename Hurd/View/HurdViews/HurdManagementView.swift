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
    var hurd: Hurd
    @State private var bgColor = Color.red
    @State private var hurdName: String = ""
    
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5) {
            Text(hurd.hurdName)
                .fontWeight(.bold)
                .font(.title)
            
            HStack {
                Image(systemName: hurd.isLocked ? "lock.fill" : "lock.open.fill")
                    .font(.system(size: 13))
                    .padding(8)
                    .background(Circle().fill(.gray.opacity(0.2)))
                
                Label("\(hurd.memberCount) / \(hurd.capacity)", systemImage: "person.fill")
                    .font(.system(size: 13))
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
                
                Circle().fill(bgColor)
                    .frame(width: 30, height: 30)
                
            }
            
            if let description = hurd.description {
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.vertical,Spacing.eight)
            }
            
            VStack {
                Toggle("Lock hurd", isOn: $lockModeISOn)
                    .font(.system(size: 14))
                
                Stepper("Hurd Capacity", value: $capacity, in: 0...10, step: 1)
                    .font(.system(size: 14))
                
                ColorPicker("Set the background color", selection: $bgColor)
                    .font(.system(size: 14))
            }
            .padding(Spacing.sixteen)
            .background(
                RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.1))
                
            )
            
            
            Text("Organizer")
                .fontWeight(.bold)
            
            HurdAdminView(user: User.mockUser2)
            
            
            Text("Members")
                .fontWeight(.bold)
            
            LazyVGrid(columns: columns, spacing: 20) {
                HurdMemberView(user: User.mockUser3)
                HurdMemberView(user: User.mockUser3)
            }
            
            Spacer()
        }
        .padding(.horizontal, 10)
        .navigationTitle("Hurd Management")
        
    }
}

struct HurdManagementView_Previews: PreviewProvider {
    static var previews: some View {
        HurdManagementView(hurd: Hurd.mockHurd)
    }
}
