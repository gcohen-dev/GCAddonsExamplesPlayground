//
//  String+extension.swift
//  GCAddonsExamplesPlayground
//
//  Created by Guy Cohen on 06/07/2020.
//  Copyright © 2020 GCAddons. All rights reserved.
//

import Foundation

extension String {
    
    func validateEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
}
