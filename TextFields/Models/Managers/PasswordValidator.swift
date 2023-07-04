//
//  PasswordValidator.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 26.06.2023.
//

import Foundation

class PasswordValidator {
    static func validatePasswordLength(_ password: String) -> Bool {
        let isPasswordValid = password.count >= 8
        return isPasswordValid
    }

    static func validatePasswordContainsDigit(_ password: String) -> Bool {
        let digitPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[0-9].*")
        return digitPredicate.evaluate(with: password)
    }

    static func validatePasswordContainsLowercase(_ password: String) -> Bool {
        let lowercasePredicate = NSPredicate(format: "SELF MATCHES %@", ".*[a-z].*")
        return lowercasePredicate.evaluate(with: password)
    }

    static func validatePasswordContainsUppercase(_ password: String) -> Bool {
        let uppercasePredicate = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z].*")
        return uppercasePredicate.evaluate(with: password)
    }
}
