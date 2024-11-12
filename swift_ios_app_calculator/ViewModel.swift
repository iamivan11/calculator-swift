//
//  ViewModel.swift
//  Project_Swift_Sorokin
//
//  Created by Ivan on 3/15/24.
//

import Foundation

class ViewModel: ObservableObject { // Step 1: define a ViewModel as an ObservableObject
    @Published  var result = "0" // Step 2: mark the variable result as Published - signals the need for refresh to the ContentView
    
    func didTapOnButton(button: ButtonType) {
        switch button {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            handleTapOnNumber(button: button)
        case .plus, .minus, .divide, .multiply, .sr:
            handleTapOnOperation(button: button)
        case .equal:
            handleTapOnEquality()
        case .point:
            handleTapOnPoint(button: button)
        case .removeAll:
            handleTapOnRemoveAll()
        case .removeLast:
            handleTapOnRemoveLast()
        case .changesign:
            handleTapOnChangeSign()
        }
    }
    
    func handleTapOnRemoveLast() {
        let firstIndex = result.startIndex
        
        guard
            result != "Error"
        else {
            return
        }
        
        if result.hasSuffix(" ") {
            result.removeLast(3)
        } else {
            if result.count > 2 {
                result = String(result.dropLast())
            } else if result[firstIndex] != "-" && result.count == 2 {
                result = String(result.dropLast())
            } else {
                result = "0"
            }
        }
    }
    
    func handleTapOnRemoveAll() {
        result = "0"
    }
    
    func handleTapOnChangeSign() {
        
        guard
            result != "Error"
        else {
            return
        }
        
        let resultComponents = result.split(separator: " ")
        let componentsCount = resultComponents.count
//        print(resultComponents)
        var firstCharacter1: Character?
        var firstCharacter3: Character?
        if componentsCount == 1 {
            firstCharacter1 = resultComponents[0][resultComponents[0].startIndex]
        } else if componentsCount == 3 {
            firstCharacter3 = resultComponents[2][resultComponents[2].startIndex]
        }
        
        if componentsCount == 1 && firstCharacter1 != "-" {
            result = "-\(String(resultComponents[0]))"
        } else if componentsCount == 1 && firstCharacter1 == "-" {
            result = String(resultComponents[0].dropFirst())
        } else if componentsCount == 2 {
            result = result
        } else if componentsCount == 3 && firstCharacter3 != "(" {
            result = resultComponents[0] + " \(resultComponents[1]) " + "(-\(resultComponents[2]))"
        } else if componentsCount == 3 && firstCharacter3 == "(" {
            result = resultComponents[0] + " \(resultComponents[1]) " + resultComponents[2].trimmingCharacters(in: CharacterSet(charactersIn: "()-"))
        } else {
            result = "Error"
        }
        
    }
    
    func handleTapOnNumber(button: ButtonType) {
        if result == "0" || result == "Error" {
            result = button.rawValue
        } else if result == "-0" {
            result = "-\(button.rawValue)"
        }
        else {
            result += button.rawValue
        }
    }
    
    func handleTapOnOperation(button: ButtonType) {
        if result != "0" {
            result += " \(button.rawValue) "
        }
        
        let resultComponents = result.split(separator: " ")
        
        guard
            resultComponents.count >= 2,
            let firstNumber = Float(resultComponents[0]),
            let operation = ButtonType(rawValue: String(resultComponents[1]))
        else {
            result = "Error"
            return
        }
        
        if operation.rawValue == "√" {
            switch operation {
            case .sr:
                if firstNumber >= 0 {
                    result = String(sqrt(firstNumber))
                } else {
                    result = "Error"
                }
            default:
                result = "Error"
            }
        }
        
    }
    
    func handleTapOnPoint(button: ButtonType) {
        let resultComponents = result.split(separator: " ")
        
        let componentsCount = resultComponents.count
        let pointMark = button.rawValue
        
        if componentsCount == 1 {
            addPointIfNeeded(number: String(resultComponents[0]))
        } else if componentsCount == 2 {
            result += "0\(pointMark)"
        } else if componentsCount == 3 {
            addPointIfNeeded(number: String(resultComponents[2]))
        } else {
            result = "Error"
        }
        
        func addPointIfNeeded(number: String) {
            let doesResultContainPoint = number.contains(".")
            if !doesResultContainPoint {
                result += pointMark
            }
        }
    }
    
    func handleTapOnEquality() {
        let resultComponents = result.split(separator: " ")
        
        guard
            resultComponents.count == 3,
            let firstNumber = Float(resultComponents[0]),
            let operation = ButtonType(rawValue: String(resultComponents[1])),
            let secondNumber = Float(resultComponents[2].trimmingCharacters(in: CharacterSet(charactersIn: "()")))
        else {
            result = "Error"
            return
        }
        
        func formatResult(_ number: Float) -> String {
            if number == number.rounded() {
                return "\(Int(number))"
            } else {
                return "\(number)"
            }
        }

        switch operation {
        case .divide where secondNumber != 0:
            let divisionResult = firstNumber / secondNumber
            result = formatResult(divisionResult)
        case .multiply:
            let multiplicationResult = firstNumber * secondNumber
            result = formatResult(multiplicationResult)
        case .minus:
            let subtractionResult = firstNumber - secondNumber
            result = formatResult(subtractionResult)
        case .plus:
            let additionResult = firstNumber + secondNumber
            result = formatResult(additionResult)
        default:
            result = "Error"
        }

    }
}
