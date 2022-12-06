//
//  ResetPasswordViewController.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 27/11/2022.
//

import UIKit

final class ResetPasswordViewController: RaknatiBaseViewController, ResetPasswordViewDelegates, UITextFieldDelegate {

    // MARK: - Properties
    
    private var keyboardManager: KeyboardManager!

    var presenter: ResetPasswordVCPresenter!
    
    var emailAddress: String? {
        return emailAddressTextField.text
    }
    
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
        baseImageView.image = UIImage.createBaseImage(.resetPassword, .secondaryLabel)
        baseImageView.contentMode = .scaleAspectFit
        baseImageView.disableAutoResizingMask()
        return baseImageView
    }()
    
    private lazy var formLabel: UILabel = {
        let baseLabel = UILabel()
        baseLabel.numberOfLines = 0
        baseLabel.disableAutoResizingMask()
        let baseAttributedString = NSMutableAttributedString()
        baseAttributedString.append(
            NSAttributedString(string: "Forget your password?", attributes: [
                .foregroundColor: UIColor.label,
                .font: UIFont.semiBoldFont!
            ])
        )
        baseAttributedString.append(
            NSAttributedString(string: "\nDon't worry, happens to the best of us.", attributes: [
                .foregroundColor: UIColor.secondaryLabel,
                .font: UIFont.regularFont!
            ])
        )
        baseLabel.textAlignment = .center
        baseLabel.attributedText = baseAttributedString
        return baseLabel
    }()
    
    private lazy var emailAddressTextField: RaknatiBaseUITextField = {
        let baseTextField = RaknatiBaseUITextField()
        baseTextField.setPlaceHolder("Email Address")
        baseTextField.setLeftImageView(.emailAddress)
        return baseTextField
    }()
    
    private lazy var sendEmailButton: RaknatiBaseUIButton = {
        let baseButton = RaknatiBaseUIButton()
        baseButton.setTitle("Send Email", for: .normal)
        return baseButton
    }()
    
    private func layoutView() {
        setupScrollView()
        setupContainerView()
        setupFormImageView()
        setupFormLabel()
        setupEmailAddressTextField()
        setupSendEmailButton()
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
    
    private func setupFormImageView() {
        
        self.containerView.addSubview(formImage)
        let formImageConstraints = [
            formImage.topAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.topAnchor, constant: 35),
            formImage.leadingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            formImage.trailingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(formImageConstraints)
        
    }
    private func setupFormLabel() {
        
        self.containerView.addSubview(formLabel)
        let formLabelConstraints = [
            formLabel.topAnchor.constraint(equalTo: formImage.bottomAnchor, constant: 15),
            formLabel.leadingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            formLabel.trailingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(formLabelConstraints)
        
    }
    
    private func setupEmailAddressTextField() {
        
        self.containerView.addSubview(emailAddressTextField)
        let emailAddressConstraints = [
            emailAddressTextField.topAnchor.constraint(equalTo: self.formLabel.bottomAnchor, constant: 25),
            emailAddressTextField.centerYAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.centerYAnchor),
            emailAddressTextField.leadingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            emailAddressTextField.trailingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(emailAddressConstraints)
    }
    
    private func setupSendEmailButton() {
        
        self.containerView.addSubview(sendEmailButton)
        let sendEmailButtonConstraints = [
            sendEmailButton.topAnchor.constraint(greaterThanOrEqualTo: emailAddressTextField.bottomAnchor, constant: 25),
            sendEmailButton.bottomAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            sendEmailButton.leadingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            sendEmailButton.trailingAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(sendEmailButtonConstraints)
        
    }
    
    private func setupKeyboardManager() {
        self.keyboardManager = KeyboardManager(view: self.scrollView)
    }
    
    private func setupButtonTarget() {
        if(self.sendEmailButton.allTargets.isEmpty) {
            self.sendEmailButton.addTarget(presenter, action: #selector(presenter.sendEmailClicked(_:)), for: .touchUpInside)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

    
}
