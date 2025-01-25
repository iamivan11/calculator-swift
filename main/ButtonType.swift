import Foundation
import SwiftUI

enum ButtonType: String, CaseIterable {
    case removeAll = "AC"
    case changesign = "+/-"
    case removeLast = "⌫"
    case sr = "√"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case divide = "÷"
    case four = "4"
    case five = "5"
    case six = "6"
    case multiply = "×"
    case one = "1"
    case two = "2"
    case three = "3"
    case minus = "−"
    case point = "."
    case zero = "0"
    case equal = "="
    case plus = "+"
    
    var color: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .equal, .point:
            return .secondary
        case .plus, .minus, .divide, .multiply, .sr:
            return .blue
        case .changesign, .removeAll, .removeLast:
            return .gray
        }
    }
}
