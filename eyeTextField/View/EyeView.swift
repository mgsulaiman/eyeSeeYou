//
//  EyeView.swift
//  eyeTextField
//
//  Created by mgsulaiman on 04/04/2023.
//

import Foundation
import SwiftUI

struct EyeView: View {
    @State private var startFrames = (startFrame: 0, endFrame: 110)
    @State private var isFirstPlay = true
    @State private var isAnimationFinished = false
    @State private var update = true
    @Binding var isEyeWatching: Bool
    @Binding var toggle: Bool

    let frames = (startFrame: 30, endFrame: 50)
    var body: some View {
        LottieGenericView(update: $update, name: Constants.LottieFiles.BlueEyeSeeYou, loopMode: .playOnce, animationFrame: startFrames) {
            if isFirstPlay {
                isFirstPlay = false
            } else {
                isAnimationFinished.toggle()
                isEyeWatching.toggle()
            }
        }
            .onTapGesture {
            update = true
            if toggle {
                let flip = (startFrame: frames.endFrame, endFrame: frames.startFrame)
                startFrames = flip
            } else {
                startFrames = frames
            }
            toggle.toggle()
        }
            .onPreferenceChange(AnimationFinishedKey.self) { value in
            toggle = value
        }
            .preference(key: AnimationFinishedKey.self, value: isEyeWatching)
            .overlay {
            Rectangle()
                .fill(Color.white)
                .frame(width: 45, height: 2)
                .rotationEffect(.degrees(-45))
                .opacity(toggle ? 0 : 1)
        }
            .frame(width: 100, height: 100)
    }
}


