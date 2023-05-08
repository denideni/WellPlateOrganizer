//
//  ContentView.swift
//  WellPlateOrganizer
//
//  Created by Deniz Kecik on 5/7/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @EnvironmentObject var wellPlateReader: CSVReader
    let rowTitles = ["A", "B", "C", "D", "E", "F", "G", "H"]
    @State var activeFilter: WellTypes?
    @State var isImporting: Bool = false
    
    var body: some View {
        VStack {
            Picker("Filter", selection: $activeFilter) {
                Text("Select Filter").tag(Optional<WellTypes>(nil))
                ForEach(wellPlateReader.allSamples, id: \.description) { item in
                    Text(item.description).tag(Optional<WellTypes>(item))
                }
            }
            Grid(horizontalSpacing: 5, verticalSpacing: 5) {
                GridRow {
                    ForEach(0..<13) { colNumber in
                        if colNumber == 0 {
                            Color.clear.frame(maxHeight: 1)
                        } else {
                            Text("\(colNumber)")
                        }
                    }
                }
                ForEach(0..<wellPlateReader.wellPlate.endIndex, id: \.self) { rowNumber in
                    GridRow {
                        Text(rowTitles[rowNumber])
                        ForEach(wellPlateReader.wellPlate[rowNumber]) { elem in
                            if elem.type == activeFilter || activeFilter == nil {
                                WellView(currentWell: elem)
                            } else {
                                Circle().foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            Button {
                isImporting.toggle()
            } label: {
                Text("Import File")
            }.fileImporter(isPresented: $isImporting, allowedContentTypes: [UTType.commaSeparatedText]) { result in
                
                switch result {
                case .success(let fileURL):
                    wellPlateReader.readFromURL(filePath: fileURL)
                    print(fileURL)
                case .failure(let error):
                    print(error)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(CSVReader())
    }
}
