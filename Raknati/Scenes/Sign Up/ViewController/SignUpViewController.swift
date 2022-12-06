//
//  SignUpViewController.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 27/11/2022.
//

import UIKit

final class SignUpViewController: RaknatiBaseViewController, UITextFieldDelegate, SignUpViewDelegates {
 
    // MARK: - Properties
    
    var presenter: SignUpVCPresenter!

    var displayName: String? {
        return nameTextField.text
    }
    
    var emailAddress: String? {
        return emailAddressTextField.text
    }
    
    var securePassword: String? {
        return passwordTextField.text
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
    
    private lazy var formLabel: UILabel = {
        let baseLabel = UILabel()
        baseLabel.numberOfLines = 0
        baseLabel.disableAutoResizingMask()
        let baseAttributedString = NSMutableAttributedString()
        baseAttributedString.append(
            NSAttributedString(string: "Sign Up?", attributes: [
                .foregroundColor: UIColor.label,
                .font: UIFont.boldFont!
            ])
        )
        baseAttributedString.append(
            NSAttributedString(string: "\nCreate your new account\nAnd join our family!", attributes: [
                .foregroundColor: UIColor.secondaryLabel,
                .font: UIFont.regularFont!
            ])
        )
        baseLabel.textAlignment = .center
        baseLabel.attributedText = baseAttributedString
        return baseLabel
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let baseStackView = UIStackView()
        baseStackView.axis = .vertical
        baseStackView.spacing = 15.00
        baseStackView.disableAutoResizingMask()
        return baseStackView
    }()
    
    private lazy var nameTextField: RaknatiBaseUITextField = {
        let baseTextField = RaknatiBaseUITextField()
        baseTextField.delegate = self
        baseTextField.setPlaceHolder("Name")
        return baseTextField
    }()
    
    private lazy var emailAddressTextField: RaknatiBaseUITextField = {
        let baseTextField = RaknatiBaseUITextField()
        baseTextField.delegate = self
        baseTextField.setPlaceHolder("Email Address")
        baseTextField.setLeftImageView(.emailAddress)
        return baseTextField
    }()
    
    private lazy var passwordTextField: RaknatiBaseUITextField = {
        let baseTextField = RaknatiBaseUITextField()
        baseTextField.delegate = self
        baseTextField.isSecureTextEntry = true
        baseTextField.setPlaceHolder("Password")
        baseTextField.setLeftImageView(.password)
        return baseTextField
    }()
    
    private lazy var signUpButton: RaknatiBaseUIButton = {
        let baseButton = RaknatiBaseUIButton()
        baseButton.setTitle("Sign Up", for: .normal)
        return baseButton
    }()
    
    private func layoutView() {
        setupScrollView()
        setupContainerView()
        setupFormLabel()
        setupTextFieldsStackView()
        setupSignUpButton()
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
    
    private func setupFormLabel() {
        
        self.containerView.addSubview(formLabel)
        let formLabelConstraints = [
            formLabel.topAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.topAnchor, constant: 15),
            formLabel.leadingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            formLabel.trailingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(formLabelConstraints)
        
    }
    
    private func setupTextFieldsStackView() {
        
        self.containerView.addSubview(textFieldsStackView)
        let stackViewConstraints = [
            textFieldsStackView.topAnchor.constraint(equalTo: formLabel.bottomAnchor, constant: 15),
            textFieldsStackView.leadingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            textFieldsStackView.trailingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)
        
        textFieldsStackView.addArrangedSubview(nameTextField)
        textFieldsStackView.addArrangedSubview(emailAddressTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        
    }
    
    private func setupSignUpButton() {
        
        self.containerView.addSubview(signUpButton)
        let signUpButtonConstraints = [
            signUpButton.topAnchor.constraint(greaterThanOrEqualTo: textFieldsStackView.bottomAnchor, constant: 15),
            signUpButton.bottomAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            signUpButton.leadingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            signUpButton.trailingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(signUpButtonConstraints)
        
    }
    
    private func setupKeyboardManager() {
        self.keyboardManager = KeyboardManager(view: self.scrollView)
    }
    
    private func setupButtonTarget() {
        if(self.signUpButton.allTargets.isEmpty) {
            self.signUpButton.addTarget(presenter, action: #selector(presenter.signUpButtonClicked(_:)), for: .touchUpInside)
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
        self.setupButtonTarget()
        self.navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }

    
 // MARK: - UITextField Delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.scrollView.scrollRectToVisible(textField.frame, animated: true)
    }
}
