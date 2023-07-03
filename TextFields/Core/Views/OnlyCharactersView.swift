//
//  OnlyCharactersView.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 04.07.2023.
//

import UIKit
import SnapKit
import JMMaskTextField_Swift

final class OnlyCharactersView: UIView {
    private let onlyCharactersLabel: UILabel = {
        let label = UILabel()
        label.text = "Only characters"
        label.textColor = Colors.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let onlyCharactersInput: JMMaskTextField = {
        let input = JMMaskTextField()
        input.maskString = "AAAAA-00000"
        input.borderStyle = .roundedRect
        input.font = UIFont.systemFont(ofSize: 17)
        input.textColor = Colors.black
        input.backgroundColor = Colors.inputGray
        input.layer.cornerRadius = 10
        input.clipsToBounds = true
        input.layer.borderWidth = 1.0
        input.layer.borderColor = Colors.inputGray.cgColor
        let placeholderText = "wwwww-ddddd"
        let placeholderFont = UIFont.systemFont(ofSize: 17)
        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [
            .foregroundColor: Colors.gray,
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
        return nil
    }
    
    private func setupTextFieldDelegate() {
        onlyCharactersInput.delegate = self
    }
    
    private func setupConstraints() {
        addSubview(onlyCharactersLabel)
        onlyCharactersLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
        }
        addSubview(onlyCharactersInput)
        onlyCharactersInput.snp.makeConstraints { make in
            make.top.equalTo(onlyCharactersLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.edges.equalToSuperview().offset(0);
            make.height.equalTo(Constants.Input.height)
        }
    }
}

extension OnlyCharactersView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text as NSString? else { return true }
        let newText = text.replacingCharacters(in: range, with: string)
        
        let maskTextField = textField as! JMMaskTextField
        guard let unmaskedText = maskTextField.stringMask?.unmask(string: newText) else { return true }
        
        if unmaskedText.count >= 11 {
            maskTextField.maskString = "AAAAA-00000"
        } else {
            maskTextField.maskString = "AAAAA-00000"
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.inputGray.cgColor
    }
    
}

