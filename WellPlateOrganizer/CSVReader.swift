//
//  CSVReader.swift
//  WellPlateOrganizer
//
//  Created by Deniz Kecik on 5/7/23.
//

import Foundation

class CSVReader: ObservableObject {
    @Published var wellPlate: [[WellModel]] = []
    @Published var allSamples: [WellTypes] = []
    private var rows: [String] = []
    
    func readFromURL(filePath: URL) {
        var data = ""
        do {
            let fileData = try Data(contentsOf: filePath)
            if let text = String(data: fileData, encoding: .utf8) {
                data = text
            }
            
        } catch {
            print(error)
            return
        }
        rows = data.components(separatedBy: "\n")
        
        // first row is dedicated for col headers, so get rid
        rows.removeFirst()
        
        parseFile()
    }
    
    func readFromPath(filePath: String) {
        var data = ""
        do {
            data = try String(contentsOfFile: filePath)
        } catch {
            print(error)
            return
        }
        rows = data.components(separatedBy: "\n")
        
        // first row is dedicated for col headers, so get rid
        rows.removeFirst()
        
        parseFile()
    }
    
    func parseFile() {
        var flatListWells: [WellModel] = [WellModel]()
        
        for row in rows {
            let columns = row.components(separatedBy: ",")
            let coordinate = columns[0]
            let sampleId = columns[1].trimmingCharacters(in: .whitespacesAndNewlines)
            let wellType = WellTypes(sampleId: sampleId)
            if !allSamples.contains(wellType)  {
                allSamples.append(wellType)
            }
            
            let currentWell = WellModel(coordinate: coordinate, type: wellType)
            
            flatListWells.append(currentWell)
        }
        
        flatListWells.sort()
        allSamples.sort()
        
        var currentRow = [WellModel]()
        for well in flatListWells {
            currentRow.append(well)
            if currentRow.count == 12 {
                wellPlate.append(currentRow)
                currentRow = []
            }
        }
    }
    
    init() {
//        guard let filePath = Bundle.main.path(forResource: "plate_layout", ofType: "csv") else {
//            return
//        }
//        readFromPath(filePath: filePath)
    }
}
