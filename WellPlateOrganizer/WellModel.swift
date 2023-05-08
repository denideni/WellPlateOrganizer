//
//  WellModel.swift
//  WellPlateOrganizer
//
//  Created by Deniz Kecik on 5/7/23.
//

import Foundation
import SwiftUI

enum WellTypes: CustomStringConvertible, Comparable, Hashable {
    
    private static var colors: [String: Color] = [:]
    case sample(id: String)
    case positiveControl
    case negativeControl
    
    init(sampleId: String) {
        switch sampleId {
        case "positive-control":
            self = .positiveControl
        case "negative-control":
            self = .negativeControl
        default:
            self = .sample(id: sampleId)
        }
    }
    
    var description: String {
        switch self {
        case .positiveControl:
            return "Positive Control"
        case .negativeControl:
            return "Negative Control"
        case .sample(let id):
            return id
        }
    }
    
    var colorOfWell: Color {
        switch self {
        case .positiveControl:
            return .green
        case .negativeControl:
            return .red
        case .sample(let id):
            if WellTypes.colors[id] == nil {
                WellTypes.colors[id] = .randomBlue
                return WellTypes.colors[id]!
            }
            return WellTypes.colors[id]!
        }
    }
    
    static func < (lhs: WellTypes, rhs: WellTypes) -> Bool {
        lhs.description.compare(rhs.description, options: .numeric) == .orderedAscending
    }
    
    static func == (lhs: WellTypes, rhs: WellTypes) -> Bool {
        lhs.description.compare(rhs.description, options: .numeric) == .orderedSame
    }
}

struct WellModel: Identifiable, Comparable {
    static func < (lhs: WellModel, rhs: WellModel) -> Bool {
        lhs.id.compare(rhs.id, options: .numeric) == .orderedAscending
    }
    
    static func == (lhs: WellModel, rhs: WellModel) -> Bool {
        lhs.id.compare(rhs.id, options: .numeric) == .orderedSame && lhs.type == rhs.type
    }
    
    var id: String
    var coordinate: String // location of the circle on the plate
    var type: WellTypes
    
    init(coordinate: String, type: WellTypes) {
        self.id = coordinate.uppercased() + type.description
        self.coordinate = coordinate.uppercased()
        self.type = type
    }
}
