//
//  ValidationView.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 01.07.2023.
//

import UIKit
import SnapKit

final class ValidationView: UIView, UITextFieldDelegate {
    // validation rules
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
        input.isSecureTextEntry = true
        let placeholder = "Password"
        let placeholderFont = UIFont.systemFont(ofSize: 17)
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: placeholderFont
        ])
        input.attributedPlaceholder = attributedPlaceholder
        input.returnKeyType = .done
        return input
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupConstraints()
        setupTextFieldDelegate()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupTextFieldDelegate() {
        validationInput.delegate = self
    }
    private func setupConstraints() {
        addSubview(validationLabel)
        validationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.Label.topOffset)
            make.leading.equalToSuperview().offset(Constants.leading)
        }
        addSubview(validationInput)
        validationInput.snp.makeConstraints { make in
            make.top.equalTo(validationLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.leading.trailing.equalToSuperview().inset(Constants.leading)
            make.height.equalTo(Constants.Input.height)
        }
    }
}
extension ValidationView {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else {
            return true
        }
        
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if updatedText.isEmpty {
            textField.layer.borderColor = Colors.systemBlue.cgColor
            
//            let validationInfoLabels: [UILabel] = [minimalLengthLabel, minimalDigitLabel, minimalLowercaseLabel, minimalUppercaseLabel]
            
//            for label in validationInfoLabels {
//                label.textColor = Colors.black
//            }
            
            return true
        }
        
//        let isLengthValid = ValidationRulesView.validatePasswordLength(updatedText)
//        let containsDigit = ValidationRulesView.validatePasswordContainsDigit(updatedText)
//        let containsLowercase = ValidationRulesView.validatePasswordContainsLowercase(updatedText)
//        let containsUppercase = ValidationRulesView.validatePasswordContainsUppercase(updatedText)
        
//        updateLabel(minimalLengthLabel, isValid: isLengthValid, validText: "Min length 8 characters")
//        updateLabel(minimalDigitLabel, isValid: containsDigit, validText: "Min 1 digit")
//        updateLabel(minimalLowercaseLabel, isValid: containsLowercase, validText: "Min 1 lowercase")
//        updateLabel(minimalUppercaseLabel, isValid: containsUppercase, validText: "Min 1 uppercase")
        
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.inputGray.cgColor
    }
    // Function to update label color
    private func updateLabel(_ label: UILabel, isValid: Bool, validText: String) {
        label.textColor = isValid ? Colors.systemBlue : .red
    }
}
