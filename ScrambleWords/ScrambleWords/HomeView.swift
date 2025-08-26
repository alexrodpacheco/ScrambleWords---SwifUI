import SwiftUI

struct HomeView: View {
    @State var guessedLetters: [LetterModel] = []
    @State var showSucess = false
    @State var showFailure = false
    @State var score = 0
    @State var currentQuestionIndex = 0
    
    @State var questions: [QuestionModel] = [
        QuestionModel(image: "orange",
                      answer: "ORANGE",
                      randomLetters: [
                        LetterModel(id: 0, text: "O"),
                        LetterModel(id: 1, text: "N"),
                        LetterModel(id: 2, text: "E"),
                        LetterModel(id: 3, text: "R"),
                        LetterModel(id: 4, text: "G"),
                        LetterModel(id: 5, text: "A")
        ]),
        QuestionModel(image: "banana",
                      answer: "BANANA",
                      randomLetters: [
                        LetterModel(id: 0, text: "B"),
                        LetterModel(id: 1, text: "A"),
                        LetterModel(id: 2, text: "N"),
                        LetterModel(id: 3, text: "A"),
                        LetterModel(id: 4, text: "N"),
                        LetterModel(id: 5, text: "A")
        ]),
        QuestionModel(image: "apple",
                      answer: "APPLE",
                      randomLetters: [
                        LetterModel(id: 0, text: "A"),
                        LetterModel(id: 1, text: "P"),
                        LetterModel(id: 2, text: "P"),
                        LetterModel(id: 3, text: "L"),
                        LetterModel(id: 4, text: "E")
        ])
        
    ]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    VStack {
                        Spacer()
                        Image(questions[currentQuestionIndex].image)
                            .resizable()
                            .frame(width: 100, height: 100)
                        Spacer()
                        HStack {
                            ForEach(Array(guessedLetters.enumerated()), id: \.1) { index, guessedLetter in
                                VStack {
                                    LetterView(letter: guessedLetter)
                                        .onTapGesture {
                                            if let index = guessedLetters.firstIndex(of: guessedLetter) {
                                                guessedLetters.remove(at: index)
                                                questions[currentQuestionIndex].randomLetters[guessedLetter.id].text = guessedLetter.text
                                            }
                                        }
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: 25, height: 2)
                                }
                            }
                        }
                        .padding(.bottom, 20)
                        .opacity(0.3)
                    }
                    .frame(width: proxy.size.width * 0.9, height: proxy.size.width * 0.9)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
                    Text("Score \(score)")
                        .font(.system(size: 15))
                        .foregroundColor(Color.white)
                        .padding(.top)
                    HStack {
                        ForEach(Array(questions[currentQuestionIndex].randomLetters.enumerated()), id: \.1) { index, letter in
                            LetterView(letter: letter)
                                .onTapGesture {
                                    if !letter.text.isEmpty {
                                        guessedLetters.append(letter)
                                        questions[currentQuestionIndex].randomLetters[index].text = ""
                                        if guessedLetters.count == questions[currentQuestionIndex].randomLetters.count {
                                            var guessedAnswer = ""
                                            for guessedLetter in guessedLetters {
                                                guessedAnswer += guessedLetter.text
                                            }
                                            if guessedAnswer == questions[currentQuestionIndex].answer {
                                                showSucess = true
                                                score += 1
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                                    showSucess = false
                                                    if currentQuestionIndex == questions.count - 1 {
                                                        
                                                    } else {
                                                        currentQuestionIndex += 1
                                                    }
                                                })
                                            } else {
                                                showFailure = true
                                                if score <= 0 {
                                                    score = 0
                                                } else {
                                                    score -= 1
                                                }
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                                    showFailure = false
                                                    if currentQuestionIndex == questions.count - 1 {
                                                        
                                                    } else {
                                                        currentQuestionIndex += 1
                                                    }
                                                })
                                            }
                                            guessedLetters.removeAll()
                                        }
                                    }
                                }
                        }
                        .padding(.top)
                    }
                }
                if showSucess {
                    VStack {
                        Image("tick")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                }
                if showFailure {
                    VStack {
                        Image("cross")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                }
            }
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
