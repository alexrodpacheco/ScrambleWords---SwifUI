struct QuestionModel {
    var image: String
    var answer: String
    var randomLetters: [LetterModel]
}

extension QuestionModel {
    static func generateQuestion() -> [QuestionModel] {
        return [
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
    }
}
