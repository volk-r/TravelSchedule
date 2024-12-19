//
//  CitySelectionView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 28.11.2024.
//

import SwiftUI

struct CitySelectionView: View {
    
    // MARK: - Properties
    
    @Binding var stationData: StationData
    @Binding var isShowRoot: Bool
    
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
            StationSelectorView(
                stationData: $stationData,
                city: $viewModel.citySelected,
                isShowRoot: $isShowRoot
            )
        }
        .navigationTitle("City selection")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $isShowRoot)
        .modifier(.iOS_18_plus_bug_fix)
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
        CitySelectionView(
            stationData: .constant(StationData(stationType: .from)),
            isShowRoot: .constant(true)
        )
    }
}
