//
//  NoDigitsView.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 02.07.2023.
//

import UIKit
import SnapKit

final class NoDigitsView: UIView {
    //MARK: UI Elements
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
        let placeholderText = "Type here"
        let placeholderFont = UIFont.systemFont(ofSize: 17)
        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [
            .foregroundColor: Colors.gray,
            .font: placeholderFont
        ])
        input.attributedPlaceholder = attributedPlaceholder
        input.returnKeyType = .done
        return input
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
        noDigitsInput.delegate = self
    }
    
    private func setupConstraints() {
        addSubview(noDigitsLabel)
        noDigitsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }
        addSubview(noDigitsInput)
        noDigitsInput.snp.makeConstraints { make in
            make.top.equalTo(noDigitsLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(Constants.Input.height)
        }
    }
}
//MARK: - UITextFieldDelegate
extension NoDigitsView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let characterSet = CharacterSet.decimalDigits
        let containsDigits = string.rangeOfCharacter(from: characterSet) != nil
        
        if containsDigits {
            textField.layer.borderColor = UIColor.red.cgColor
            return false
        } else {
            textField.layer.borderColor = Colors.systemBlue.cgColor
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.inputGray.cgColor
    }
}
