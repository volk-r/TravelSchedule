//
//  CarrierView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 27.11.2024.
//

import SwiftUI

struct CarrierView: View {
    
    // MARK: - Properties
    
    @Binding var isShowRoot: Bool
    
    var carrier: CarrierData?
    
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
        .backButtonToolbarItem(isShowRoot: $isShowRoot)
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
        AsyncImage(url: URL(string: carrier?.logo ?? "")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(height: Constants.carrierLogoHeight)
        .scaledToFit()
        .clipShape(RoundedRectangle(cornerRadius: Constants.carrierLogoCornerRadius))
    }
    
    // MARK: - carrierTitle
    
    var carrierTitle: some View {
        HStack {
            Text(carrier?.title ?? "")
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
                    value: carrier?.email ?? ""
                )
                carrierProperty(
                    caption: Text("Phone"),
                    value: carrier?.phone ?? ""
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
    let carrier = CarrierData(
        code: 0,
        title: "ОАО «РЖД»",
        phone: "+7 (904) 329-27-71",
        logo: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif",
        email: "i.lozgkina@yandex.ru"
    )
    NavigationStack {
        CarrierView(isShowRoot: .constant(true), carrier: carrier)
    }
}
