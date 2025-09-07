import Foundation
import SwiftUI

class CalculatorViewModel: ObservableObject {
    @Published private var buttonHandler = ButtonHandler()
    
    var result: String {
        buttonHandler.result
    }
    
    func didTapOnButton(_ button: ButtonType) {
        buttonHandler.handleButtonTap(button)
    }
}
