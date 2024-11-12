//
//  ContentView.swift
//  Project_Swift_Sorokin
//
//  Created by Ivan on 3/2/24.


import SwiftUI

struct CalculatorView: View {
    @StateObject var viewModel = ViewModel() // Step 3: add StateObject to the variable that belongs to an ObservableObject class
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let models = ButtonType.allCases
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 16) {
                result
                    .frame(height: calculateResultHeight(screenSize: geometry.size))
//                Spacer()
                
                buttons
                    .padding(.horizontal, 8)
//                    .padding(.bottom, 8)
                
//                Spacer()
            }
            .background(.black)
//            .padding()
        }
    }
    
    var result: some View {
        HStack {
            Spacer()
            
            VStack {
                Spacer()
                Text(viewModel.result)
                    .font(.system(size: 100))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
            }
        }
    }
    
    var buttons: some View {
        GeometryReader { geometry in
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(models, id: \.self) { model in
                    ButtonCellView(
                        button: model,
                        sideSize: calculateButtonWidth(screenWidth: geometry.size.width),
                        viewModel: viewModel
                    )
                }
            }
        }
    }
    
    func calculateResultHeight(screenSize: CGSize) -> CGFloat {
        let buttonSide: CGFloat = calculateButtonWidth(screenWidth: screenSize.width) * 5 + 8 * 4
        let resultHeight: CGFloat = screenSize.height - 16 + 8 - buttonSide
        return resultHeight
    }
    
    func calculateButtonWidth(screenWidth: CGFloat) -> CGFloat {
        let spacingCount = CGFloat(columns.count - 1)
        let allSpacingWidth: CGFloat = 8 * spacingCount
        let allButtonsWidth: CGFloat = screenWidth - allSpacingWidth
        let buttonWidth: CGFloat = allButtonsWidth / CGFloat(columns.count)
        return buttonWidth
    }
    
}

struct ButtonCellView: View {
    let button: ButtonType
    let sideSize: CGFloat
    let viewModel: ViewModel
    
    var body: some View {
        Button(
            action: {
                viewModel.didTapOnButton(button: button)
            },
            label: {
                Text(button.rawValue)
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
                    .frame(width: sideSize, height: sideSize)
                    .background(button.color)
                    .clipShape(.circle)
            })
    }
}

#Preview {
    CalculatorView()
}
