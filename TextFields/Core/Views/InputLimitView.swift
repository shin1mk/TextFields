//
//  inputLimitView.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 30.06.2023.
//

import UIKit
import SnapKit

final class InputLimitView: UIView {
    private let maxLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "Input limit"
        label.textColor = Colors.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let maxLengthInput: UITextField = {
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
    private let maxLengthCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "0/10"
        return label
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
        maxLengthInput.delegate = self
    }
    
    private func setupConstraints() {
        addSubview(maxLengthLabel)
        maxLengthLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.Label.topOffset)
            make.leading.equalToSuperview().offset(Constants.leading)
        }
        addSubview(maxLengthInput)
        maxLengthInput.snp.makeConstraints { make in
            make.top.equalTo(maxLengthLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.leading.trailing.equalToSuperview().inset(Constants.leading)
            make.height.equalTo(Constants.Input.height)
        }
        addSubview(maxLengthCountLabel)
        maxLengthCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(maxLengthLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(Constants.trailing)
        }
    }
}
extension InputLimitView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        if newLength > 10 {
            return false
        }
        maxLengthCountLabel.text = "\(newLength)/10"
        if newLength == 10 {
            maxLengthCountLabel.textColor = UIColor.red
        } else {
            maxLengthCountLabel.textColor = UIColor.black
        }
        return true
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

