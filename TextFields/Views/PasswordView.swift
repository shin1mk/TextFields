//
//  Password.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 04.07.2023.
//

import UIKit
import SnapKit

final class PasswordView: UIView {
    //MARK: UI Elements
    private let validationLabel: UILabel = {
        let label = UILabel()
        label.text = "Validation rules"
        label.textColor = Colors.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let validationInput: UITextField = {
        let input = UITextField()
        input.borderStyle = .roundedRect
        input.font = UIFont.systemFont(ofSize: 17)
        input.textColor = Colors.black
        input.backgroundColor = Colors.inputGray
        input.layer.cornerRadius = 10
        input.clipsToBounds = true
        input.layer.borderWidth = 1.0
        input.layer.borderColor = Colors.inputGray.cgColor
        let placeholderText = "Password"
        let placeholderFont = UIFont.systemFont(ofSize: 17)
        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [
            .foregroundColor: Colors.gray,
            .font: placeholderFont
        ])
        input.attributedPlaceholder = attributedPlaceholder
        input.returnKeyType = .done
        input.isSecureTextEntry = true
        return input
    }()
    private let minimalLengthLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Min length 8 characters."
        return label
    }()
    private let minimalDigitLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Min 1 digit."
        return label
    }()
    private let minimalLowercaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Min 1 lowercase."
        return label
    }()
    private let minimalUppercaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Min 1 capital required."
        return label
    }()
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupConstraints()
        setupTextFieldDelegate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        return nil
    }
    //MARK: Methods
    private func setupTextFieldDelegate() {
        validationInput.delegate = self
    }
    
    private func setupConstraints() {
        addSubview(validationLabel)
        validationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }
        addSubview(validationInput)
        validationInput.snp.makeConstraints { make in
            make.top.equalTo(validationLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(Constants.Input.height)
        }
        // validation rules
        addSubview(minimalLengthLabel)
        minimalLengthLabel.snp.makeConstraints { make in
            make.top.equalTo(validationInput.snp.bottom).offset(Constants.Validation.topOffset)
            make.leading.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }
        addSubview(minimalDigitLabel)
        minimalDigitLabel.snp.makeConstraints { make in
            make.top.equalTo(minimalLengthLabel.snp.bottom).offset(Constants.Validation.topOffset)
            make.leading.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }
        addSubview(minimalLowercaseLabel)
        minimalLowercaseLabel.snp.makeConstraints { make in
            make.top.equalTo(minimalDigitLabel.snp.bottom).offset(Constants.Validation.topOffset)
            make.leading.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }
        addSubview(minimalUppercaseLabel)
        minimalUppercaseLabel.snp.makeConstraints { make in
            make.top.equalTo(minimalLowercaseLabel.snp.bottom).offset(Constants.Validation.topOffset)
            make.leading.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }
    }
}
//MARK: - UITextFieldDelegate

extension PasswordView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if updatedText.isEmpty {
            textField.layer.borderColor = Colors.systemBlue.cgColor
            let validationInfoLabels: [UILabel] = [minimalLengthLabel, minimalDigitLabel, minimalLowercaseLabel, minimalUppercaseLabel]
            
            for label in validationInfoLabels {
                label.textColor = Colors.black
            }
            return true
        }
        // Validate the password
        let isLengthValid = PasswordValidator.validatePasswordLength(updatedText)
        let containsDigit = PasswordValidator.validatePasswordContainsDigit(updatedText)
        let containsLowercase = PasswordValidator.validatePasswordContainsLowercase(updatedText)
        let containsUppercase = PasswordValidator.validatePasswordContainsUppercase(updatedText)
        // Update the UI
        updateLabel(minimalLengthLabel, isValid: isLengthValid, validText: "Min length 8 characters")
        updateLabel(minimalDigitLabel, isValid: containsDigit, validText: "Min 1 digit")
        updateLabel(minimalLowercaseLabel, isValid: containsLowercase, validText: "Min 1 lowercase")
        updateLabel(minimalUppercaseLabel, isValid: containsUppercase, validText: "Min 1 uppercase")
        return true
    }
    
    private func updateLabel(_ label: UILabel, isValid: Bool, validText: String) {
        label.textColor = isValid ? Colors.systemBlue : .red
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.inputGray.cgColor
    }
}
