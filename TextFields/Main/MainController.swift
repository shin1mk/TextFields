//
//  MainController.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 20.06.2023.
//

import UIKit
import SnapKit

class MainController: UIViewController {
    // MARK: - Private UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Text Fields"
        label.font = UIFont.customFontMedium(ofSize: 34)
        label.textColor = Colors.black
        label.textAlignment = .center
        return label
    }()
    private let subtitleLabel: UILabel = {
        let subtitle = UILabel()
        subtitle.text = "NO digits field"
        subtitle.textColor = Colors.gray
        subtitle.textAlignment = .center
        subtitle.font = UIFont.customFontRegular(ofSize: 17)
        return subtitle
    }()
    private let inputTextField: UITextField = {
        let input = UITextField()
        input.borderStyle = .roundedRect
        input.font = UIFont.customFontRegular(ofSize: 17)
        input.textColor = Colors.gray
        input.backgroundColor = Colors.inputGray
        input.layer.cornerRadius = 10
        input.clipsToBounds = true
        input.layer.borderWidth = 1.0
        input.layer.borderColor = Colors.inputGray.cgColor
        
        let placeholderFont = UIFont.customFontRegular(ofSize: 17)
        let placeholderText = "Type here"
        let attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                NSAttributedString.Key.font: placeholderFont as Any
            ]
        )
        input.attributedPlaceholder = attributedPlaceholder
        return input
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupTapGestureRecognizer()

        setupTextFieldDelegate()
        dismissKeyboard()
    }

    private func setupUI() {
        self.view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        // title
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Constants.topOffset)
        }
        // subtitle
        self.view.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Subtitle.topOffset)
            make.leading.equalToSuperview().inset(Constants.horizontalInset)
        }
        // input
        self.view.addSubview(inputTextField)
        inputTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalInset)
            make.height.equalTo(Constants.Input.height)
        }
    }
    // delegate
    private func setupTextFieldDelegate() {
        inputTextField.delegate = self
    }
    // gestures recognizer
    private func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    // tap on board and dismiss input border color
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
} // MC


// MARK: - подсвечивает нам бордер у инпута
extension MainController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.blue.cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.inputGray.cgColor
    }
    // 1 input (NO digits)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let characterSet = CharacterSet.decimalDigits
        return string.rangeOfCharacter(from: characterSet) == nil
    }
}


