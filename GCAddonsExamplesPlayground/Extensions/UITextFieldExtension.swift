//
//  UITextFieldExtension.swift
//  GCAddonsExamplesPlayground
//
//  Created by Guy Cohen on 03/07/2020.
//  Copyright © 2020 GCAddons. All rights reserved.
//

import UIKit
import Combine

extension UITextField { // TODO: Should be in GC ADDONS
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField } // receiving notifications with objects which are instances of UITextFields
            .map { $0.text ?? "" } // mapping UITextField to extract text
            .eraseToAnyPublisher()
    }
}

