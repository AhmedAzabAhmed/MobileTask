//
//  ViewController.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    private var viewModel = LoginViewModel()
    private var cancellable: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(emailTextFieldDidChange(_:)), name: UITextField.textDidChangeNotification, object: emailTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(passwordTextFieldDidChange(_:)), name: UITextField.textDidChangeNotification, object: passwordTextField)
        
        bind()
    }
    
    @objc func emailTextFieldDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            viewModel.set(email: textField.text)
        }
    }
    
    @objc func passwordTextFieldDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            viewModel.set(password: textField.text)
        }
    }
    
    @IBAction func login(_ sender: Any) {
        viewModel.validteFields()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
    }
}

extension ViewController {
    func bind() {
        viewModel
            .validCredential
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .emial(let error):
                    self.updateErrorLabels(state: .emial(error))
                    
                case .password(let error):
                    self.updateErrorLabels(state: .password(error))
                }
            }.store(in: &cancellable)
        
        viewModel
            .login
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                let viewController = RecipesViewController()
                self.navigationController?.pushViewController(viewController, animated: true)
            }.store(in: &cancellable)
        
    }
    
    func updateErrorLabels(state: LoginErrorState) {
        restErrorLabels()
        switch state {
        case .emial(let error):
            emailErrorLabel.text = error
            emailErrorLabel.isHidden = false
            
        case .password(let error):
            passwordErrorLabel.text = error
            passwordErrorLabel.isHidden = false
        }
        
    }
    
    func restErrorLabels() {
        emailErrorLabel.text = nil
        emailErrorLabel.isHidden = true
        passwordErrorLabel.text = nil
        passwordErrorLabel.isHidden = true
    }
}
