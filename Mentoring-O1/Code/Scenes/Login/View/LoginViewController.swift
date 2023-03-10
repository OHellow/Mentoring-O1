import UIKit

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

    private let viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupTextFields()
        setupBindables()
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

    private func setupBindables() {
        viewModel.error.bind { [weak self] error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.customMessage)
                }
            }
        }
        viewModel.startLoading.bind { [weak self] startLoading in
            guard let self else { return }
            startLoading ? self.showLoader() : self.hideLoader()
        }
    }

    @objc
    private func onLoginButton() {
        viewModel.updateCredentials(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        viewModel.requestToken { [weak self] in
            DispatchQueue.main.async {
                self?.navigateToUpcomingScene()
            }
        }
    }

    private func navigateToUpcomingScene() {
        let viewController = ScreenFabric.makeUpcomingScene()
        navigationController?.setViewControllers([viewController], animated: true)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
