//
//  AnimationFinishedKey.swift
//  eyeTextField
//
//  Created by mgsulaiman on 04/04/2023.
//

import Foundation
import SwiftUI

struct AnimationFinishedKey: PreferenceKey {
    typealias Value = Bool
    static var defaultValue: Bool = false
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}
