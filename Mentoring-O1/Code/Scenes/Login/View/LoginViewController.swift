import UIKit

protocol LoginViewControllerInput: AnyObject {
    func didTapLogin(with email: String, password: String)
}

protocol LoginViewControllerOutput: AnyObject {
    func showUpcomingMoviesScene()
    func showError(error: Error)
    func showLoading()
    func hideLoading()
}

final class LoginViewController: UIViewController, LoadingDisplayable {
    private let kStackViewSpacing: CGFloat = 15
    private let kTextFieldCornerRadius: CGFloat = 5
    private let kLoginButtonCornerRadius: CGFloat = 10
    private let kTextFieldBorderWidth: CGFloat = 1
    private let kScreenWidth = UIScreen.main.bounds.width

    lazy var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = kStackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.layer.cornerRadius = kTextFieldCornerRadius
        textField.layer.borderWidth = kTextFieldBorderWidth
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.heightAnchor.constraint(equalToConstant: 32).isActive = true
        textField.leftView = UIView(frame: CGRect(x: .zero, y: .zero, width: 8, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = kTextFieldCornerRadius
        textField.layer.borderWidth = kTextFieldBorderWidth
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.heightAnchor.constraint(equalToConstant: 32).isActive = true
        textField.leftView = UIView(frame: CGRect(x: .zero, y: .zero, width: 8, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = kLoginButtonCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onLoginButton), for: .touchUpInside)
        return button
    }()

    var loaderView: LoadingViewProtocol = DefaultLoaderView()
    var router: LoginRoutingLogic?
    var interactor: LoginViewControllerInput?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupTextFields()
    }

    private func setupStackView() {
        view.addSubview(loginStackView)
        NSLayoutConstraint.activate([
            loginStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: kScreenWidth * 0.1),
            loginStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -kScreenWidth * 0.1)
        ])
        loginStackView.addArrangedSubview(emailTextField)
        loginStackView.addArrangedSubview(passwordTextField)
        loginStackView.addArrangedSubview(loginButton)
    }

    private func setupTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    @objc
    private func onLoginButton() {
        interactor?.didTapLogin(with: emailTextField.text ?? "",
                                password: passwordTextField.text ?? "")
    }
}

extension LoginViewController: LoginViewControllerOutput {
    func showUpcomingMoviesScene() {
        DispatchQueue.main.async {
            self.router?.showUpcomingScene()
        }
    }

    func showError(error: Error) {
        DispatchQueue.main.async {
            self.router?.showAlert(title: "Error", message: error.localizedDescription)
        }
    }

    func showLoading() {
        showLoader()
    }

    func hideLoading() {
        hideLoader()
    }
}

//MARK: - Text Field Delegate Methods
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
