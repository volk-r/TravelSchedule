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
    
    @StateObject private var viewModel = StationSelectorViewModel()
    
    var body: some View {
        ZStack {
            AppColorSettings.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            stationList
                .opacity(viewModel.isLoadingError ? 0 : 1)
            
            customPlaceholder(
                placeholder: Text("Station not found"),
                isVisible: viewModel.searchResult.isEmpty
            )
            
            NetworkErrorView(errorType: .noInternetConnection)
                .opacity(viewModel.isLoadingError ? 1 : 0)
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
                Button(action: { selectStation(station) } ) {
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
    
    func selectStation(_ station: String) {
        viewModel.selectStation(station: station, withStationData: &stationData)
        isShowRoot = false
    }
}


final class StationSelectorViewPreview: ObservableObject {
    @State var stationData: String = ""
    @State var city: String = ""
    @State var isShowRoot: Bool = true
}

#Preview {
    let param = StationSelectorViewPreview()
    NavigationStack {
        StationSelectorView(
            stationData: param.$stationData,
            city: param.$city,
            isShowRoot: param.$isShowRoot
        )
    }
}
