import SwiftUI

struct ContentView: View {
    
    @State var letters: [Letter] = [
        Letter(id: 0, text: "O"),
        Letter(id: 1, text: "N"),
        Letter(id: 2, text: "E"),
        Letter(id: 3, text: "R"),
        Letter(id: 4, text: "G"),
        Letter(id: 5, text: "A")
    ]
    @State var guessedLetters: [Letter] = []
    
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
                            ForEach(Array(guessedLetters.enumerated()), id: \.1) { index, guessedLetter in
                                VStack {
                                    LetterView(letter: guessedLetter)
                                        .onTapGesture {
                                            guessedLetters.remove(at: index)
                                            letters[guessedLetter.id].text = guessedLetter.text
                                        }
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
                        ForEach(Array(letters.enumerated()), id: \.1) { index, letter in
                            LetterView(letter: letter)
                                .onTapGesture {
                                    if !letter.text.isEmpty {
                                        guessedLetters.append(letter)
                                        letters[index].text = ""
                                    }
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
    let letter: Letter
    var body: some View {
        Text(letter.text)
            .font(.system(size: 15, weight: .semibold))
            .frame(width: 30, height: 30)
            .foregroundColor(Color.white)
            .background(Color.white.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
