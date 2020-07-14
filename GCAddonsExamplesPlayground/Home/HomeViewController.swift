//
//  HomeViewController.swift
//  GCAddonsExamplesPlayground
//
//  Created by Guy Cohen on 01/07/2020.
//  Copyright © 2020 GCAddons. All rights reserved.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    enum Input {
        case userTextField(text: String)
        case passwordTextField(text: String)
        case signInTapped
    }
    
    let homeViewModel: HomeViewModel
    private var bindings = Set<AnyCancellable>()
    
    // MARK: - Outlets
    @IBOutlet weak var outletMessageLabel: UILabel!
    @IBOutlet weak var backgroundForTextFields: UIView!
    @IBOutlet weak var outletPasswordTextField: UITextField!
    @IBOutlet weak var outletUserTextField: UITextField!
    @IBOutlet weak var outletButtonSignIn: UIButton!

    init(viewModel: HomeViewModel) {
        self.homeViewModel = viewModel
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    @IBAction func passwordEditingChanged(_ sender: UITextField) {
        homeViewModel.action(Input.passwordTextField(text: sender.text ?? ""))
    }
    
    @IBAction func userEditingChanged(_ sender: UITextField) {
                homeViewModel.action(Input.userTextField(text: sender.text ?? ""))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupUI()
    }
    
    func bind() {
        /// Bind view to view model
//        outletUserTextField.textPublisher
//            .debounce(for: 0.5, scheduler: RunLoop.main)
//            .removeDuplicates()
//            .assign(to: \.userName, on: homeViewModel)
//            .store(in: &bindings)
//        
//        outletPasswordTextField.textPublisher
//            .debounce(for: 0.5, scheduler: RunLoop.main)
//            .removeDuplicates()
//            .assign(to: \.password, on: homeViewModel)
//            .store(in: &bindings)
        
        /// Bind view model to view
        homeViewModel.$state.sink { [weak self] (state) in
            guard let self = self else { return }
            switch state {
            case .idle:
                self.outletMessageLabel.text = "Place your credentials here"
                self.outletButtonSignIn.isEnabled = false
            case .badLoginCred(reason: let reason):
                self.outletMessageLabel.text = reason
                self.outletButtonSignIn.isEnabled = false
            case .verifiedCred:
                self.outletMessageLabel.text = "Looks goods 🤗 tap on login"
                self.outletButtonSignIn.isEnabled = true
            case .signInStarted:
                self.outletMessageLabel.text = "Loading...🙃🙃🙃"
                self.outletButtonSignIn.isEnabled = false
            case .signInResults(isSuccess: let isSuccess):
                self.outletMessageLabel.text = isSuccess ? "Great you in there" : "failed try again"
                self.outletButtonSignIn.isEnabled = !isSuccess
                self.animateViews([self.outletPasswordTextField,
                                   self.outletUserTextField,
                                   self.outletButtonSignIn],
                                   shouldHide: isSuccess)
            }
        }.store(in: &bindings)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        homeViewModel.action(.signInTapped)
        
    }

}
