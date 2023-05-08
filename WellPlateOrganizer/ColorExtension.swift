//
//  ColorExtension.swift
//  WellPlateOrganizer
//
//  Created by Deniz Kecik on 5/7/23.
//

import Foundation
import SwiftUI

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
    
    static var randomBlue: Color {
        return Color(
            red: 1,
            green: .random(in: 0.3...1),
            blue: 1
        )
    }
}
