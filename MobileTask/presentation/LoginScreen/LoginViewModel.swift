//
//  LoginViewModel.swift
//  MobileTask
//
//  Created by Ahmed Azab on 23/08/2023.
//

import Foundation
import Combine

final class LoginViewModel {
    private var email: String = ""
    private var password: String = ""
    
    let validCredential = PassthroughSubject<LoginErrorState, Never>()
    let login = PassthroughSubject<Void, Never>()
    
    func set(email: String?) {
        self.email = email ?? ""
    }
    
    func set(password: String?) {
        self.password = password ?? ""
    }
    
    func validteFields() {
        if !email.isValidEmail {
            validCredential.send(.emial("Enter valid email"))
        } else if !password.isValidPassword {
            validCredential.send(.password("Enter valid password"))
        } else {
            login.send(())
        }
    }
    
}
