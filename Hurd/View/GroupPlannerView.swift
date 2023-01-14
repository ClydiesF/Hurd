//
//  GroupPlannerView.swift
//  Hurd
//
//  Created by clydies freeman on 12/30/22.
//

import SwiftUI
import SlidingTabView

struct GroupPlannerView: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 4) {
                VStack(alignment: .leading) {
                    Text("Weekend Getaway")
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(.corn)
                    ScrollView(.horizontal) {
                        HStack {
                            TagView(tagName: "9 days left")
                            TagView(tagName: "Wakiki Springs, New Polynesia")
                            TagView(tagName: "1/2/22 - 1/25/22")
                        }
                        .mask(
                            HStack(spacing: 0) {
                                // Middle
                                Rectangle().fill(Color.black)

                                // Right gradient
                                LinearGradient(gradient:
                                   Gradient(
                                       colors: [Color.black, Color.black.opacity(0)]),
                                       startPoint: .leading, endPoint: .trailing
                                   )
                                   .frame(width: 100)
                            }
                         )
                    }
                  
                    
                    Spacer()
                    
                   Image(systemName: "beach.umbrella")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding(10)
                        .background(Color.black.opacity(0.4))
                        .clipShape(Circle())
                }
                .frame(height: 200)
                .padding()
                .background(
                    Image("mockbackground")
                        .resizable()
                        .overlay(content: {
                            Color.black.opacity(0.2)
                        })
                        
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
                .padding(.top)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 15) {
                        PlannerButton_(iconSystemName: "speaker.wave.3.fill", buttonName: "Broadcast", color: .gray.opacity(0.5))
                        
                        PlannerButton_(iconSystemName: "list.bullet.clipboard.fill", buttonName: "Planner", color: .gray.opacity(0.5))
                        
                        PlannerButton_(iconSystemName: "pencil.line", buttonName: "Notes", color: .gray.opacity(0.5))
                        
                        PlannerButton_(iconSystemName: "pencil.line", buttonName: "Notes", color: .gray.opacity(0.5))
                    }
                }
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .padding(.leading, 20)
                
                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("cost estimate")
                            .font(.system(size: 14))
                            .textCase(.uppercase)
                            .foregroundColor(.gray)
                        
                        Divider()
                        Text("$1,500 per person")
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Date Range")
                            .font(.system(size: 14))
                            .textCase(.uppercase)
                            .foregroundColor(.gray)
                        Divider()
                        Text("1/2/22 - 1/22/22")
                    }
                }
                .padding(.horizontal)
                
                Text("Herd")
                    .font(.system(size: 14))
                    .textCase(.uppercase)
                    .foregroundColor(.gray)
                    .padding(.top, 10)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                
                Divider()
                    .padding(.bottom, 10)
                
                HStack(spacing: 20) {
                    MemberProfilePreview(firstName: "Boomy", lastName: "Freeman", color: .purple, image: "mockAvatarImage", organizer: "Organizer")
                    //Second hald
                    VStack(alignment: .leading) {
                        Text("Lorem ipsum dolor sit amet, consect etur adipiscing elit. Praesent faucibus, purus l;svl;ldklnljnw wlweknk ehkskdjj...")
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                        + Text("READ MORE")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .foregroundColor(.bottleGreen)
                        
                        PlannerButton_(iconSystemName: "plus", buttonName: "Add ", color: .gray.opacity(0.5))
                    }
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal) {
                    HStack {
                        MemberProfilePreview(firstName: "Erica", lastName: "Banks", color: .bottleGreen, image: "mockAvatarImage")
                        
                        MemberProfilePreview(firstName: "Todd", lastName: "Williams", color: .pink, image: "mockAvatarImage")
                        
                        MemberProfilePreview(firstName: "Brad", lastName: "NoMansome", color: .blue, image: "mockAvatarImage")
                        
                        MemberProfilePreview(firstName: "Pierre", lastName: "Haynes", color: .green, image: "mockAvatarImage")
                    }
       
                }
                .padding(.leading)
                .padding(.top, 10)
            }
        }
    }
}

    struct GroupPlannerView_Previews: PreviewProvider {
        static var previews: some View {
            GroupPlannerView()
        }
    }
