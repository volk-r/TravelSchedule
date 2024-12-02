//
//  CitySelectionView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 28.11.2024.
//

import SwiftUI

struct CitySelectionView: View {
    
    // MARK: - Properties
    
    @Binding var stationData: String
    @Binding var isShowRoot: Bool
    
    @StateObject private var viewModel = CitySelectionViewModel()
    
    var body: some View {
        ZStack {
            AppColorSettings.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            cityList
                .opacity(viewModel.isLoadingError ? 0 : 1)
            
            customPlaceholder(
                placeholder: Text("City not found"),
                isVisible: viewModel.searchResult.isEmpty
            )
            
            NetworkErrorView(errorType: .noInternetConnection)
                .opacity(viewModel.isLoadingError ? 1 : 0)
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
                    Text(city)
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

final class CitySelectionViewPreview: ObservableObject {
    @State var stationData = ""
    @State var isShowRoot: Bool = true
}

#Preview {
    let params = CitySelectionViewPreview()
    NavigationStack {
        CitySelectionView(
            stationData: params.$stationData,
            isShowRoot: params.$isShowRoot
        )
    }
}
