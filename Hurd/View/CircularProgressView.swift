//
//  CircularProgressView.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/8/23.
//

import SwiftUI

struct CircularProgressView: View {
    
    let progress: Double
    let barWidth: CGFloat
    let textSize: CGFloat
    let countdown: [String: Int]
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.gray.opacity(0.5),
                    lineWidth: barWidth
                )
            
            Circle()
                .trim(from: 0, to: progress) // 1
                .stroke(
                    Color.bottleGreen,
                    style: StrokeStyle(
                        lineWidth: barWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
            if let days = countdown["days"] {
                Text("\(days)D")
                    .fontWeight(.semibold)
                    .font(.system(size: textSize))
                    .foregroundColor(Color("textColor"))
            }
        }
        .padding(.horizontal, 5)
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: 0.5, barWidth: 20, textSize: 20, countdown: ["days": 55])
    }
}
