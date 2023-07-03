//
//  MainController.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 20.06.2023.
//

import UIKit
import SnapKit
import SafariServices

final class MainController: UIViewController {
    private let noDigitsView = NoDigitsView()
    private let maxLengthView = MaxLengthView()
    private let onlyCharactersView = OnlyCharactersView()
    private let urlView = URLView()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    private var contentSizeConstraint: NSLayoutConstraint!
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        // add title
        contentView.addSubview(titleLabel)
        titleLabel.snp.updateConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(Constants.topOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(Constants.trailing)
        }
        // add no digits view
        contentView.addSubview(noDigitsView)
        noDigitsView.snp.updateConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(Constants.trailing)
        }
        // add max length view
        contentView.addSubview(maxLengthView)
        maxLengthView.snp.updateConstraints { make in
            make.top.equalTo(noDigitsView.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(Constants.trailing)
        }
        // add only characters view
        contentView.addSubview(onlyCharactersView)
        onlyCharactersView.snp.updateConstraints { make in
            make.top.equalTo(maxLengthView.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(Constants.trailing)
        }
        // add URL view
        contentView.addSubview(urlView)
        urlView.snp.updateConstraints { make in
            make.top.equalTo(onlyCharactersView.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(Constants.trailing)
        }
        
        
        
        
        
        
        
        
        
        contentSizeConstraint = contentView.bottomAnchor.constraint(equalTo: urlView.bottomAnchor, constant: Constants.bottomOffset)
        contentSizeConstraint.isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentSizeConstraint.constant = view.frame.height
        scrollView.contentSize = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
    // MARK: - private let
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Text Fields"
        title.font = UIFont.systemFont(ofSize: 34, weight: .medium)
        title.textColor = Colors.black
        title.textAlignment = .center
        return title
    }()
    // validation
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
    // MARK: - rules
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
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setupDelegates()
        setupScrollView()
    }
    
    private func setupDelegates() {
        validationInput.delegate = self
    }
    
} // class
// MARK: - textfields
extension MainController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
            
        case validationInput:
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
        default:
            return true
        }
    }
    // Function to update label color
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.inputGray.cgColor
    }
    
    private func updateLabel(_ label: UILabel, isValid: Bool, validText: String) {
        label.textColor = isValid ? Colors.systemBlue : .red
    }
} // extension
