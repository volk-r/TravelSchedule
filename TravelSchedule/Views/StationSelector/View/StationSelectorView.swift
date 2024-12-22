//
//  StationSelectorView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 28.11.2024.
//

import SwiftUI

struct StationSelectorView: View {
    
    // MARK: - Properties
    
    @Binding var stationData: StationData
    @Binding var city: CityData
    @Binding var isShowRoot: Bool
    
    @StateObject private var viewModel: StationSelectorViewModel = StationSelectorViewModel()
    
    var body: some View {
        ZStack {
            AppColorSettings.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            if let error = viewModel.isError {
                NetworkErrorView(errorType: error)
            }
            else {
                stationList
                
                if viewModel.isLoading {
                    ProgressView()
                }
                
                if !viewModel.isLoading {
                    customPlaceholder(
                        placeholder: Text("Station not found"),
                        isVisible: viewModel.searchResult.isEmpty
                    )
                }
            }
        }
        .onAppear {
            viewModel.setStations(stationsList: city.stations)
        }
        .navigationTitle("Station selection")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $isShowRoot)
        .modifier(.iOS_18_plus_bug_fix)
    }
}

extension StationSelectorView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let rowHeight: CGFloat = 60
    }
    
    // MARK: - stationList
    
    private var stationList: some View {
        List(viewModel.searchResult, id: \.self) { station in
            HStack {
                Button(action: { selectStation(station, from: city) } ) {
                    Text("\(station.description?.description ?? "") \(station.name)".trim())
                        .font(AppConstants.fontRegular17)
                }
                Spacer()
                Image(systemName: AppImages.listBadge)
            }
            .listRowSeparator(.hidden)
            .frame(height: Constants.rowHeight)
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Enter your query"
        )
    }
    
    // MARK: - selectStation
    
    func selectStation(_ station: Station, from: CityData) {
        AnalyticService.trackCloseScreen(screen: .stationSelection)
        
        viewModel.selectStation(station: station, from: city, withStationData: &stationData)
        isShowRoot = false
    }
}

#Preview {
    NavigationStack {
        StationSelectorView(
            stationData: .constant(StationData(stationType: .from)),
            city: .constant(CityData(id: "1", name: "Moscow", stations: [])),
            isShowRoot: .constant(true)
        )
    }
}
