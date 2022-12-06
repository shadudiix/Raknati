//
//  SignInViewController.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 27/11/2022.
//

import UIKit

final class SignInViewController: RaknatiBaseViewController, SignInViewDelegates, UITextFieldDelegate {
    
    // MARK: - Properties

    var presenter: SignInVCPresenter!
    
    var emailAddress: String? {
        return self.emailAddressTextField.text
    }
    
    var securePassword: String? {
        return self.securePasswordTextField.text
    }
    
    private var keyboardManager: KeyboardManager!

    // MARK: - UI Components
    
    private lazy var scrollView: UIScrollView = {
        let baseScrollView = UIScrollView()
        baseScrollView.disableAutoResizingMask()
        return baseScrollView
    }()
    
    private lazy var containerView: RaknatiBaseUIView = {
        let baseView = RaknatiBaseUIView()
        return baseView
    }()
    
    private lazy var formImage: UIImageView = {
        let baseImageView = UIImageView()
        baseImageView.contentMode = .scaleAspectFit
        baseImageView.image = UIImage(named: UIImage.baseImagesNames.baseLogo.rawValue)
        baseImageView.disableAutoResizingMask()
        return baseImageView
    }()
    
    private lazy var formLabel: UILabel = {
        let baseLabel = UILabel()
        let baseAttributedText = NSMutableAttributedString()
        baseAttributedText.append(
            NSAttributedString(string: "Welcome Back!\n", attributes: [
                .foregroundColor: UIColor.label,
                .font: UIFont.boldFont!
            ]
        ))
        baseAttributedText.append(
            NSAttributedString(string: "Sign in to your account.\n", attributes: [
                .foregroundColor: UIColor.secondaryLabel,
                .font: UIFont.regularFont!
            ]
        ))
        baseLabel.attributedText = baseAttributedText
        baseLabel.numberOfLines = 0
        baseLabel.textAlignment = .center
        baseLabel.disableAutoResizingMask()
        return baseLabel
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let baseStackView = UIStackView()
        baseStackView.disableAutoResizingMask()
        baseStackView.spacing = 15.00
        baseStackView.axis = .vertical
        return baseStackView
    }()
    
    private lazy var emailAddressTextField: RaknatiBaseUITextField = {
        let baseTextField = RaknatiBaseUITextField()
        baseTextField.delegate = self
        baseTextField.keyboardType = .emailAddress
        baseTextField.setPlaceHolder("Email Address")
        baseTextField.setLeftImageView(.emailAddress)
        return baseTextField
    }()
    
    private lazy var securePasswordTextField: RaknatiBaseUITextField = {
        let baseTextField = RaknatiBaseUITextField()
        baseTextField.delegate = self
        baseTextField.keyboardType = .asciiCapable
        baseTextField.isSecureTextEntry = true
        baseTextField.setPlaceHolder("Password")
        baseTextField.setLeftImageView(.password)
        return baseTextField
    }()
    
    private lazy var resetPasswordLabel: UILabel = {
        let baseLabel = UILabel()
        baseLabel.disableAutoResizingMask()
        baseLabel.isUserInteractionEnabled = true
        baseLabel.textColor = .secondaryLabel
        baseLabel.font = .regularFont
        baseLabel.text = "Reset Password"
        return baseLabel
    }()
    
    private lazy var signInButton: RaknatiBaseUIButton = {
        let baseButton = RaknatiBaseUIButton()
        baseButton.setTitle("Sign In", for: .normal)
        return baseButton
    }()
    
    private lazy var createAnAccountLabel: UILabel = {
        let baseLabel = UILabel()
        baseLabel.font = .lightFont
        baseLabel.numberOfLines = 0
        baseLabel.isUserInteractionEnabled = true
        baseLabel.textAlignment = .center
        baseLabel.disableAutoResizingMask()
        let baseAttributedText = NSMutableAttributedString()
        baseAttributedText.append(NSAttributedString(string: "Don't have an account? ", attributes:
        [
            .foregroundColor : UIColor.secondaryLabel,
            .font: UIFont.lightFont!
        ]))
        baseAttributedText.append(NSAttributedString(string: "Create one!", attributes:
        [
            .foregroundColor : UIColor.systemYellow.withAlphaComponent(1.5),
            .font: UIFont.lightFont!,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]))
        baseLabel.attributedText = baseAttributedText
        return baseLabel
    }()
    
    private func layoutView() {
        setupScrollView()
        setupContainerView()
        setupFormImage()
        setupFormLabel()
        setupStackView()
        setupResetPassword()
        setupSignInButton()
        setupCreateAnAccountLabel()
    }

    private func setupScrollView() {
    
        self.view.addSubview(scrollView)
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: self.safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeArea.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor)
        ]
        NSLayoutConstraint.activate(scrollViewConstraints)
    }
    
    private func setupContainerView() {
        
        self.scrollView.addSubview(containerView)
        let containerViewConstraints = [
            containerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            containerView.heightAnchor.constraint(greaterThanOrEqualTo: self.scrollView.heightAnchor)
        ]
        NSLayoutConstraint.activate(containerViewConstraints)
        
    }
    
    private func setupFormImage() {
        
        self.containerView.addSubview(formImage)
        let formImageConstraints = [
            formImage.topAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.topAnchor, constant: 35),
            formImage.leadingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            formImage.trailingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(formImageConstraints)
        
    }
    
    private func setupFormLabel() {
        
        self.containerView.addSubview(formLabel)
        let formLabelConstraints = [
            formLabel.topAnchor.constraint(equalTo: self.formImage.bottomAnchor, constant: 20),
            formLabel.leadingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            formLabel.trailingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(formLabelConstraints)
    }
    
    private func setupStackView() {
        
        self.containerView.addSubview(textFieldsStackView)
        let stackViewConstraints = [
            textFieldsStackView.topAnchor.constraint(equalTo: formLabel.bottomAnchor, constant: 20),
            textFieldsStackView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            textFieldsStackView.leadingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            textFieldsStackView.trailingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)
        
        textFieldsStackView.addArrangedSubview(emailAddressTextField)
        textFieldsStackView.addArrangedSubview(securePasswordTextField)
        
    }
    
    private func setupResetPassword() {
        
        self.containerView.addSubview(resetPasswordLabel)
        let resetPasswordLabelConstraints = [
            resetPasswordLabel.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 15),
            resetPasswordLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.containerView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            resetPasswordLabel.trailingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(resetPasswordLabelConstraints)
        
    }
    
    private func setupSignInButton() {
        
        self.containerView.addSubview(signInButton)
        let signInButtonConstraints = [
            signInButton.topAnchor.constraint(greaterThanOrEqualTo: resetPasswordLabel.bottomAnchor, constant: 15),
            signInButton.leadingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            signInButton.trailingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(signInButtonConstraints)
        
    }
    
    private func setupCreateAnAccountLabel() {
        
        self.containerView.addSubview(createAnAccountLabel)
        let createAnAccountConstraints = [
            createAnAccountLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            createAnAccountLabel.bottomAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            createAnAccountLabel.leadingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            createAnAccountLabel.trailingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(createAnAccountConstraints)
        
    }
    
    private func setupKeyboardManager() {
        self.keyboardManager = KeyboardManager(view: self.scrollView)
    }
    
    private func setupButtonsTargets() {
        if(self.signInButton.allTargets.isEmpty) {
            self.signInButton.addTarget(self.presenter, action: #selector(presenter.signInButtonClicked(_:)), for: .touchUpInside)
        }
        if(self.createAnAccountLabel.gestureRecognizers == nil)  {
            let baseGestureRecognizer = UITapGestureRecognizer(target: self.presenter, action: #selector(presenter.createAccountClicked(_:)))
            self.createAnAccountLabel.addGestureRecognizer(baseGestureRecognizer)
        }
        if(self.resetPasswordLabel.gestureRecognizers == nil) {
            let baseGestureRecognizer = UITapGestureRecognizer(target: self.presenter, action: #selector(presenter.resetPasswordClicked(_:)))
            self.resetPasswordLabel.addGestureRecognizer(baseGestureRecognizer)
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layoutView()
        self.setupKeyboardManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupButtonsTargets()
    }
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }
    

    // MARK: - UITextField Delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.scrollView.scrollRectToVisible(textField.frame, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}
