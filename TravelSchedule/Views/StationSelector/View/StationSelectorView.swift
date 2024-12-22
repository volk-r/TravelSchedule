//
//  StationSelectorView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 28.11.2024.
//

import SwiftUI

struct StationSelectorView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var selectStationViewModel: SelectStationViewModel
    @EnvironmentObject private var citySelectionViewModel: CitySelectionViewModel
    
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
            viewModel.setStations(stationsList: citySelectionViewModel.citySelected.stations)
        }
        .navigationTitle("Station selection")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $selectStationViewModel.isStationPresented)
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
                Button(action: { selectStation(station, from: citySelectionViewModel.citySelected) } ) {
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
        
        viewModel
            .selectStation(
                station: station,
                from: citySelectionViewModel.citySelected,
                withStationData: &selectStationViewModel.selectedStation
            )
        selectStationViewModel.isStationPresented = false
    }
}

#Preview {
    NavigationStack {
        StationSelectorView()
            .environmentObject(SelectStationViewModel())
            .environmentObject(CitySelectionViewModel())
    }
}
