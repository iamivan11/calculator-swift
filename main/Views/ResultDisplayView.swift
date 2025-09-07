import SwiftUI

struct ResultDisplayView: View {
    let result: String
    let height: CGFloat
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Spacer()
                Text(result)
                    .font(.system(size: 100))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
            }
        }
        .frame(height: height)
    }
}

#Preview {
    ResultDisplayView(result: "123.45", height: 200)
        .background(.black)
}
