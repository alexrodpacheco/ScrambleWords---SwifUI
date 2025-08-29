import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @State var guessedLetters: [LetterModel] = []
    @State var showSucess = false
    @State var showFailure = false
    @State var showFinalScore = false
    @State var score = 0
    @State var currentQuestionIndex = 0
    @State var questions = QuestionModel.generateQuestion()
    
    // MARK: - View Builders
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
                                            removeGuessedLetter(guessedLetter)
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
                                    handleLetterSelection(letter: letter, index: index)
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
        .sheet(isPresented: $showFinalScore, onDismiss: {
            questions = QuestionModel.generateQuestion()
            currentQuestionIndex = 0
            score = 0
        }, content: {
            ScoreView(score: score, questionsCount: questions.count)
        })
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}

private extension HomeView {
    // MARK: - Logic Functions
    
    func handleLetterSelection(letter: LetterModel, index: Int) {
        if !letter.text.isEmpty {
            guessedLetters.append(letter)
            questions[currentQuestionIndex].randomLetters[index].text = ""
            checkAnswer()
        }
    }
    
    func removeGuessedLetter(_ guessedLetter: LetterModel) {
        if let index = guessedLetters.firstIndex(of: guessedLetter) {
            guessedLetters.remove(at: index)
            questions[currentQuestionIndex].randomLetters[guessedLetter.id].text = guessedLetter.text
        }
    }
    
    func checkAnswer() {
        if guessedLetters.count == questions[currentQuestionIndex].randomLetters.count {
            var guessedAnswer = ""
            for guessedLetter in guessedLetters {
                guessedAnswer += guessedLetter.text
            }
            if guessedAnswer == questions[currentQuestionIndex].answer {
                showSucess = true
                score += 1
                proceedToNextQUestion(withDelay: true)
            } else {
                showFailure = true
                if score <= 0 {
                    score = 0
                } else {
                    score -= 1
                }
                proceedToNextQUestion(withDelay: true)
            }
            guessedLetters.removeAll()
        }
    }
    
    func proceedToNextQUestion(withDelay: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            showSucess = false
            showFailure = false
            if currentQuestionIndex == questions.count - 1 {
                showFinalScore = true
                
            } else {
                currentQuestionIndex += 1
            }
        })
    }
}
