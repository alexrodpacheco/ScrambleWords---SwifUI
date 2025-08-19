import SwiftUI

struct ContentView: View {
    
    @State var letters: [String] = ["O", "R", "A", "N", "G", "E", ]
    @State var guessedLetters: [String] = []
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    VStack {
                        Spacer()
                        Image("orange")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Spacer()
                        HStack {
                            ForEach(guessedLetters, id: \.self) { guessedLetter in
                                VStack {
                                    LetterView(letter: guessedLetter)
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: 25, height: 2)
                                }
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    .frame(width: proxy.size.width * 0.9, height: proxy.size.width * 0.9)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
                    Text("Score 0")
                        .font(.system(size: 15))
                        .foregroundColor(Color.white)
                        .padding(.top)
                    HStack {
                        ForEach(letters, id: \.self) { letter in
                            LetterView(letter: letter)
                                .onTapGesture {
                                    guessedLetters.append(letter)
                                }
                        }
                    }
                    .padding(.top)
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
