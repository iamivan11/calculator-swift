import Foundation

class ButtonHandler: ObservableObject {
    @Published var result = "0"
    
    // MARK: - Public Methods
    
    func handleButtonTap(_ button: ButtonType) {
        switch button {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            handleNumberTap(button)
        case .plus, .minus, .divide, .multiply, .sr:
            handleOperationTap(button)
        case .equal:
            handleEqualityTap()
        case .point:
            handlePointTap()
        case .removeAll:
            handleRemoveAllTap()
        case .removeLast:
            handleRemoveLastTap()
        case .changesign:
            handleChangeSignTap()
        }
    }
    
    // MARK: - Private Methods
    
    private func handleNumberTap(_ button: ButtonType) {
        if result == "0" || result == "Error" {
            result = button.rawValue
        } else if result == "-0" {
            result = "-\(button.rawValue)"
        } else {
            result += button.rawValue
        }
    }
    
    private func handleOperationTap(_ button: ButtonType) {
        if result != "0" {
            result += " \(button.rawValue) "
        }
        
        let components = result.split(separator: " ")
        
        guard components.count >= 2,
              let firstNumber = Float(String(components[0])),
              let operation = ButtonType(rawValue: String(components[1])) else {
            result = "Error"
            return
        }
        
        if operation == .sr {
            if let result = CalculatorEngine.performUnaryOperation(operation, number: firstNumber) {
                self.result = result
            } else {
                result = "Error"
            }
        }
    }
    
    private func handleEqualityTap() {
        guard let (firstNumber, operation, secondNumber) = CalculatorEngine.parseExpression(result) else {
            result = "Error"
            return
        }
        
        if let calculationResult = CalculatorEngine.performOperation(operation, firstNumber: firstNumber, secondNumber: secondNumber) {
            result = calculationResult
        } else {
            result = "Error"
        }
    }
    
    private func handlePointTap() {
        let components = result.split(separator: " ")
        let componentsCount = components.count
        let pointMark = ButtonType.point.rawValue
        
        if componentsCount == 1 {
            addPointIfNeeded(to: String(components[0]))
        } else if componentsCount == 2 {
            result += "0\(pointMark)"
        } else if componentsCount == 3 {
            addPointIfNeeded(to: String(components[2]))
        } else {
            result = "Error"
        }
        
        func addPointIfNeeded(to number: String) {
            if CalculatorEngine.canAddPoint(to: number) {
                result += pointMark
            }
        }
    }
    
    private func handleRemoveAllTap() {
        result = "0"
    }
    
    private func handleRemoveLastTap() {
        guard result != "Error" else { return }
        
        if result.hasSuffix(" ") {
            result.removeLast(3)
        } else {
            if result.count > 2 {
                result = String(result.dropLast())
            } else if result.first != "-" && result.count == 2 {
                result = String(result.dropLast())
            } else {
                result = "0"
            }
        }
    }
    
    private func handleChangeSignTap() {
        guard result != "Error" else { return }
        
        let components = result.split(separator: " ")
        let componentsCount = components.count
        
        switch componentsCount {
        case 1:
            toggleSign(for: String(components[0]))
        case 2:
            // Do nothing for incomplete expressions
            break
        case 3:
            toggleSignForLastComponent(components)
        default:
            result = "Error"
        }
    }
    
    private func toggleSign(for number: String) {
        if number.hasPrefix("-") {
            result = String(number.dropFirst())
        } else {
            result = "-\(number)"
        }
    }
    
    private func toggleSignForLastComponent(_ components: [Substring]) {
        let lastComponent = String(components[2])
        if lastComponent.hasPrefix("(") {
            // Remove parentheses
            result = "\(components[0]) \(components[1]) \(lastComponent.trimmingCharacters(in: CharacterSet(charactersIn: "()")))"
        } else {
            // Add parentheses with negative sign
            result = "\(components[0]) \(components[1]) (-\(lastComponent))"
        }
    }
}
