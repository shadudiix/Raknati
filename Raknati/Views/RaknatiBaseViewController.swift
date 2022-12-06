//
//  RaknatiBaseViewController.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 27/11/2022.
//

import UIKit

protocol BaseViewControllerDelegates: AnyObject {
    
    func showToast(_ toastMessage: String!)
    func showAlert(_ alertMessage: String!)
    func showYesNoQuestion(_ alertQuestion: String!, handler: @escaping(Bool) -> ())
    func showLoading()
    func hideLoading()
}


class RaknatiBaseViewController: UIViewController, BaseViewControllerDelegates {

    private lazy var loadingView: RaknatiBaseLoadingView = {
        let baseLoadingView = RaknatiBaseLoadingView()
        return baseLoadingView
    }()
    
    enum ViewControllerType: Int {
        case mainView
        case secondryView
    }
    
    lazy var safeArea: UILayoutGuide = {
        return self.view.safeAreaLayoutGuide
    }()
    
    init(viewType: ViewControllerType!) {
        super.init(nibName: nil, bundle: nil)
        setupViewController(viewType)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewController(_ viewType: ViewControllerType) {
        if(viewType == .mainView) {
            self.view.backgroundColor = UIColor.systemGroupedBackground
        } else {
            self.view.backgroundColor = UIColor.secondarySystemGroupedBackground
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func showLoading() {
        self.view.isUserInteractionEnabled = false
        self.view.addSubview(loadingView)
        let loadingConstraints = [
            loadingView.centerYAnchor.constraint(equalTo: self.safeArea.centerYAnchor),
            loadingView.centerXAnchor.constraint(equalTo: self.safeArea.centerXAnchor)
        ]
        NSLayoutConstraint.activate(loadingConstraints)
    }
    
    func hideLoading() {
        if(self.view.isUserInteractionEnabled == false) {
            self.view.isUserInteractionEnabled.toggle()
            loadingView.removeFromSuperview()
        }
    }
    
    func showAlert(_ alertMessage: String!) {
        let alertViewController = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertViewController, animated: true)
    }

    func showYesNoQuestion(_ alertQuestion: String!, handler: @escaping(Bool) -> ()) {
        let alertViewController = UIAlertController(title: nil, message: alertQuestion, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            handler(true)
        }))
        alertViewController.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in
            handler(false)
        }))
        self.present(alertViewController, animated: true)
    }
    
    func showToast(_ toastMessage: String!) {
        print(toastMessage)
    }
    
}
