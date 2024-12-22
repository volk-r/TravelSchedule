//
//  RouteSelectionListView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 30.11.2024.
//

import SwiftUI

struct RouteSelectionListView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel: RouteSelectionListViewModel = RouteSelectionListViewModel()
    
    @EnvironmentObject var stationModel: SelectStationViewModel
    
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
                FiltersView()
                    .environmentObject(viewModel)
            }
        }
        .task {
            await viewModel.fetchRoutesAlong(way: stationModel.getRouteCardData())
        }
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $stationModel.isFindRoutesPresented)
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
        Text(verbatim: viewModel.getPageTitleFor(routes: stationModel.getRouteCardData()))
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
        // TODO
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
                    .opacity(viewModel.isFiltersSet() ? 1 : 0)
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

// TODO: not working
#Preview {
        RouteSelectionListView()
            .environmentObject(SelectStationViewModel())
//        RouteSelectionListView(
//            isShowRoot: .constant(false),
//            routeData: RouteData(
//                fromStation: StationData(
//                    stationType: .from,
//                    city: "Москва",
//                    station: nil
//                ),
//                toStation: StationData(
//                    stationType: .to,
//                    city: "Питер",
//                    station: nil
//                )
//            )
//        )
}
