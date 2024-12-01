//
//  StationSelectorView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 28.11.2024.
//

import SwiftUI

struct StationSelectorView: View {
    
    // MARK: - Properties
    
    @Binding var stationData: String
    @Binding var city: String
    @Binding var isShowRoot: Bool
    
    let stations = ["Киевский вокзал", "Курский вокзал", "Ярославский вокзал", "Белорусский вокзал", "Савеловский вокзал", "Ленинградский вокзал"]
    @State private var searchText: String = ""
    
    var searchResult: [String] {
        guard !searchText.isEmpty else { return stations }
        return stations.filter { $0.contains(searchText) }
    }
    
    var body: some View {
        ZStack {
            AppColorSettings.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            stationList
            
            customPlaceholder(
                placeholder: Text("Station not found"),
                isVisible: searchResult.isEmpty
            )
        }
        .navigationTitle("Station selection")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $isShowRoot)
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
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Enter your query")
    }
    
    // MARK: - selectCity
    
    func selectStation(_ station: String) {
        print("Tapped -> \(station)")
    }
}


final class StationSelectorViewPreview: ObservableObject {
    @State var stationData: String = ""
    @State var city: String = ""
    @State var isShowRoot: Bool = true
}

#Preview {
    let param = StationSelectorViewPreview()
    StationSelectorView(
        stationData: param.$stationData,
        city: param.$city,
        isShowRoot: param.$isShowRoot
    )
}
