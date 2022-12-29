//
//  UnlockButton.swift
//  Hurd
//
//  Created by clydies freeman on 12/28/22.
//

import SwiftUI

public struct UnlockButton: View {

    @State private var isLocked = true
    @State private var isLoading = false

    public init() { }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                BackgroundComponent()
                DraggableComponent(isLocked: $isLocked, isLoading: isLoading, maxWidth: geometry.size.width)
            }
        }
        .frame(height: 50)
        .padding()
        .padding(.bottom, 20)
        .onChange(of: isLocked) { isLocked in
            guard !isLocked else { return }
            simulateRequest()
        }
    }

    private func simulateRequest() {
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
        }
    }
}

public struct BackgroundComponent: View {
    
    @State private var hueRotation = false
    
    public init() { }
    
    public var body: some View {
        ZStack(alignment: .leading)  {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.bottleGreen.opacity(0.7))
//                .fill(
//                    LinearGradient(
//                        colors: [Color.bottleGreen.opacity(0.6), Color.bottleGreen.opacity(0.6)],
//                        startPoint: .leading,
//                        endPoint: .trailing
//                    )
//                )
                //.hueRotation(.degrees(hueRotation ? 20 : -20))
            
            Text("Slide to Explore")
                .font(.footnote)
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
        }
        .onAppear {
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                hueRotation.toggle()
            }
        }
    }
}


struct UnlockButton_Previews: PreviewProvider {
    static var previews: some View {
        UnlockButton()
    }
}
