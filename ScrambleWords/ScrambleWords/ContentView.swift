import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    VStack {
                        Image("orange")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    .frame(width: proxy.size.width * 0.9, height: proxy.size.width * 0.9)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
                    Text("Score 0")
                        .font(.system(size: 15))
                        .foregroundColor(Color.white)
                        .padding(.top)
                    HStack {
                        LetterView(letter: "A")
                            .padding(.top)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LetterView: View {
    let letter: String
    var body: some View {
        Text(letter)
            .font(.system(size: 15, weight: .semibold))
            .frame(width: 30, height: 30)
            .foregroundColor(Color.white)
            .background(Color.white.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
