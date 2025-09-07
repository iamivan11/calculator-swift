import Foundation

struct CalculatorEngine {
    
    // MARK: - Public Methods
    
    static func performOperation(_ operation: ButtonType, firstNumber: Float, secondNumber: Float) -> String? {
        switch operation {
        case .plus:
            return formatResult(firstNumber + secondNumber)
        case .minus:
            return formatResult(firstNumber - secondNumber)
        case .multiply:
            return formatResult(firstNumber * secondNumber)
        case .divide:
            guard secondNumber != 0 else { return nil }
            return formatResult(firstNumber / secondNumber)
        default:
            return nil
        }
    }
    
    static func performUnaryOperation(_ operation: ButtonType, number: Float) -> String? {
        switch operation {
        case .sr:
            guard number >= 0 else { return nil }
            return formatResult(sqrt(number))
        default:
            return nil
        }
    }
    
    static func parseExpression(_ expression: String) -> (firstNumber: Float, operation: ButtonType, secondNumber: Float)? {
        let components = expression.split(separator: " ")
        
        guard components.count == 3,
              let firstNumber = Float(String(components[0])),
              let operation = ButtonType(rawValue: String(components[1])),
              let secondNumber = Float(String(components[2]).trimmingCharacters(in: CharacterSet(charactersIn: "()"))) else {
            return nil
        }
        
        return (firstNumber, operation, secondNumber)
    }
    
    static func canAddPoint(to expression: String) -> Bool {
        let components = expression.split(separator: " ")
        let lastComponent = components.last ?? ""
        return !String(lastComponent).contains(".")
    }
    
    // MARK: - Private Methods
    
    private static func formatResult(_ number: Float) -> String {
        if number == number.rounded() {
            return "\(Int(number))"
        } else {
            return "\(number)"
        }
    }
}
