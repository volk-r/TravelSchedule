//
//  RouteSelectionListView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 30.11.2024.
//

import SwiftUI

struct RouteSelectionListView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = RouteSelectionListViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                AppColorSettings.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    pageTitle
                    routeList
                        .safeAreaInset(edge: .bottom) {
                            filterButton
                        }
                }
                
                customPlaceholder(
                    placeholder: Text("There are no options"),
                    isVisible: mockData.isEmpty
                )
            }
            .navigationDestination(isPresented: $viewModel.isFiltersPagePresented) {
                FiltersView(isShowRoot: $viewModel.isFiltersPagePresented)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

extension RouteSelectionListView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let filterButtonPaddingTop: CGFloat = 20
        static let filterButtonWidth: CGFloat = 343
        static let filterButtonHeight: CGFloat = 60
        static let filterButtonFontColor: Color = .white
        
        static let filterButtonCircleSize: CGFloat = 8
        static let filterButtonCircleColor: Color = Color(uiColor: UIColor(hexString: "#F56B6C"))
    }
    
    // MARK: - pageTitle
    
    private var pageTitle: some View {
        Text(mockDataPageTitle)
            .font(AppConstants.fontBold24)
            .padding()
    }
    
    // MARK: - routeList
    
    private var routeList: some View {
        List(mockData, id: \.self) { routeCard in
            RouteSelectionView(routeCardData: routeCard)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(
                    top: 2,
                    leading: 8,
                    bottom: 2,
                    trailing: 8
                ))
        }
        .listStyle(.plain)
    }
    
    // MARK: - filterButton
    
    private var filterButton: some View {
        Button(action: viewModel.openFiltersPage) {
            HStack(alignment: .center) {
                Text("Specify time")
                Circle()
                    .fill(Constants.filterButtonCircleColor)
                    .frame(
                        minWidth: Constants.filterButtonCircleSize,
                        idealWidth: Constants.filterButtonCircleSize,
                        maxHeight: Constants.filterButtonCircleSize
                    )
                    .opacity(mockData.isEmpty ? 1 : 0)
            }
            .frame(
                maxWidth: .infinity,
                minHeight: Constants.filterButtonHeight
            )
            .font(AppConstants.fontBold17)
        }
        .background(AppColorSettings.backgroundButtonColor)
        .foregroundStyle(Constants.filterButtonFontColor)
        .clipShape(RoundedRectangle(cornerRadius: AppConstants.defaultCornerRadius))
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        RouteSelectionListView()
    }
}

let mockDataPageTitle: String = "Москва (Ярославский вокзал) → Санкт Петербург (Балтийский вокзал)"
let mockData: [RouteCardData] =
[
    RouteCardData(
        departureDate: Date(),
        arrivalDate: Date().addingTimeInterval(5 * 60 * 16),
        hasTransfers: true,
        transferTitle: "Кострома",
        carrier: CarrierMock(
            title: "РЖД",
            phone: "+7 (904) 329-27-71",
            logo: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif",
            email: "i.lozgkina@yandex.ru"
        )
    ),
    RouteCardData(
        departureDate: Date().addingTimeInterval(3 * 60 * 3 + 15),
        arrivalDate: Date().addingTimeInterval(5 * 60 * 60),
        hasTransfers: false,
        transferTitle: nil,
        carrier: CarrierMock(
            title: "Урал Логистика",
            phone: "+7 (904) 329-27-71",
            logo: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif",
            email: "i.lozgkina@ural.ru"
        )
    ),
    RouteCardData(
        departureDate: Date().addingTimeInterval(3 * 60 * 3 + 15),
        arrivalDate: Date().addingTimeInterval(6 * 60 * 60),
        hasTransfers: false,
        transferTitle: nil,
        carrier: CarrierMock(
            title: "ФГК",
            phone: "+7 (904) 329-27-71",
            logo: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif",
            email: "i.lozgkina@fgk.ru"
        )
    )
]
