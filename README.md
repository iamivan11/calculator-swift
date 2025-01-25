# SwiftUI Calculator

A simple, modern calculator app built with **SwiftUI**. It supports common arithmetic operations (addition, subtraction, multiplication, division), along with sign inversion, square root, backspace, and more. This repository contains a straightforward example of **SwiftUI** and the **MVVM** pattern to create a clean, functional interface.

<img src="https://github.com/ivansor0kin/swift-ios-calculator-app/blob/main/demo.png" alt="demo" width="300" />

---

## Features

- **Basic Arithmetic**: Addition, subtraction, multiplication, and division.  
- **Square Root**: Quickly compute the square root of a non-negative number.  
- **Sign Inversion**: Switch between positive and negative values.  
- **Clear / Backspace**: 
  - **AC (All Clear)** resets the calculation to `0`.  
  - **⌫ (Backspace)** removes the last digit or operation symbol.
- **Decimal Support**: Use `.` to handle floating-point numbers.  
- **Error Handling**: Displays `Error` for invalid operations (e.g., division by zero).

---

## Project Structure

| File              | Description                                                                                   |
|-------------------|-----------------------------------------------------------------------------------------------|
| **App.swift**     | Main entry point. Declares the SwiftUI `@main` struct (`calculator`) and launches `CalculatorView`. |
| **ButtonType.swift** | An enum representing all calculator buttons (digits, operators, etc.), plus their display text and colors. |
| **ContentView.swift** (a.k.a. `CalculatorView`) | Holds the main SwiftUI layout. Creates a grid of calculator buttons and displays the current result. |
| **ViewModel.swift** | The MVVM logic. Manages the current `result` and handles operations, sign toggling, clearing, etc. |

---

## How It Works

1. **Display**  
   - A `Text` view shows the current result (`viewModel.result`).  
   - The font size and layout adjust to fit larger numbers.

2. **Button Grid**  
   - A `LazyVGrid` with four columns arranges the calculator buttons.  
   - Each button triggers `viewModel.didTapOnButton`.

3. **ViewModel**  
   - **Numbers**: Appended to the current result (e.g., `"123"`).  
   - **Operations**: Temporarily stored with a space-delimited format like `"12 + "`.  
   - **Square Root**: Immediately calculates `√(currentNumber)` if valid.  
   - **Equality**: Splits the expression into parts (e.g., `12 + 7`) and computes the final result.  
   - **Error Handling**: Sets `result` to `"Error"` for invalid operations.

---

## Requirements

- **Xcode 14+**  
- **iOS 16+**  
- **Swift 5.7+**

*(It may work on older versions, but this is the tested setup.)*
