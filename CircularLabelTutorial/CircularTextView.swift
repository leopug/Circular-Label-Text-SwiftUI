import SwiftUI

struct CircularTextView: View {
    @State var letterWidths: [Int:Double] = [:]
    
    @State var title: String
    
    var lettersOffset: [(offset: Int, element: Character)] {
        return Array(title.enumerated())
    }
    var radius: Double
    
    var body: some View {
        ZStack {
            ForEach(lettersOffset, id: \.offset) { index, letter in
                VStack {
                    Text(String(letter))
                        .font(.system(size: 13, design: .monospaced))
                        .foregroundColor(.red)
                        .kerning(5)
                        .background(LetterWidthSize())
                        .onPreferenceChange(WidthLetterPreferenceKey.self, perform: { width in
                            letterWidths[index] = width
                        })
                    Spacer()
                }
                .rotationEffect(fetchAngle(at: index))
            }
        }
        .frame(width: 200, height: 200)
        .rotationEffect(.degrees(214))        
    }
    
    func fetchAngle(at letterPosition: Int) -> Angle {
        let times2pi: (Double) -> Double = { $0 * 2 * .pi }
        
        let circumference = times2pi(radius)
                        
        let finalAngle = times2pi(letterWidths.filter{$0.key <= letterPosition}.map(\.value).reduce(0, +) / circumference)
        
        return .radians(finalAngle)
    }
}


struct WidthLetterPreferenceKey: PreferenceKey {
    static var defaultValue: Double = 0
    static func reduce(value: inout Double, nextValue: () -> Double) {
        value = nextValue()
    }
}

struct LetterWidthSize: View {
    var body: some View {
        GeometryReader { geometry in
            Color
                .clear
                .preference(key: WidthLetterPreferenceKey.self, value: geometry.size.width)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CircularTextView(title: "Let's learn SwiftUI! The most magical Framework!".uppercased(), radius: 125)
    }
}
