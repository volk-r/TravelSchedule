//
//  RouteSelectionView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 30.11.2024.
//

import SwiftUI

struct RouteSelectionView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = RouteSelectionViewModel()
    var routeCardData: RouteCardData
    
    @State private var path: [PathItem] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: Constants.defaultHorizontalSpacing) {
                VStack(spacing: 4) {
                    Spacer()
                    HStack(alignment: .center) {
                        carrierLogo
                        carrierAndTransferInfo
                        Spacer()
                        departureDay
                    }
                    
                    schedule
                }
                .padding(.all, Constants.routeCardPadding)
                .frame(idealHeight: Constants.routeCardHeight)
                .background(Constants.routeCardBackgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: Constants.routeCardCornerRadius)
                )
                
                Spacer()
            }
            .frame(maxHeight: Constants.routeCardHeight)
            .foregroundStyle(Constants.routeCardTextColor)
            .padding()
            .onAppear {
                viewModel.setup(data: routeCardData)
            }
            .onTapGesture {
                viewModel.carrierDidSelect()
                path.append(.carrierInfo)
            }
            .navigationDestination(for: PathItem.self) { id in
                if id == .carrierInfo {
                    CarrierView(carrier: routeCardData.carrier)
                }
            }
        }
    }
}

extension RouteSelectionView {
    
    // MARK: - PathItem
    
    private enum PathItem: CaseIterable {
        case carrierInfo
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let defaultHorizontalSpacing: CGFloat = 8
        
        static let routeCardHeight: CGFloat = 104
        static let routeCardCornerRadius: CGFloat = 24
        static let routeCardBackgroundColor: Color = Color(uiColor: UIColor(hexString: "#EEEEEE"))
        static let routeCardTextColor: Color = Color(uiColor: UIColor(hexString: "#1A1B22"))
        
        static let routeCardPadding: CGFloat = 14
        
        static let carrierLogoSize: CGFloat = 38
        static let carrierLogoCornerRadius: CGFloat = 12
        
        static let transferTextColor: Color = Color(uiColor: UIColor(hexString: "#F56B6C"))
        
        static let dateTrailingSpacing: CGFloat = -7
        
        static let timeLineHeight: CGFloat = 48
        static let dividerColor: Color = Color(uiColor: UIColor(hexString: "#AEAFB4"))
        static let dividerHeight: CGFloat = 1
        
        static let durationPadding: CGFloat = 5
    }
    
    // MARK: - carrierLogo
    
    private var carrierLogo: some View {
        AsyncImage(url: URL(string: viewModel.cardData?.carrier.logo ?? "")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .clipShape(RoundedRectangle(cornerRadius: Constants.carrierLogoCornerRadius))
        .frame(width: Constants.carrierLogoSize, height: Constants.carrierLogoSize)
        .scaledToFit()
    }
    
    // MARK: - departureDay
    
    private var departureDay: some View {
        VStack(spacing: 0) {
            Text(viewModel.cardData?.getDepartureDay() ?? "")
                .font(AppConstants.fontRegular12)
                .padding(.trailing, Constants.dateTrailingSpacing)
            Spacer()
        }
        .frame(height: Constants.carrierLogoSize)
    }
    
    // MARK: - carrierAndTransferInfo
    
    private var carrierAndTransferInfo: some View {
        VStack(alignment: .leading) {
            Text(viewModel.cardData?.carrier.title ?? "")
                .font(AppConstants.fontRegular17)
                .lineLimit(1)
            
            if let transferTitle = viewModel.cardData?.getTransferTitle() {
                Text(transferTitle)
                    .foregroundStyle(Constants.transferTextColor)
                    .font(AppConstants.fontRegular12)
            }
        }
    }
    
    // MARK: - schedule
    
    private var schedule: some View {
        HStack {
            Text(viewModel.cardData?.getDepartureTime() ?? "")
                .font(AppConstants.fontRegular17)
            Rectangle()
                .fill(Constants.dividerColor)
                .frame(maxWidth: .infinity, maxHeight: Constants.dividerHeight)
            Text(viewModel.cardData?.getArrivalTime() ?? "")
                .font(AppConstants.fontRegular17)
        }
        .frame(height: Constants.timeLineHeight)
        .overlay(alignment: .center) {
            duration
        }
    }
    
    // MARK: - duration
    
    private var duration: some View {
        Text("\(viewModel.cardData?.getDuration() ?? 0) hour")
            .font(AppConstants.fontRegular12)
            .padding(.horizontal, Constants.durationPadding)
            .background(Constants.routeCardBackgroundColor)
    }
}

#Preview {
    let mockData = RouteCardData(
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
    )
    RouteSelectionView(routeCardData: mockData)
}