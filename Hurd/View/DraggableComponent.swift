//
//  DraggableComponent.swift
//  Hurd
//
//  Created by clydies freeman on 12/28/22.
//

import SwiftUI

struct DraggableComponent: View {
    @Binding var isLocked: Bool
    let isLoading: Bool
    let maxWidth: CGFloat
    
    @State private var width = CGFloat(50)
    private  let minWidth = CGFloat(50)
    
    public init(isLocked: Binding<Bool>, isLoading: Bool, maxWidth: CGFloat) {
        _isLocked = isLocked
        self.isLoading = isLoading
        self.maxWidth = maxWidth
    }
    
    public var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.clear)
            .opacity(width / maxWidth)
            .frame(width: width)
            .overlay(
                Button(action: { }) {
                    ZStack {
                        image(name: "lock", isShown: isLocked)
                        progressView(isShown: isLoading)
                        image(name: "lock.open", isShown: !isLocked && !isLoading)
                    }
                    .animation(.easeIn(duration: 0.35).delay(0.55), value: !isLocked && !isLoading)
                }
                //.buttonStyle(BaseButtonStyle())
                    .disabled(!isLocked || isLoading),
                alignment: .trailing
            )
        
            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                        guard isLocked else { return }
                        if value.translation.width > 0 {
                            width = min(max(value.translation.width + minWidth, minWidth), maxWidth)
                        }
                    }
                    .onEnded { value in
                        guard isLocked else { return }
                        if width < maxWidth {
                            width = minWidth
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        } else {
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                            withAnimation(.spring().delay(0.5)) {
                                isLocked = false
                            }
                        }
                    }
            )
            .animation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 0), value: width)
        
    }
    
    private func image(name: String, isShown: Bool) -> some View {
        Image(systemName: name)
            .font(.system(size: 20, weight: .regular, design: .rounded))
            .foregroundColor(Color.bottleGreen)
            .frame(width: 40, height: 40)
            .background(RoundedRectangle(cornerRadius: 20).fill(.white))
            .padding(4)
            .opacity(isShown ? 1 : 0)
            .scaleEffect(isShown ? 1 : 0.01)
    }
    
    private func progressView(isShown: Bool) -> some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(.white)
            .opacity(isShown ? 1 : 0)
            .scaleEffect(isShown ? 1 : 0.01)
    }
    
    struct DraggableComponent_Previews: PreviewProvider {
        static var previews: some View {
            DraggableComponent(isLocked: .constant(true), isLoading: false, maxWidth: 300)
        }
    }
}
