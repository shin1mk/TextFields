//
//  PasswordValidator.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 26.06.2023.
//

import UIKit
import Foundation

final class validationRulesView: UIView {
    // validation rules
    private let minimalLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "Min length 8 characters."
        label.textColor = Colors.black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    private let minimalDigitLabel: UILabel = {
        let label = UILabel()
        label.text = "Min 1 digit."
        label.textColor = Colors.black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    private let minimalLowercaseLabel: UILabel = {
        let label = UILabel()
        label.text = "Min 1 lowercase."
        label.textColor = Colors.black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    private let minimalUppercaseLabel: UILabel = {
        let label = UILabel()
        label.text = "Min 1 capital required."
        label.textColor = Colors.black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
}
struct ValidationRulesView {
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
