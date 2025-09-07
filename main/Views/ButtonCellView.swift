import SwiftUI

struct ButtonCellView: View {
    let button: ButtonType
    let sideSize: CGFloat
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(button.rawValue)
                .font(.system(size: 40))
                .foregroundStyle(.white)
                .frame(width: sideSize, height: sideSize)
                .background(button.color)
                .clipShape(.circle)
        }
    }
}

#Preview {
    ButtonCellView(
        button: .seven,
        sideSize: 80,
        onTap: {}
    )
    .background(.black)
}
