//
//  GroupPlannerView.swift
//  Hurd
//
//  Created by clydies freeman on 12/30/22.
//

import SwiftUI
import SlidingTabView

struct GroupPlannerView: View {
    
    @State private var selectedTabIndex = 0
    let tabs = ["rectangle.and.pencil.and.ellipsis",
                "calendar",
                "bed.double",
                "map",
                "list.bullet.clipboard",
                "square.and.pencil"
    ]
    
    
    var body: some View {
        
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                
                HStack {
                    Image("mockAvatarImage")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .cornerRadius(15)
                    
                    Text("Jake Ackerman")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    Spacer()
                    Text("$299/night")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        TagView(tagName: "9 days left")
                        TagView(tagName: "Excursion")
                        TagView(tagName: "Wihiki Springs, Polyesia")
                        TagView(tagName: "1/2/22-1/8/22")
                    }
                }
                .frame(height: 30)
                
                Text("Weekend Getaway")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(.corn)
                
                Text("Leave the hustle and bustle of the city behind as you look over the sparking blue waters of wakiki Springs. Featuring light... Read More")
                    .font(.caption)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("Members")
                            .foregroundColor(.corn)
                            .font(.title3)
                            .fontWeight(.heavy)
                        HStack(spacing: 20) {
                            ForEach(1...5, id: \.self) { _ in
                                Image("mockAvatarImage")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(15)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        Button {
                            print("")
                        } label: {
                            Image(systemName: "speaker.wave.2.fill")
                                .foregroundColor(.white)
                        }
                        .padding(10)
                        .background(Circle().fill(.black.opacity(0.4)))
                        
                        Button {
                            print("")
                        } label: {
                            Image(systemName: "person.fill.badge.plus")
                                .foregroundColor(.white)
                        }
                        .padding(10)
                        .background(Circle().fill(.black.opacity(0.4)))
                        
                    }
                }
            }
            .padding()
            .background(
                Image("mockbackground")
                    .resizable()
                    .ignoresSafeArea()
                    .overlay {
                        Color.black.opacity(0.25)
                            .ignoresSafeArea()
                    }
            )
            // Slider View
            HurdSlidingTabView(selection: $selectedTabIndex, tabs: tabs,activeAccentColor: .bottleGreen, selectionBarColor: .bottleGreen)
            
            switch self.selectedTabIndex {
            case 0: Color.bottleGreen.ignoresSafeArea()
            case 1:  Color.red.ignoresSafeArea()
            case 2:  Color.blue.ignoresSafeArea()
            case 3:  Color.gray.ignoresSafeArea()
            case 4:  Color.purple.ignoresSafeArea()
            case 5:  Color.yellow.ignoresSafeArea()
                
            default:
                Color.black.ignoresSafeArea()
            }
            
        }

        
    }
}

struct GroupPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        GroupPlannerView()
    }
}
