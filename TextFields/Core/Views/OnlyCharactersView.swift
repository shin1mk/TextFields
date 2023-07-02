//
//  OnlyCharacters.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 01.07.2023.
//

import UIKit
import SnapKit

final class OnlyCharactersView: UIView {
    private let onlyCharactersLabel: UILabel = {
        let label = UILabel()
        label.text = "Only characters"
        label.textColor = Colors.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let onlyCharactersInput: UITextField = {
        let input = UITextField()
        input.borderStyle = .roundedRect
        input.font = UIFont.systemFont(ofSize: 17)
        input.textColor = Colors.black
        input.backgroundColor = Colors.inputGray
        input.layer.cornerRadius = 10
        input.clipsToBounds = true
        input.layer.borderWidth = 1.0
        input.layer.borderColor = Colors.inputGray.cgColor
        let placeholder = "wwwww-ddddd"
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
        onlyCharactersInput.delegate = self
    }
    
    private func setupConstraints() {
        addSubview(onlyCharactersLabel)
        onlyCharactersLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.Label.topOffset)
            make.leading.equalToSuperview().offset(Constants.leading)
        }
        addSubview(onlyCharactersInput)
        onlyCharactersInput.snp.makeConstraints { make in
            make.top.equalTo(onlyCharactersLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.leading.trailing.equalToSuperview().inset(Constants.leading)
            make.height.equalTo(Constants.Input.height)
        }
    }
}

extension OnlyCharactersView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == onlyCharactersInput else {
            return true }
        if string.isEmpty {
            return true
        }
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if newText.count == 5 {
            textField.text = "\(newText)-"
            return false
        }
        
        if newText.count > 5 {
            if let firstCharacter = string.first, CharacterSet.letters.contains(firstCharacter.unicodeScalars.first!) {
                textField.layer.borderColor = UIColor.red.cgColor
                return false
            } else {
                textField.layer.borderColor = UIColor.systemBlue.cgColor
            }
        }
        return newText.count <= 11
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.inputGray.cgColor
    }
    
    private func updateLabel(_ label: UILabel, isValid: Bool, validText: String) {
        label.textColor = isValid ? Colors.systemBlue : .red
    }
}
