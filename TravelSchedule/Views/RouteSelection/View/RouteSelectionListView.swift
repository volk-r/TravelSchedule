//
//  RouteSelectionListView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 30.11.2024.
//

import SwiftUI

struct RouteSelectionListView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                AppColorSettings.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
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
        }
//        .navigationTitle()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RouteSelectionListView()
}

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
