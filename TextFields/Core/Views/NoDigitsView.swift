//
//  noDigitsView.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 30.06.2023.
//

import UIKit
import SnapKit

final class NoDigitsView: UIView {
    private let noDigitsLabel: UILabel = {
        let label = UILabel()
        label.text = "NO digits field"
        label.textColor = Colors.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let noDigitsInput: UITextField = {
        let input = UITextField()
        input.borderStyle = .roundedRect
        input.font = UIFont.systemFont(ofSize: 17)
        input.textColor = Colors.black
        input.backgroundColor = Colors.inputGray
        input.layer.cornerRadius = 10
        input.clipsToBounds = true
        input.layer.borderWidth = 1.0
        input.layer.borderColor = Colors.inputGray.cgColor
        let placeholder = "Type here"
        let placeholderFont = UIFont.systemFont(ofSize: 17)
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            .foregroundColor: Colors.lightGray,
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
        setupTextFieldDelegate()
//        setupLabelUpdate()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupTextFieldDelegate() {
        noDigitsInput.delegate = self
    }
    
    private func setupConstraints() {
        addSubview(noDigitsLabel)
        noDigitsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.Label.topOffset)
            make.leading.equalToSuperview().offset(Constants.leading)
        }
        addSubview(noDigitsInput)
        noDigitsInput.snp.makeConstraints { make in
            make.top.equalTo(noDigitsLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.leading.trailing.equalToSuperview().inset(Constants.leading)
            make.height.equalTo(Constants.Input.height)
        }
    }
}

extension NoDigitsView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == noDigitsInput else {
            return true
        }
        
        let characterSet = CharacterSet.decimalDigits
        return string.rangeOfCharacter(from: characterSet) == nil
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
