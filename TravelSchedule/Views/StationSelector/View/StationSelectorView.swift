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
    @Binding var city: String
    @Binding var isShowRoot: Bool
    
    @StateObject private var viewModel: StationSelectorViewModel = StationSelectorViewModel()
    
    var body: some View {
        ZStack {
            AppColorSettings.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            if viewModel.isLoadingError {
                NetworkErrorView(errorType: .noInternetConnection)
            }
            else {
                stationList
                
                customPlaceholder(
                    placeholder: Text("Station not found"),
                    isVisible: viewModel.searchResult.isEmpty
                )
            }
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
        List(viewModel.searchResult, id: \.self) { station in
            HStack {
                Button(action: { selectStation(station, from: city) } ) {
                    Text(station)
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
    
    func selectStation(_ station: String, from: String) {
        viewModel.selectStation(station: station, from: city, withStationData: &stationData)
        isShowRoot = false
    }
}

#Preview {
    NavigationStack {
        StationSelectorView(
            stationData: .constant(StationData(stationType: .from)),
            city: .constant(""),
            isShowRoot: .constant(true)
        )
    }
}
