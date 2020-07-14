//
//  HomeViewModel.swift
//  GCAddonsExamplesPlayground
//
//  Created by Guy Cohen on 01/07/2020.
//  Copyright © 2020 GCAddons. All rights reserved.
//


//enum State { should be for products
//    case loading
//    case empty
//    case failed
//    case received(products: [Product])
//}

import UIKit
import Combine

protocol ViewModelProtocol: ObservableObject where ObjectWillChangePublisher.Output == Void {
    associatedtype State
    associatedtype Input
    var state: State { get }
    func action(_ input: Input)
}

class HomeViewModel: NSObject, ViewModelProtocol {
    // MARK: UI State
    enum State {
        case idle
        case badLoginCred(reason: String)
        case verifiedCred
        case signInStarted
        case signInResults(isSuccess: Bool)
    }

    // MARK: Inputs
    @Published var userName: String = ""
    @Published var password: String = ""
    
    // MARK: Output
    @Published private(set) var state: State = .idle
    
    // MARK: Private
    private var bindings = Set<AnyCancellable>()

    private lazy var validateLogin: AnyCancellable = {
        Publishers.CombineLatest($userName, $password).debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { (user, password) in
            if user.count == 0 && password.count == 0 {
                self.state = .idle
                return
            }
            if !user.validateEmail() {
                self.state = .badLoginCred(reason: "😕 -> Email doesnt seem right")
                return
            }
            if password.count == 0 {
                self.state = .badLoginCred(reason: "🥳 Email looks good,\n fill up the password field")
                return
            }
            if password.count < 4 {
                self.state = .badLoginCred(reason: "Password is too short")
                return
            }
            self.state = .verifiedCred
        }
    }()
    
    override init() {
        super.init()
        validateLogin.store(in: &bindings)
    }
    
    func action(_ input: HomeViewController.Input) {
        switch input {
        case .userTextField(text: let text): self.userName = text
        case .passwordTextField(text: let text): self.password = text
        case .signInTapped: handleSignInTapped()
        }
    }
    
    func handleSignInTapped() {
        self.state = .signInStarted
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.state = .signInResults(isSuccess: true)
        }
    }

}
