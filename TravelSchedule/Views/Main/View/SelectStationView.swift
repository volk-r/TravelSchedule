//
//  SelectStationView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 24.11.2024.
//

import SwiftUI

struct SelectStationView: View {
    
    // MARK: - Properties

    @StateObject private var viewModel: SelectStationViewModel = SelectStationViewModel()    
    
    var body: some View {
        ZStack {
            Constants.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            if viewModel.isLoadingError {
                VStack {
                    NetworkErrorView(errorType: .noInternetConnection)
                    Divider()
                }
            } else {
                VStack(spacing: Constants.findButtonPaddingTop) {
                    StoriesListView(
                        stories: viewModel.stories,
                        showStory: $viewModel.showStory,
                        selectedStory: $viewModel.storyToShowIndex
                    )
                    .padding(.leading)
                    
                    ZStack {
                        selectStationViewBackgroundView
                        selectStationView
                    }
                    .padding(.top, Constants.stationBoxPaddingTop)
                    
                    if viewModel.isStationsSelected() {
                        findButton
                    }
                    
                    Spacer()
                }
            }
        }
        .overlay{
            if viewModel.showStory {
                StoriesView(
                    stories: $viewModel.stories,
                    showStory: $viewModel.showStory,
                    currentStoryIndex: $viewModel.storyToShowIndex
                )
                .transition(Constants.openStoryAnimation)
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
        .navigationDestination(isPresented: $viewModel.isFindRoutesPresented) {
            RouteSelectionListView(isShowRoot: $viewModel.isFindRoutesPresented)
        }
    }
}

extension SelectStationView {
    
    // MARK: - backgroundView
    
    private var selectStationViewBackgroundView: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(Constants.viewBackgroundColor)
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
            Text(viewModel.fromStation.description)
                .foregroundColor(
                    (viewModel.fromStation.station?.isEmpty != nil)
                    ? Constants.stationBoxFontColor
                    : Constants.stationBoxSecondaryFontColor
                )
                .lineLimit(Constants.stationLineLimit)
        }
    }
    
    // MARK: - toStation
    
    private var toStation: some View {
        Button(action: viewModel.selectToStation) {
            Text(viewModel.toStation.description)
                .foregroundColor(
                    (viewModel.toStation.station?.isEmpty != nil)
                    ? Constants.stationBoxFontColor
                    : Constants.stationBoxSecondaryFontColor
                )
                .lineLimit(Constants.stationLineLimit)
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
        .tint(Constants.viewBackgroundColor)
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
        .background(Constants.viewBackgroundColor)
        .foregroundStyle(Constants.findButtonFontColor)
        .clipShape(RoundedRectangle(cornerRadius: AppConstants.defaultCornerRadius))
        .opacity(viewModel.fromStation.description.isEmpty || viewModel.toStation.description.isEmpty ? 0 : 1)
    }
}

extension SelectStationView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let backgroundColor: Color = AppColorSettings.backgroundColor
        static let viewBackgroundColor: Color = AppColorSettings.backgroundButtonColor
        
        static let stationBoxPaddingTop: CGFloat = 20
        static let stationBoxHeight: CGFloat = 128
        static let stationBoxWidth: CGFloat = 343
        static let stationBoxInternalSpacing: CGFloat = 0
        static let cornerRadius: CGFloat = 20
        static let stationBoxFontColor: Color = .black
        static let stationBoxSecondaryFontColor: Color = AppColorSettings.secondaryFontColor
        static let stationLineLimit: Int = 1
        
        static let changeStationsButtonSize: CGFloat = 36
        static let changeStationsButtonCornerRadius: CGFloat = 40
        static let changeStationsButtonColor: Color = .white
        
        static let findButtonPaddingTop: CGFloat = 20
        static let findButtonWidth: CGFloat = 150
        static let findButtonHeight: CGFloat = 60
        static let findButtonFontColor: Color = .white
        
        static let openStoryAnimation: AnyTransition = .scale(scale: 0.1, anchor: .topLeading).combined(with: .offset(x: 20, y: 40))
    }
}

#Preview {
    NavigationStack {
        SelectStationView()
    }
}
