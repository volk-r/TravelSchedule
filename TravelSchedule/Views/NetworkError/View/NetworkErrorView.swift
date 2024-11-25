//
//  NetworkErrorView.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 25.11.2024.
//

import SwiftUI

struct NetworkErrorView: View {
    
    // MARK: - Properties
    
    var errorType: NetworkErrorType
    
    var body: some View {
        ZStack {
            AppColorSettings.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: Constants.defaultSpacing) {
                Image(errorType.model.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: Constants.imageSize,
                        height: Constants.imageSize,
                        alignment: .center
                    )
                    .clipShape(RoundedRectangle(cornerRadius: Constants.imageCornerRadius))
                
                Text(errorType.model.description)
                    .font(AppConstants.fontBold24)
            }
        }
    }
}

extension NetworkErrorView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let defaultSpacing: CGFloat = 16
        
        static let imageSize: CGFloat = 223
        static let imageCornerRadius: CGFloat = 70
    }
}

#Preview("Server error") {
    NetworkErrorView(errorType: .serverError)
}

#Preview("No Internet") {
    NetworkErrorView(errorType: .noInternetConnection)
}
