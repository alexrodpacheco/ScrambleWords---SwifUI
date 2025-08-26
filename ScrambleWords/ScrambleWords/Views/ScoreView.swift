import SwiftUI

struct ScoreView: View {
    let score: Int
    let questionsCount: Int
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Final Score")
                    .foregroundColor(.white)
                    .font(.system(size: 26, weight: .bold))
                Text("Score \(score)/\(questionsCount)")
                    .foregroundColor(.white)
            }
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score: 3, questionsCount: 3)
    }
}
