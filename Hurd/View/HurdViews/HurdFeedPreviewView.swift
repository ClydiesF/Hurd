//
//  HurdFeedPreviewView.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/23/23.
//

import SwiftUI

struct HurdFeedPreviewView: View {
    var body: some View {
        VStack {
            Text("The Hooligans")
                .font(.system(size: 13))
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.3)))
            
            HStack {
                VStack {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 40)
                    HStack {
                        Label("5", systemImage: "person.fill")
                            .font(.system(size: 13))
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.3)))
                        
                        Image(systemName: "lock.open")
                    }
                    
                }
                
                
                VStack(spacing: 5) {
                    HStack(spacing: 5) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 40)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 40)
                    }
                    
                    HStack(spacing: 5) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 40)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 40)
                    }
                }
                
            }
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
        
    }
}

struct HurdFeedPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        HurdFeedPreviewView()
            .frame(width: UIScreen.main.bounds.size.width * 0.45)
            .padding()
    }
}
