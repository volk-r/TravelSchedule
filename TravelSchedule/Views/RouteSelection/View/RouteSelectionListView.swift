//
//  RouteSelectionListView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 30.11.2024.
//

import SwiftUI

struct RouteSelectionListView: View {
    
    // MARK: - Properties
    
    @Binding var isShowRoot: Bool
    var routeData: RouteData
    
    @StateObject private var viewModel: RouteSelectionListViewModel = RouteSelectionListViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                AppColorSettings.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                if let error = viewModel.isError {
                    NetworkErrorView(errorType: error)
                } else {
                    VStack {
                        pageTitle
                        routeList
                            .safeAreaInset(edge: .bottom) {
                                filterButton
                            }
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                    }
                    
                    if !viewModel.isLoading {
                        customPlaceholder(
                            placeholder: Text("There are no options"),
                            isVisible: viewModel.allRoutes.isEmpty
                        )
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.isFiltersPagePresented) {
                FiltersView(isShowRoot: $viewModel.isFiltersPagePresented)
            }
        }
        .task {
            await viewModel.fetchRoutesAlong(way: routeData)
        }
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $isShowRoot)
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
        Text(verbatim: viewModel.getPageTitleFor(routes: routeData))
            .font(AppConstants.fontBold24)
            .padding(.horizontal)
            .padding(.top)
    }
    
    // MARK: - routeList
    
    private var routeList: some View {
        List(viewModel.allRoutes) { routeCard in
            RouteSelectionView(routeCardData: routeCard)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .listRowInsets(.init(.zero))
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
                    .opacity(viewModel.allRoutes.isEmpty ? 1 : 0)
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
        RouteSelectionListView(
            isShowRoot: .constant(false),
            routeData: RouteData(
                fromStation: StationData(
                    stationType: .from,
                    city: "Москва",
                    station: nil
                ),
                toStation: StationData(
                    stationType: .to,
                    city: "Питер",
                    station: nil
                )
            )
        )
    }
}

// TODO: remove it in the future

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
