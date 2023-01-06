//
//  UnlockButton.swift
//  Hurd
//
//  Created by clydies freeman on 12/28/22.
//

import SwiftUI

public struct UnlockButton: View {

    @Binding var isLocked: Bool
    @Binding var isLoading: Bool
    
    var callbackFunc: () -> ()

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                BackgroundComponent()
                DraggableComponent(isLocked: $isLocked, isLoading: $isLoading, maxWidth: geometry.size.width)
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
            self.callbackFunc()
            isLocked = true
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

            Text("Slide to Explore")
                .font(.footnote)
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
        }
    }
}


struct UnlockButton_Previews: PreviewProvider {
    static var previews: some View {
        UnlockButton(isLocked: .constant(true), isLoading: .constant(false),callbackFunc: {})
    }
}
