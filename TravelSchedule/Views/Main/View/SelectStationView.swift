//
//  SelectStationView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 24.11.2024.
//

import SwiftUI

struct SelectStationView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = SelectStationViewModel()
    
    var body: some View {
        ZStack {
            AppColorSettings.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: Constants.findButtonPaddingTop) {
                ZStack {
                    backgroundView
                    selectStationView
                }
                .padding(.top, Constants.stationBoxPaddingTop)
                
                findButton
                
                Spacer()
                Divider()
            }
        }
        .navigationDestination(isPresented: $viewModel.isFromStationPresented) {
            CitySelectionView(
                stationData: $viewModel.fromStation,
                isShowRoot: $viewModel.isFromStationPresented
            )
        }
        .navigationDestination(isPresented: $viewModel.isToStationPresented) {
            CitySelectionView(
                stationData: $viewModel.toStation,
                isShowRoot: $viewModel.isToStationPresented
            )
        }
    }
}

extension SelectStationView {
    
    // MARK: - backgroundView
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(AppColorSettings.backgroundButtonColor)
            .frame(
                idealWidth: Constants.stationBoxWidth,
                maxHeight: Constants.stationBoxHeight
            )
            .padding(.horizontal)
    }
    
    // MARK: - selectStationView
    
    private var selectStationView: some View {
        HStack(spacing: Constants.stationBoxInternalSpacing) {
            VStack{
                List {
                    Section {
                        fromStation
                        toStation
                    }
                    .foregroundColor(Constants.stationBoxFontColor)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Rectangle().fill(Constants.changeStationsButtonColor))
                }
                .listStyle(.inset)
                .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                .padding(.bottom)
            }
            .padding(.top)
            .padding(.leading)
            .frame(
                idealWidth: Constants.stationBoxWidth,
                maxHeight: Constants.stationBoxHeight
            )
            
            changeStationsButton
        }
        .padding(.horizontal)
    }
    
    // MARK: - fromStation
    
    private var fromStation: some View {
        Button(action: viewModel.selectFromStation) {
            TextField(
                "From",
                text: $viewModel.fromStation,
                prompt: Text("From")
                    .foregroundColor(AppColorSettings.secondaryFontColor)
            )
            .lineLimit(1)
            .disabled(true)
        }
    }
    
    // MARK: - toStation
    
    private var toStation: some View {
        Button(action: viewModel.selectToStation) {
            TextField(
                "To",
                text: $viewModel.toStation,
                prompt: Text("To")
                    .foregroundColor(AppColorSettings.secondaryFontColor)
            )
            .lineLimit(1)
            .disabled(true)
        }
        .padding(.bottom)
    }
    
    // MARK: - changeStationsButton
    
    private var changeStationsButton: some View {
        Button(action: viewModel.changeStations) {
            Image(systemName: AppImages.changeStation)
        }
        .frame(
            width: Constants.changeStationsButtonSize,
            height: Constants.changeStationsButtonSize
        )
        .background(Constants.changeStationsButtonColor)
        .accentColor(AppColorSettings.backgroundButtonColor)
        .clipShape(RoundedRectangle(cornerRadius: Constants.changeStationsButtonCornerRadius))
        .padding(.horizontal)
    }
    
    // MARK: - findButton
    
    private var findButton: some View {
        Button(action: viewModel.findRoutes) {
            Text("Find")
                .frame(
                    minWidth: Constants.findButtonWidth,
                    minHeight: Constants.findButtonHeight
                )
                .font(AppConstants.fontBold17)
        }
        .background(AppColorSettings.backgroundButtonColor)
        .foregroundStyle(Constants.findButtonFontColor)
        .clipShape(RoundedRectangle(cornerRadius: AppConstants.defaultCornerRadius))
        .opacity(viewModel.fromStation.isEmpty || viewModel.toStation.isEmpty ? 0 : 1)
    }
}

extension SelectStationView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let stationBoxPaddingTop: CGFloat = 20
        static let stationBoxHeight: CGFloat = 128
        static let stationBoxWidth: CGFloat = 343
        static let stationBoxInternalSpacing: CGFloat = 0
        static let cornerRadius: CGFloat = 20
        static let stationBoxFontColor: Color = .black
        
        static let changeStationsButtonSize: CGFloat = 36
        static let changeStationsButtonCornerRadius: CGFloat = 40
        static let changeStationsButtonColor: Color = .white
        
        static let findButtonPaddingTop: CGFloat = 20
        static let findButtonWidth: CGFloat = 150
        static let findButtonHeight: CGFloat = 60
        static let findButtonFontColor: Color = .white
    }
}

#Preview {
    NavigationStack {    
        SelectStationView()
    }
}
