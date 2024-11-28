//
//  CitySelectionView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 28.11.2024.
//

import SwiftUI

struct CitySelectionView: View {
    
    // MARK: - Properties
    
    let cities = ["Mосква", "Санкт-Петербург", "Сочи", "Горный воздух", "Краснодар", "Казань", "Омск"]
    @State private var searchText: String = ""
    
    var searchResult: [String] {
        guard !searchText.isEmpty else { return cities }
        return cities.filter { $0.contains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                cityList
                placeholder
            }
        }
        .navigationTitle("City selection")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension CitySelectionView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let rowHeight: CGFloat = 60
    }
    
    // MARK: - cityList
    
    private var cityList: some View {
        List(searchResult, id: \.self) { city in
            HStack {
                Button(
                     action: { selectCity(city) },
                     label: {
                         Text(city)
                             .font(AppConstants.fontRegular17)
                     }
                 )
                Spacer()
                Image(systemName: AppImages.cityListBadge)
            }
            .listRowSeparator(.hidden)
            .frame(height: Constants.rowHeight)
        }
        .listStyle(.plain)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Enter your query")
    }
    
    // MARK: - placeholder
    
    private var placeholder: some View {
        Text("City not found")
            .opacity(searchResult.isEmpty ? 1 : 0)
            .font(AppConstants.fontBold24)
    }
    
    // MARK: - selectCity
    
    func selectCity(_ city: String) {
        print("Tapped -> \(city)")
    }
}

#Preview {
    CitySelectionView()
}