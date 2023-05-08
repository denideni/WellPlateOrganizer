//
//  WellView.swift
//  WellPlateOrganizer
//
//  Created by Deniz Kecik on 5/7/23.
//

import Foundation
import SwiftUI

struct WellView: View {
    @State var currentWell: WellModel
    @State var isTapped: Bool = false
    var body: some View {
        Circle().foregroundColor(currentWell.type.colorOfWell).overlay(content: {
            
            var displayText: String = {
                switch currentWell.type {
                case .positiveControl:
                    return "+"
                case .negativeControl:
                    return "-"
                case .sample(let id):
                    return String(id.split(separator: "-").last ?? "")
                }
            }()
            Text(displayText).font(.caption)
        })
        .alert("Details", isPresented: $isTapped) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Coordinate: \(currentWell.id)\n") +
            Text("Contents: \(currentWell.type.description)")
        }.onTapGesture {
            isTapped = true
        }
    }
}
