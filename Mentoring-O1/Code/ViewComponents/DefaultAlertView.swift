import SwiftUI

struct DefaultAlertView: View {
    var title: String
    var message: String
    var confirmButtonTitle: String
    var cancelButtonTitle: String
    var confirmAction: () -> Void
    var cancelAction: (() -> Void)?

    init(title: String,
         message: String,
         confirmButtonTitle: String? = nil,
         cancelButtonTitle: String? = nil,
         confirmAction: @escaping () -> Void,
         cancelAction: (() -> Void)? = nil) {
        self.title = title
        self.message = message
        self.confirmButtonTitle = confirmButtonTitle ?? "Ok"
        self.cancelButtonTitle = cancelButtonTitle ?? "Cancel"
        self.confirmAction = confirmAction
        self.cancelAction = cancelAction
    }

    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.headline)
                .padding(.top)

            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            HStack(spacing: 20) {
                if let cancelAction = cancelAction {
                    Button(action: {
                        cancelAction()
                    }) {
                        Text(cancelButtonTitle)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                }

                Button(action: {
                    confirmAction()
                }) {
                    Text(confirmButtonTitle)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
        .frame(maxWidth: 300)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}
