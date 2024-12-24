//
//  CitySelectionView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 28.11.2024.
//

import SwiftUI

struct CitySelectionView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var selectStationViewModel: SelectStationViewModel
    
    @StateObject private var viewModel: CitySelectionViewModel = CitySelectionViewModel()
    
    var body: some View {
        ZStack {
            AppColorSettings.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            if let error = viewModel.isError {
                NetworkErrorView(errorType: error)
            } else {
                cityList
                
                if viewModel.isLoading {
                    ProgressView()
                }
                
                if !viewModel.isLoading {
                    customPlaceholder(
                        placeholder: Text("City not found"),
                        isVisible: viewModel.searchResult.isEmpty
                    )
                }
            }
        }
        .task {
            await viewModel.fetchCities()
        }
        .navigationDestination(isPresented: $viewModel.isCitySelected) {
            StationSelectorView()
                .environmentObject(viewModel)
                .environmentObject(selectStationViewModel)
        }
        .navigationTitle("City selection")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $selectStationViewModel.isStationPresented)
        .modifier(.iOS18PlusBugFix)
    }
}

extension CitySelectionView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let rowHeight: CGFloat = 60
    }
    
    // MARK: - cityList
    
    private var cityList: some View {
        List(viewModel.searchResult, id: \.self) { city in
            HStack {
                Button(action: { viewModel.selectCity(city) } ) {
                    Text(city.name)
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
}

#Preview {
    NavigationStack {
//        cities = [
//            CityData(id: "1", name: "Москва", stations: []),
//            CityData(id: "2", name: "Санкт-Петербург", stations: [])
//        ]
        CitySelectionView()
            .environmentObject(SelectStationViewModel())
    }
}
