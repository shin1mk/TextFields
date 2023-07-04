//
//  MaxLengthView.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 03.07.2023.
//

import UIKit
import SnapKit

final class MaxLengthView: UIView {
    //MARK: UI Elements
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
    private let maxLengthCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "0/10"
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
        maxLengthInput.delegate = self
    }
    
    private func setupConstraints() {
        addSubview(maxLengthLabel)
        maxLengthLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }
        addSubview(maxLengthInput)
        maxLengthInput.snp.makeConstraints { make in
            make.top.equalTo(maxLengthLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(Constants.Input.height)
        }
        addSubview(maxLengthCountLabel)
        maxLengthCountLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.centerY.equalTo(maxLengthLabel.snp.centerY)
        }
    }
}
//MARK: - UITextFieldDelegate
extension MaxLengthView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? ""
        let newLength = text.count + string.count - range.length
        if newLength > 10 {
            textField.layer.borderColor = Colors.red.cgColor
            maxLengthCountLabel.textColor = Colors.red
            return false
        } else {
            textField.layer.borderColor = Colors.systemBlue.cgColor
            maxLengthCountLabel.textColor = Colors.black
        }
        maxLengthCountLabel.text = "\(newLength)/10"
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.systemBlue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.inputGray.cgColor
    }
}
