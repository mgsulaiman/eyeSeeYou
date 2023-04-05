//
//  LottieGenericView.swift
//  eyeTextField
//
//  Created by mgsulaiman on 04/04/2023.
//

import Foundation
import SwiftUI
import Lottie
import UIKit
struct LottieGenericView: UIViewRepresentable {
    @Binding var update: Bool
    var name: String
    var loopMode: LottieLoopMode = .loop
    var animationFrame: (startFrame: Int, endFrame: Int)
    var onAnimationFinished: (() -> Void)?

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named(name)
        animationView.loopMode = loopMode
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if update {
            guard let animationView = uiView.subviews.first as? LottieAnimationView else { return }
            animationView.play(
                fromFrame: AnimationFrameTime(animationFrame.startFrame),
                toFrame: AnimationFrameTime(animationFrame.endFrame),
                loopMode: loopMode,
                completion: { _ in
                    context.coordinator.animationFinished()
                }
            )
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: LottieGenericView

        init(_ animationView: LottieGenericView) {
            self.parent = animationView
        }
        func animationFinished() {
            parent.update = false
            parent.onAnimationFinished?()
        }
    }
}

