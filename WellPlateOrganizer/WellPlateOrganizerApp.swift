//
//  WellPlateOrganizerApp.swift
//  WellPlateOrganizer
//
//  Created by Deniz Kecik on 5/7/23.
//

import SwiftUI

@main
struct WellPlateOrganizerApp: App {
    @StateObject var wellPlateReader = CSVReader()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(wellPlateReader).onOpenURL { url in
                wellPlateReader.readFromURL(filePath: url)
            }
        }
    }
}
