import SwiftUI

struct LetterView: View {
    let letter: LetterModel
    var body: some View {
        Text(letter.text)
            .font(.system(size: 15, weight: .semibold))
            .frame(width: 30, height: 30)
            .foregroundColor(Color.white)
            .background(Color.white.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
