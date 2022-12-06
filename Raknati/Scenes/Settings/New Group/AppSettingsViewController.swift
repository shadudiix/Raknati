//
//  AppSettingsViewController.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 29/11/2022.
//

import UIKit

final class AppSettingsViewController: RaknatiBaseViewController, ِAppSettingsVCDelegates {
    
    // MARK: - Properties

    var presenter: AppSettingsVCPresenter!
    
    // MARK: - UI Components
    
    private lazy var profileSectionView: RaknatiBaseSectionView = {
        let baseSectionView = RaknatiBaseSectionView(labelMessage: "User Profile")
        return baseSectionView
    }()
    
    private lazy var profilePictureImageView: UIImageView = {
        let baseImageView = UIImageView()
        baseImageView.image = UIImage.createBaseImage(.person, .label)
        baseImageView.layer.borderColor = UIColor.systemYellow.cgColor
        baseImageView.layer.borderWidth = 3.00
        baseImageView.layer.cornerRadius = 24
        baseImageView.disableAutoResizingMask()
        return baseImageView
    }()
    
    private lazy var profileNameLabel: UILabel = {
        let baseLabel = UILabel()
        baseLabel.font = .semiBoldFont
        baseLabel.disableAutoResizingMask()
        baseLabel.setContentHuggingPriority(.required, for: .horizontal)
        return baseLabel
    }()
    
    private lazy var profileIsEmailVerifiedLabel: UILabel = {
        let baseLabel = UILabel()
        baseLabel.font = .regularFont
        baseLabel.textColor = .secondaryLabel
        baseLabel.disableAutoResizingMask()
        return baseLabel
    }()
    
    private lazy var settingsSectionView: RaknatiBaseSectionView = {
        let baseSectionView = RaknatiBaseSectionView(labelMessage: "Settings")
        return baseSectionView
    }()
    
    private lazy var darkModeCell: RaknatiBaseSettingCell = {
        let baseCell = RaknatiBaseSettingCell()
        baseCell.setImage(.darkMode)
        baseCell.setTitle("Dark Mode")
        return baseCell
    }()
        
    private lazy var signOutButton: RaknatiBaseUIButton = {
        let baseButton = RaknatiBaseUIButton()
        baseButton.setTitle("Sign out", for: .normal)
        return baseButton
    }()

    private func setupProfileSection() {
        
        self.view.addSubview(profileSectionView)
        let profileSectionConstraints = [
            profileSectionView.topAnchor.constraint(equalTo: self.safeArea.topAnchor, constant: 10),
            profileSectionView.leadingAnchor.constraint(equalTo: self.safeArea.leadingAnchor, constant: 5),
            profileSectionView.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor, constant: -5)
        ]
        NSLayoutConstraint.activate(profileSectionConstraints)
        
    }
    
    
    private func setupProfilePictureImageView() {

        self.profileSectionView.sectionView.addSubview(profilePictureImageView)
        let profilePictureCOnstraints = [
            profilePictureImageView.topAnchor.constraint(equalTo: self.profileSectionView.sectionView.topAnchor, constant: 10),
            profilePictureImageView.bottomAnchor.constraint(equalTo: self.profileSectionView.sectionView.bottomAnchor, constant: -10),
            profilePictureImageView.leadingAnchor.constraint(equalTo: self.profileSectionView.sectionView.leadingAnchor, constant: 10),
            profilePictureImageView.heightAnchor.constraint(equalToConstant: 48),
            profilePictureImageView.widthAnchor.constraint(equalTo: profilePictureImageView.heightAnchor, multiplier: 1)
        ]
        NSLayoutConstraint.activate(profilePictureCOnstraints)
        
    }
    
    private func setupProfileNameLabel() {
        
        self.profileSectionView.sectionView.addSubview(profileNameLabel)
        let profileNameLabelConstraints = [
            profileNameLabel.topAnchor.constraint(greaterThanOrEqualTo: self.profileSectionView.sectionView.topAnchor, constant: 10),
            profileNameLabel.centerYAnchor.constraint(equalTo: self.profilePictureImageView.centerYAnchor, constant: -12.5),
            profileNameLabel.leadingAnchor.constraint(equalTo: self.profilePictureImageView.trailingAnchor, constant: 10),
            profileNameLabel.trailingAnchor.constraint(equalTo: self.profileSectionView.sectionView.trailingAnchor, constant: -5),
        ]
        NSLayoutConstraint.activate(profileNameLabelConstraints)
        
    }
    
    private func setupEmailIsVerfiedLabel() {
        
        self.profileSectionView.sectionView.addSubview(profileIsEmailVerifiedLabel)
        let isEmailVerfiedLabelConstrants = [
            profileIsEmailVerifiedLabel.topAnchor.constraint(equalTo: self.profileNameLabel.bottomAnchor),
            profileIsEmailVerifiedLabel.bottomAnchor.constraint(equalTo: self.profileSectionView.sectionView.bottomAnchor, constant: -5),
            profileIsEmailVerifiedLabel.leadingAnchor.constraint(equalTo: self.profilePictureImageView.trailingAnchor, constant: 10),
            profileIsEmailVerifiedLabel.trailingAnchor.constraint(equalTo: self.profileSectionView.sectionView.trailingAnchor, constant: -5),
        ]
        NSLayoutConstraint.activate(isEmailVerfiedLabelConstrants)
        
    }
    
    private func setupSettingsSectionView() {
        
        self.view.addSubview(settingsSectionView)
        let settingsSectionConstraints = [
            settingsSectionView.topAnchor.constraint(equalTo: self.profileSectionView.bottomAnchor),
            settingsSectionView.leadingAnchor.constraint(equalTo: self.safeArea.leadingAnchor, constant: 5),
            settingsSectionView.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor, constant: -5)
        ]
        NSLayoutConstraint.activate(settingsSectionConstraints)
    }
    
    private func setupDarkModeCell() {
        
        self.settingsSectionView.sectionView.addSubview(darkModeCell)
        let darkModeCellConstraints = [
            darkModeCell.topAnchor.constraint(equalTo: self.settingsSectionView.sectionView.topAnchor, constant: 10),
            darkModeCell.bottomAnchor.constraint(equalTo: self.settingsSectionView.sectionView.bottomAnchor, constant: -10),
            darkModeCell.leadingAnchor.constraint(equalTo: self.settingsSectionView.sectionView.leadingAnchor, constant: 10),
            darkModeCell.trailingAnchor.constraint(equalTo: self.settingsSectionView.sectionView.trailingAnchor, constant: -10),
        ]
        NSLayoutConstraint.activate(darkModeCellConstraints)
    }
        
    private func setupSignOutButton() {
        
        self.view.addSubview(signOutButton)
        let signOutButtonConstraints = [
            signOutButton.topAnchor.constraint(greaterThanOrEqualTo: self.settingsSectionView.bottomAnchor, constant: 15),
            signOutButton.bottomAnchor.constraint(equalTo: self.safeArea.bottomAnchor, constant: -15),
            signOutButton.leadingAnchor.constraint(equalTo: self.safeArea.leadingAnchor, constant: 15),
            signOutButton.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(signOutButtonConstraints)
    }
    
    
    // MARK: - Functions
    
    private func layoutView() {
        setupProfileSection()
        setupProfilePictureImageView()
        setupProfileNameLabel()
        setupEmailIsVerfiedLabel()
        setupSettingsSectionView()
        setupDarkModeCell()
        setupSignOutButton()
    }
    
    private func setupTargets() {
        if(self.darkModeCell.switchButton.allTargets.isEmpty) {
            self.darkModeCell.switchButton.addTarget(presenter, action: #selector(presenter.darkModeSwitchButtonClciked(_:)), for: .valueChanged)
        }
        if(self.signOutButton.allTargets.isEmpty) {
            self.signOutButton.addTarget(presenter, action: #selector(presenter.signOutButtonClicked(_:)), for: .touchUpInside)
        }
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layoutView()
    }

    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupTargets()
        self.presenter.viewIsLoaded()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Delegates
    
    func setNameLabel(_ name: String!) {
        self.profileNameLabel.text = name
    }
    
    func setEmailVerifiedLabel(_ labelText: String!) {
        self.profileIsEmailVerifiedLabel.text = labelText
    }
    
    func setDarkMode(_ isOn: Bool) {
        self.darkModeCell.switchButton.isOn = isOn
    }
    
}


