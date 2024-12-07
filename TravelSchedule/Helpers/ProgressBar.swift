//
//  ProgressBar.swift
//  TravelSchedule
//
//  Created by Roman Romanov on 06.12.2024.
//

import SwiftUI

extension CGFloat {
    static let progressBarCornerRadius: CGFloat = 6
    static let progressBarHeight: CGFloat = 6
}

struct ProgressBar: View {
    
    // MARK: - Properties
    
    let numberOfSections: Int
    let progress: CGFloat
    
    var body: some View {
        // Используем `GeometryReader` для получения размеров экрана
        GeometryReader { geometry in
            // Используем `ZStack` для отображения белой подложки прогресс бара и синей полоски прогресса
            ZStack(alignment: .leading) {
                // Белая подложка прогресс бара
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(width: geometry.size.width, height: .progressBarHeight)
                    .foregroundColor(Constants.progressBarBackground)
                
                // Синяя полоска текущего прогресса
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(
                        // Ширина прогресса зависит от текущего прогресса.
                        // Используем `min` на случай, если `progress` > 1
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: .progressBarHeight
                    )
                    .foregroundColor(Constants.progressBarFill)
            }
            // Добавляем маску
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
        }
    }
}

extension ProgressBar {
    
    // MARK: - Constants
    
    private enum Constants {
        static let progressBarFill: Color = Color(UIColor(hexString: "#3772E7"))
        static let progressBarBackground: Color = .white
    }
}

// MARK: - MaskView

private struct MaskView: View {
    let numberOfSections: Int
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                maskFragmentView
            }
        }
    }
}

extension MaskView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cornerRadius: CGFloat = 3
        static let height: CGFloat = 6
        static let color: Color = .white
    }
    
    // MARK: - maskFragmentView
    
    private var maskFragmentView: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundStyle(Constants.color)
            .frame(height: Constants.height)
    }
}

// MARK: - Preview

#Preview {
    Color(UIColor(hexString: StoryColor.firstPage.rawValue))
        .ignoresSafeArea()
        .overlay(
            ProgressBar(numberOfSections: 5, progress: 0.5)
                .padding()
        )
}

#Preview("MaskView") {
    Color(UIColor(hexString: StoryColor.secondPage.rawValue))
        .ignoresSafeArea()
        .overlay(
            MaskView(numberOfSections: 5)
                .padding()
        )
}
