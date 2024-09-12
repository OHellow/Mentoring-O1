import SwiftUI

struct ErrorView: View {

    let errorDescription: String

    var body: some View {
        VStack {
            Text("Error has occured in the application.")
                .font(.headline)
                .padding([.bottom], 10)
            Text(errorDescription)
        }.padding()
    }
}
