//
//  ContentView.swift
//  Hurd
//
//  Created by clydies freeman on 12/27/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var selected = 0
    
    var body: some View {
//        Text("Hey")
        ZStack() {
            switch self.selected {
            case 0:
                DiscoveryView()
            case 1:
                SearchView()
            case 2:
                AddTripView()
            case 3:
                ChatDmView()
            case 4:
                ProfileView()
            default:
                DiscoveryView()
            }

            VStack {
                Spacer()
                FloatingTabbar(selected: $selected)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FloatingTabbar: View {
    
    @Binding var selected: Int
    @State var expand = false
    
    var body: some View {
        HStack {
            
            Spacer(minLength: 0)
            HStack {
                
                if !self.expand {
                    Button {
                        self.expand.toggle()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .fontWeight(.black)
                            .padding(.horizontal)
                    }

                } else {
                    Button {
                        self.selected = 0
                    } label: {
                        Image("adventureIcon")
                            .renderingMode(.template)
                            .foregroundColor(self.selected == 0 ? .bottleGreen : .white)
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button {
                        self.selected = 1
                    } label: {
                        Image("searchIcon")
                            .renderingMode(.template)
                            .foregroundColor(self.selected == 1 ? .bottleGreen : .white)
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button {
                        self.selected = 2
                    } label: {
                        Image("plusIcon")
                            .renderingMode(.template)
                            .foregroundColor(self.selected == 2 ? .bottleGreen : .white)
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button {
                        self.selected = 3
                    } label: {
                        Image("chatIcon")
                            .renderingMode(.template)
                            .foregroundColor(self.selected == 3 ? .bottleGreen : .white)
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button {
                        self.selected = 4
                    } label: {
                        Image("chatIcon")
                            .renderingMode(.template)
                           .foregroundColor(self.selected == 4 ? .bottleGreen : .white)
                            .padding(.horizontal)
                    }
                }
                

            }
            .padding()
            .background(Color.black.opacity(0.5))
            .clipShape(Capsule())
            .padding(.horizontal)
            .onLongPressGesture {
                self.expand.toggle()
            }
            .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6), value: expand)
        }
      
    }
    
}
