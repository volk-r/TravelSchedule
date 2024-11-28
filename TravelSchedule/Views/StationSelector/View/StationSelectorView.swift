//
//  StationSelectorView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 28.11.2024.
//

import SwiftUI

struct StationSelectorView: View {
    
    // MARK: - Properties
    
    let stations = ["Киевский вокзал", "Курский вокзал", "Ярославский вокзал", "Белорусский вокзал", "Савеловский вокзал", "Ленинградский вокзал"]
    @State private var searchText: String = ""
    
    var searchResult: [String] {
        guard !searchText.isEmpty else { return stations }
        return stations.filter { $0.contains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                stationList
                
                customPlaceholder(
                    placeholder: Text("Station not found"),
                    isVisible: searchResult.isEmpty
                )
            }
        }
        .navigationTitle("Station selection")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension StationSelectorView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let rowHeight: CGFloat = 60
    }
    
    // MARK: - stationList
    
    private var stationList: some View {
        List(searchResult, id: \.self) { station in
            HStack {
                Button(
                     action: { selectStation(station) },
                     label: {
                         Text(station)
                             .font(AppConstants.fontRegular17)
                     }
                 )
                Spacer()
                Image(systemName: AppImages.cityListBadge)
            }
            .listRowSeparator(.hidden)
            .frame(height: Constants.rowHeight)
        }
        .listStyle(.plain)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Enter your query")
    }
    
    // MARK: - selectCity
    
    func selectStation(_ station: String) {
        print("Tapped -> \(station)")
    }
}

#Preview {
    StationSelectorView()
}
