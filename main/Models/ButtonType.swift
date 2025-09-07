import Foundation
import SwiftUI

enum ButtonType: String, CaseIterable {
    // Clear operations
    case removeAll = "AC"
    case changesign = "+/-"
    case removeLast = "⌫"
    
    // Mathematical operations
    case sr = "√"
    case divide = "÷"
    case multiply = "×"
    case minus = "−"
    case plus = "+"
    case equal = "="
    
    // Numbers
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case point = "."
    
    // MARK: - Computed Properties
    
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
    
    var isNumber: Bool {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return true
        default:
            return false
        }
    }
    
    var isOperation: Bool {
        switch self {
        case .plus, .minus, .divide, .multiply, .sr:
            return true
        default:
            return false
        }
    }
    
    var isClearOperation: Bool {
        switch self {
        case .removeAll, .changesign, .removeLast:
            return true
        default:
            return false
        }
    }
}
