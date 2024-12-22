//
//  CarrierView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 27.11.2024.
//

import SwiftUI

struct CarrierView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var routeSelectionListViewModel: RouteSelectionListViewModel
    
    var body: some View {
        ZStack {
            AppColorSettings.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: Constants.defaultSpacing) {
                carrierLogo
                carrierTitle
                carrierPropertyList
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .navigationTitle("Carrier information")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $routeSelectionListViewModel.isCarrierPagePresented)
        .onAppear {
            AnalyticService.trackOpenScreen(screen: .carrier)
        }
    }
}

extension CarrierView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let defaultSpacing: CGFloat = 16
        static let carrierLogoHeight: CGFloat = 104
        static let carrierLogoCornerRadius: CGFloat = 24
        static let rowHeight: CGFloat = 60
        static let propertyTextColor: Color = .blue
    }
    
    // MARK: - carrierLogo
    
    var carrierLogo: some View {
        AsyncImage(
            url: URL(string: routeSelectionListViewModel.carrierForPresentation?.logo ?? ""),
            transaction: Transaction(animation: .easeInOut)
        ) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Image(systemName: AppImages.carrierDefaultLogo)
                        .resizable()
                        .scaledToFit()
                    ProgressView()
                }
            case .success(let image):
                image
                    .resizable()
                    .transition(.scale(scale: 0.1, anchor: .center))
            case .failure:
                Image(systemName: AppImages.carrierDefaultLogo)
                    .resizable()
                    .scaledToFit()
            @unknown default:
                EmptyView()
            }
        }
        .frame(height: Constants.carrierLogoHeight)
        .scaledToFit()
        .clipShape(RoundedRectangle(cornerRadius: Constants.carrierLogoCornerRadius))
    }
    
    // MARK: - carrierTitle
    
    var carrierTitle: some View {
        HStack {
            Text(routeSelectionListViewModel.carrierForPresentation?.title ?? "")
                .font(AppConstants.fontBold24)
            Spacer()
        }
    }
    
    // MARK: - carrierPropertyList
    
    var carrierPropertyList: some View {
        List {
            Group {
                carrierProperty(
                    caption: Text("E-mail"),
                    value: routeSelectionListViewModel.carrierForPresentation?.email ?? ""
                )
                carrierProperty(
                    caption: Text("Phone"),
                    value: routeSelectionListViewModel.carrierForPresentation?.phone ?? ""
                )
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
    }
    
    // MARK: - carrierPropertyValue
    
    func carrierProperty(caption: some View, value: String) -> some View {
        VStack(alignment: .leading) {
            caption
                .font(AppConstants.fontRegular17)
            Text(value)
                .font(AppConstants.fontRegular12)
                .foregroundStyle(Constants.propertyTextColor)
        }
        .frame(height: Constants.rowHeight)
    }
}

#Preview {
    NavigationStack {
        CarrierView()
            .environmentObject(RouteSelectionViewModel())
    }
}
