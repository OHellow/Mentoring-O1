import SwiftUI

struct LoginView: View {
    private let kStackViewSpacing: CGFloat = 15
    private let kTextFieldCornerRadius: CGFloat = 5
    private let kLoginButtonCornerRadius: CGFloat = 10
    private let kTextFieldBorderWidth: CGFloat = 1
    private let vStackPadding: EdgeInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)

    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        ZStack {
            VStack(spacing: kStackViewSpacing) {
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: kTextFieldCornerRadius).stroke(Color.gray, lineWidth: 1))

                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: kTextFieldCornerRadius).stroke(Color.gray, lineWidth: 1))

                Button(action: {
                    viewModel.showLoading()
                    viewModel.loginAction()
                }) {
                    Text("Log In")
                        .foregroundColor(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: kLoginButtonCornerRadius).foregroundColor(.blue))
                }
            }
            .padding(vStackPadding)

            if viewModel.isLoading {
                VStack {
                    ProgressView("Logging in...")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: kLoginButtonCornerRadius).foregroundColor(Color.black.opacity(0.3)))
                }
            }
        }
        .alert(isPresented: $viewModel.showingAlert, content: {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let inter = LoginInteractor()
        let router = LoginRouter()
        let model = LoginViewModel(interactor: inter, router: router)
        LoginView(viewModel: model)
    }
}
