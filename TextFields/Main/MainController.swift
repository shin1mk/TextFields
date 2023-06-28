//
//  MainController.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 20.06.2023.
//

import UIKit
import SnapKit
import SafariServices

class MainController: UIViewController {
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Text Fields"
        title.font = UIFont.systemFont(ofSize: 34, weight: .medium)
        title.textColor = Colors.black
        title.textAlignment = .center
        return title
    }()
    private let maxLengthCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.frame.size = contentSize
        return contentView
    }()
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 100)
    }
    // labels & inputs
    private lazy var noDigitsLabel: UILabel = createSubtitleLabel(text: "NO digits field")
    private lazy var noDigitsInput: UITextField = createInputTextField(placeholder: "Type here")
    private lazy var maxLengthLabel: UILabel = createSubtitleLabel(text: "Input limit")
    private lazy var maxLengthInput: UITextField = createInputTextField(placeholder: "Type here")
    private lazy var onlyCharactersLabel: UILabel = createSubtitleLabel(text: "Only characters")
    private lazy var onlyCharactersInput: UITextField = createInputTextField(placeholder: "wwwww-ddddd")
    private lazy var urlLabel: UILabel = createSubtitleLabel(text: "Link")
    private lazy var urlInput: UITextField = {
        let textFieldURL = createInputTextField(placeholder: "www.example.com")
        setupUrlInputTarget(for: textFieldURL)
        return textFieldURL
    }()
    private lazy var validationLabel: UILabel = createSubtitleLabel(text: "Validation rules")
    private lazy var validationInput: UITextField = {
        let input = createInputTextField(placeholder: "Password")
        input.isSecureTextEntry = true
        return input
    }()
    // title for validation rules
    private lazy var minimalLengthLabel: UILabel = makeLabel(text: "Min length 8 characters.")
    private lazy var minimalDigitLabel: UILabel = makeLabel(text: "Min 1 digit.")
    private lazy var minimalLowercaseLabel: UILabel = makeLabel(text: "Min 1 lowercase.")
    private lazy var minimalUppercaseLabel: UILabel = makeLabel(text: "Min 1 capital required.")
    
    private func createSubtitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = Colors.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }
    
    private func createInputTextField(placeholder: String) -> UITextField {
        let input = UITextField()
        input.borderStyle = .roundedRect
        input.font = UIFont.systemFont(ofSize: 17)
        input.textColor = Colors.black
        input.backgroundColor = Colors.inputGray
        input.layer.cornerRadius = 10
        input.clipsToBounds = true
        input.layer.borderWidth = 1.0
        input.layer.borderColor = Colors.inputGray.cgColor
        let placeholderFont = UIFont.systemFont(ofSize: 17)
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: placeholderFont
        ])
        input.attributedPlaceholder = attributedPlaceholder
        return input
    }
    // create title for validation rules
    private func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = Colors.black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.text = text
        return label
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setupUI()
        setupTapGestureRecognizer()
        setupDelegates()
        setupUrlInput()
        setupViewsConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        maxLengthCountLabel.text = "0/10"
    }
    
    private func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupDelegates() {
        noDigitsInput.delegate = self
        maxLengthInput.delegate = self
        onlyCharactersInput.delegate = self
        urlInput.delegate = self
        validationInput.delegate = self
    }
    
    private func setupUrlInputTarget(for textField: UITextField) {
        textField.addTarget(self, action: #selector(validateUrl), for: .editingChanged)
    }
    
    @objc private func handleTap() {
        view.endEditing(true)
    }
    // validate url button GO
    private func setupUrlInput() {
        urlInput.returnKeyType = .go
    }
    
    @objc private func buttonTapped() {
        guard var text = urlInput.text else {
            return
        }
        // add prefix if www
        if !text.hasPrefix("http://") && !text.hasPrefix("https://") {
            text = "http://" + text
        }
        if let url = URL(string: text) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    @objc private func validateUrl(_ textField: UITextField) {
        guard let text = textField.text else { return }
        // prefix
        let urlRegex = "^(http://)?(https://)?(www\\.)?([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?([a-zA-Z]{2})?$"
        let urlPredicate = NSPredicate(format: "SELF MATCHES %@", urlRegex)
        let isValid = urlPredicate.evaluate(with: text)
        
        textField.layer.borderColor = isValid ? Colors.blue.cgColor : Colors.red.cgColor
        
        if isValid {
            textField.rightViewMode = .always
            
            let domainSuffixes = [".com", ".org", ".gov", ".io", ".co", ".ua", ".ru", ".ca"]
            var suffixFound = false
            //if suffix has
            for suffix in domainSuffixes {
                if text.lowercased().hasSuffix(suffix) {
                    suffixFound = true
                    break
                }
            }
            // if suffix found start counter
            if suffixFound {
                let countdownLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: textField.frame.height))
                countdownLabel.font = UIFont.systemFont(ofSize: 14)
                countdownLabel.textColor = Colors.systemBlue
                
                textField.rightView = countdownLabel
                
                var countdown = 5
                countdownLabel.text = "\(countdown)"
                
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    countdown -= 1
                    countdownLabel.text = "\(countdown)"
                    
                    if countdown == 0 {
                        timer.invalidate()
                        textField.rightView = nil
                        
                        var urlString = text
                        if !urlString.lowercased().hasPrefix("http://") && !urlString.lowercased().hasPrefix("https://") {
                            urlString = "http://" + urlString
                        }
                        
                        if let url = URL(string: urlString) {
                            UIApplication.shared.open(url)
                        }
                    }
                }
            }
        } else {
            textField.rightView = nil
        }
    }
} // class
// MARK: - textfield
extension MainController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.inputGray.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == urlInput {
            buttonTapped()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case noDigitsInput:
            let characterSet = CharacterSet.decimalDigits
            return string.rangeOfCharacter(from: characterSet) == nil
            
        case maxLengthInput:
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            if newLength > 10 {
                return false
            }
            maxLengthCountLabel.text = "\(newLength)/10"
            if newLength == 10 {
                maxLengthCountLabel.textColor = Colors.red
            } else {
                maxLengthCountLabel.textColor = Colors.black
            }
            return true

//        case onlyCharactersInput:
//            let mask = Veil(pattern: "*****-#####")
//
//            guard let currentText = textField.text else {
//                return true
//            }
//            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
//            _ = updatedText.filter { $0.isLetter || $0.isNumber }
//            let maskedText = mask.mask(input: updatedText, exhaustive: false)
//            textField.text = maskedText
//            return false
            
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
    private func updateLabel(_ label: UILabel, isValid: Bool, validText: String) {
        label.textColor = isValid ? Colors.systemBlue : .red
    }
} // extension
//MARK: - setup constraints
extension MainController {
    private func setupViewsConstraints() {
        // title label
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(Constants.topOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(Constants.trailing)
        }
        // no digits label & input
        contentView.addSubview(noDigitsLabel)
        noDigitsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.leading)
        }
        contentView.addSubview(noDigitsInput)
        noDigitsInput.snp.makeConstraints { make in
            make.top.equalTo(noDigitsLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.leading.trailing.equalTo(contentView).inset(Constants.leading)
            make.height.equalTo(Constants.Input.height)
        }
        // max lengt label & input
        contentView.addSubview(maxLengthLabel)
        maxLengthLabel.snp.makeConstraints { make in
            make.top.equalTo(noDigitsInput.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.leading)
        }
        contentView.addSubview(maxLengthInput)
        maxLengthInput.snp.makeConstraints { make in
            make.top.equalTo(maxLengthLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.leading.trailing.equalTo(contentView).inset(Constants.leading)
            make.height.equalTo(Constants.Input.height)
        }
        // max length counter
        contentView.addSubview(maxLengthCountLabel)
        maxLengthCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(maxLengthLabel.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(Constants.trailing)
        }
        // only characters label & input
        contentView.addSubview(onlyCharactersLabel)
        onlyCharactersLabel.snp.makeConstraints { make in
            make.top.equalTo(maxLengthInput.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.leading)
        }
        contentView.addSubview(onlyCharactersInput)
        onlyCharactersInput.snp.makeConstraints { make in
            make.top.equalTo(onlyCharactersLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.leading.trailing.equalTo(contentView).inset(Constants.leading)
            make.height.equalTo(Constants.Input.height)
        }
        // url label & input
        contentView.addSubview(urlLabel)
        urlLabel.snp.makeConstraints { make in
            make.top.equalTo(onlyCharactersInput.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.leading)
        }
        contentView.addSubview(urlInput)
        urlInput.snp.makeConstraints { make in
            make.top.equalTo(urlLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.leading.trailing.equalTo(contentView).inset(Constants.leading)
            make.height.equalTo(Constants.Input.height)
        }
        // validation label & input
        contentView.addSubview(validationLabel)
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(urlInput.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.leading)
        }
        contentView.addSubview(validationInput)
        validationInput.snp.makeConstraints { make in
            make.top.equalTo(validationLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.leading.trailing.equalTo(contentView).inset(Constants.leading)
            make.height.equalTo(Constants.Input.height)
        }
        // validation rules
        contentView.addSubview(minimalLengthLabel)
        minimalLengthLabel.snp.makeConstraints { make in
            make.top.equalTo(validationInput.snp.bottom).offset(Constants.Validation.topOffset)
            make.leading.trailing.equalTo(contentView).inset(Constants.leading)
        }
        contentView.addSubview(minimalDigitLabel)
        minimalDigitLabel.snp.makeConstraints { make in
            make.top.equalTo(minimalLengthLabel.snp.bottom).offset(Constants.Validation.topOffset)
            make.leading.trailing.equalTo(contentView).inset(Constants.leading)
        }
        contentView.addSubview(minimalLowercaseLabel)
        minimalLowercaseLabel.snp.makeConstraints { make in
            make.top.equalTo(minimalDigitLabel.snp.bottom).offset(Constants.Validation.topOffset)
            make.leading.trailing.equalTo(contentView).inset(Constants.leading)
        }
        contentView.addSubview(minimalUppercaseLabel)
        minimalUppercaseLabel.snp.makeConstraints { make in
            make.top.equalTo(minimalLowercaseLabel.snp.bottom).offset(Constants.Validation.topOffset)
            make.leading.trailing.equalTo(contentView).inset(Constants.leading)
        }
    }
}
