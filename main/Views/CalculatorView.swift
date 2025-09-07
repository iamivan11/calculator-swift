import SwiftUI

struct CalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let buttonModels = ButtonType.allCases
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 16) {
                ResultDisplayView(
                    result: viewModel.result,
                    height: calculateResultHeight(screenSize: geometry.size)
                )
                
                buttonsGrid(screenWidth: geometry.size.width)
                    .padding(.horizontal, 8)
            }
            .background(.black)
        }
    }
    
    // MARK: - Private Methods
    
    private func buttonsGrid(screenWidth: CGFloat) -> some View {
        GeometryReader { geometry in
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(buttonModels, id: \.self) { button in
                    ButtonCellView(
                        button: button,
                        sideSize: calculateButtonWidth(screenWidth: geometry.size.width),
                        onTap: {
                            viewModel.didTapOnButton(button)
                        }
                    )
                }
            }
        }
    }
    
    private func calculateResultHeight(screenSize: CGSize) -> CGFloat {
        let buttonSide = calculateButtonWidth(screenWidth: screenSize.width) * 5 + 8 * 4
        return screenSize.height - 16 + 8 - buttonSide
    }
    
    private func calculateButtonWidth(screenWidth: CGFloat) -> CGFloat {
        let spacingCount = CGFloat(columns.count - 1)
        let allSpacingWidth: CGFloat = 8 * spacingCount
        let allButtonsWidth: CGFloat = screenWidth - allSpacingWidth
        return allButtonsWidth / CGFloat(columns.count)
    }
}

#Preview {
    CalculatorView()
}
