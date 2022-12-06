//
//  KeyboardManager.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 04/12/2022.
//

import UIKit

final class KeyboardManager {

    // MARK: - Properties
    
    private weak var view: UIScrollView?
    
    // MARK: - Initialization
    
    init(view: UIScrollView!) {
        self.view = view
        self.setupKeyboardManager()
    }
    
    // MARK: - Object Life Cycle
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupKeyboardManager() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
    
    @objc private func keyboardWillHide(_ sender: NSNotification!) {
        self.view?.contentInset = UIEdgeInsets.zero
    }
    
    @objc private func keyboardWillShow(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height else { return }
        self.view?.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    }

}
