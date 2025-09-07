# Calculator SwiftUI

## Description

A simple, modern calculator app built with **SwiftUI**. It supports common arithmetic operations (addition, subtraction, multiplication, division), along with sign inversion, square root, backspace, and more. This repository contains a straightforward example of **SwiftUI** and the **MVVM** pattern to create a clean, functional interface.

<img src="https://github.com/ivansor0kin/swift-ios-calculator-app/blob/main/demo.png" alt="demo" width="300" />

### Access

The app was not designed to be deployed. However, all of the code is provided and could be run locally, for example, in Xcode Simulator for iOS.

## Features

- **Basic Arithmetic**: Addition, subtraction, multiplication, and division.  
- **Square Root**: Quickly compute the square root of a non-negative number.  
- **Sign Inversion**: Switch between positive and negative values.  
- **Clear / Backspace**: 
  - **AC (All Clear)** resets the calculation to `0`.  
  - **⌫ (Backspace)** removes the last digit or operation symbol.
- **Decimal Support**: Use `.` to handle floating-point numbers.  
- **Error Handling**: Displays `Error` for invalid operations (e.g., division by zero).

## Project Structure

```
calculator-swift/
├── main/                        # Source code directory
│   ├── App.swift                # Main entry point
│   ├── Models/
│   │   └── ButtonType.swift     # Button definitions and styling
│   ├── Views/
│   │   ├── CalculatorView.swift # Main calculator layout
│   │   ├── ButtonCellView.swift # Individual button component
│   │   └── ResultDisplayView.swift # Display component
│   ├── ViewModels/
│   │   ├── CalculatorViewModel.swift # Main view model
│   │   └── ButtonHandler.swift  # Button interaction logic
│   ├── Utils/
│   │   └── CalculatorEngine.swift # Mathematical operations
│   └── Assets.xcassets/         # App icons and assets
├── main.xcodeproj/              # Xcode project file
└── README.md
```

### Architecture

- **Models**: Data structures and enums (`ButtonType`)
- **Views**: SwiftUI components (`CalculatorView`, `ButtonCellView`, `ResultDisplayView`)
- **ViewModels**: Business logic and state management (`CalculatorViewModel`, `ButtonHandler`)
- **Utils**: Pure calculation logic (`CalculatorEngine`)
- **Resources**: App assets and resources

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

## Requirements

- **Xcode 14+**  
- **iOS 16+**  
- **Swift 5.7+**

*(It may work on older versions, but this is the tested setup.)*
