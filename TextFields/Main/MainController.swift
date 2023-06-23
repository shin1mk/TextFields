//
//  MainController.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 20.06.2023.
//

import UIKit
import SnapKit
import Veil

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
    // title for validation rules
    private lazy var minimalLengthLabel: UILabel = makeLabel(text: "Min length 8 characters.")
    private lazy var minimalDigitLabel: UILabel = makeLabel(text: "Min 1 digit.")
    private lazy var minimalLowercaseLabel: UILabel = makeLabel(text: "Min 1 lowercase.")
    private lazy var minimalUppercaseLabel: UILabel = makeLabel(text: "Min 1 capital required.")
    // labels & inputs
    private lazy var noDigitsLabel: UILabel = {
        return createSubtitleLabel(text: "NO digits field")
    }()
    private lazy var noDigitsInput: UITextField = {
        return createInputTextField(placeholder: "Type here")
    }()
    private lazy var maxLengthLabel: UILabel = {
        return createSubtitleLabel(text: "Input limit")
    }()
    private lazy var maxLengthInput: UITextField = {
        return createInputTextField(placeholder: "Type here")
    }()
    private lazy var onlyCharactersLabel: UILabel = {
        return createSubtitleLabel(text: "Only characters")
    }()
    private lazy var onlyCharactersInput: UITextField = {
        return createInputTextField(placeholder: "wwwww-ddddd")
    }()
    private lazy var urlLabel: UILabel = {
        return createSubtitleLabel(text: "Link")
    }()
    private lazy var urlInput: UITextField = {
        let textFieldURL = createInputTextField(placeholder: "www.example.com")
        setupUrlInputTarget(for: textFieldURL)
        return textFieldURL
    }()
    private lazy var validationLabel: UILabel = {
        return createSubtitleLabel(text: "Validation rules")
    }()
    private lazy var validationInput: UITextField = {
        let input = createInputTextField(placeholder: "Password")
        input.isSecureTextEntry = true // Set isSecureTextEntry
        return input
    }()
    
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
        setupUI()
        setupConstraints()
        setupTapGestureRecognizer()
        setupDelegates()
        setupCustomButton()
    }
    
    private func setupCustomButton() {
        let button = UIButton(type: .custom)
        button.setTitle("GO", for: .normal)
        button.setTitleColor(Colors.white, for: .normal)
        button.backgroundColor = Colors.systemBlue

        urlInput.rightView = button
        urlInput.rightViewMode = .always
        button.isHidden = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside) // как вынести в addTarget?
    }

    @objc private func buttonTapped() {
        guard var text = urlInput.text else {
            return
        }
        // add prefix if www
        if !text.hasPrefix("http://") && !text.hasPrefix("https://") {
            text = "http://" + text
        }
        if let url = URL(string: text), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
 
    private func setupUI() {
        view.backgroundColor = .white
        maxLengthCountLabel.text = "0/10"
    }
    
    private func setupConstraints() {
        // title
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Constants.topOffset)
        }
        // no digits label
        self.view.addSubview(noDigitsLabel)
        noDigitsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalToSuperview().inset(Constants.horizontalInset)
        }
        // no digits input
        self.view.addSubview(noDigitsInput)
        noDigitsInput.snp.makeConstraints { make in
            make.top.equalTo(noDigitsLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalInset)
            make.height.equalTo(Constants.Input.height)
        }
        // max length label
        self.view.addSubview(maxLengthLabel)
        maxLengthLabel.snp.makeConstraints { make in
            make.top.equalTo(noDigitsInput.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalToSuperview().inset(Constants.horizontalInset)
        }
        // max lenght counter
        self.view.addSubview(maxLengthCountLabel)
        maxLengthCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(maxLengthLabel)
            make.trailing.equalToSuperview().inset(Constants.horizontalInset)
        }
        // max length input
        self.view.addSubview(maxLengthInput)
        maxLengthInput.snp.makeConstraints { make in
            make.top.equalTo(maxLengthLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalInset)
            make.height.equalTo(Constants.Input.height)
        }
        // only characters label
        self.view.addSubview(onlyCharactersLabel)
        onlyCharactersLabel.snp.makeConstraints { make in
            make.top.equalTo(maxLengthInput.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalToSuperview().inset(Constants.horizontalInset)
        }
        // only characters input
        self.view.addSubview(onlyCharactersInput)
        onlyCharactersInput.snp.makeConstraints { make in
            make.top.equalTo(onlyCharactersLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalInset)
            make.height.equalTo(Constants.Input.height)
        }
        // url label
        self.view.addSubview(urlLabel)
        urlLabel.snp.makeConstraints { make in
            make.top.equalTo(onlyCharactersInput.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalToSuperview().inset(Constants.horizontalInset)
        }
        // url input
        self.view.addSubview(urlInput)
        urlInput.snp.makeConstraints { make in
            make.top.equalTo(urlLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalInset)
            make.height.equalTo(Constants.Input.height)
        }
        // validation label
        self.view.addSubview(validationLabel)
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(urlInput.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalToSuperview().inset(Constants.horizontalInset)
        }
        // validation input
        self.view.addSubview(validationInput)
        validationInput.snp.makeConstraints { make in
            make.top.equalTo(validationLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalInset)
            make.height.equalTo(Constants.Input.height)
        }
        // minimalLengthLabel
        self.view.addSubview(minimalLengthLabel)
        minimalLengthLabel.snp.makeConstraints { make in
            make.top.equalTo(validationInput.snp.bottom).offset(Constants.Validation.topOffset)
            make.leading.equalTo(validationInput.snp.leading)
            make.trailing.equalTo(validationInput.snp.trailing)
        }
        // minimalDigitLabel
        self.view.addSubview(minimalDigitLabel)
        minimalDigitLabel.snp.makeConstraints { make in
            make.top.equalTo(minimalLengthLabel.snp.bottom).offset(Constants.Validation.offset)
            make.leading.equalTo(minimalLengthLabel.snp.leading)
            make.trailing.equalTo(minimalLengthLabel.snp.trailing)
        }
        // minimalLowercaseLabel
        self.view.addSubview(minimalLowercaseLabel)
        minimalLowercaseLabel.snp.makeConstraints { make in
            make.top.equalTo(minimalDigitLabel.snp.bottom).offset(Constants.Validation.offset)
            make.leading.equalTo(minimalDigitLabel.snp.leading)
            make.trailing.equalTo(minimalDigitLabel.snp.trailing)
        }
        // minimalUppercaseLabel
        self.view.addSubview(minimalUppercaseLabel)
        minimalUppercaseLabel.snp.makeConstraints { make in
            make.top.equalTo(minimalLowercaseLabel.snp.bottom).offset(Constants.Validation.offset)
            make.leading.equalTo(minimalLowercaseLabel.snp.leading)
            make.trailing.equalTo(minimalLowercaseLabel.snp.trailing)
        }
    }

    private func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
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
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    // validate url
    @objc private func validateUrl(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        let urlRegex = "^(http://)?(https://)?(www\\.)?([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?([a-zA-Z]{2})?$"
        let urlPredicate = NSPredicate(format: "SELF MATCHES %@", urlRegex)
        let isValid = urlPredicate.evaluate(with: text)
        textField.layer.borderColor = isValid ? Colors.blue.cgColor : Colors.red.cgColor
        
        if isValid {
             urlInput.rightView?.isHidden = false
         } else {
             urlInput.rightView?.isHidden = true
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
            
        case onlyCharactersInput:
            let mask = Veil(pattern: "*****-#####")

            guard let currentText = textField.text else {
                return true
            }
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            _ = updatedText.filter { $0.isLetter || $0.isNumber }
            let maskedText = mask.mask(input: updatedText, exhaustive: false)
            textField.text = maskedText
            return false
            
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
            let isLengthValid = validatePasswordLength(updatedText)
            let containsDigit = validatePasswordContainsDigit(updatedText)
            let containsLowercaseLetter = validatePasswordContainsLowercase(updatedText)
            let containsUppercaseLetter = validatePasswordContainsUppercase(updatedText)
            // Update the UI
            updateLabel(minimalLengthLabel, isValid: isLengthValid, validText: "Min length 8 characters", invalidText: " Min length 8 characters")
            updateLabel(minimalDigitLabel, isValid: containsDigit, validText: "Min 1 digit", invalidText: "Min 1 digit")
            updateLabel(minimalLowercaseLabel, isValid: containsLowercaseLetter, validText: " Min 1 lowercase", invalidText: " Min 1 lowercase")
            updateLabel(minimalUppercaseLabel, isValid: containsUppercaseLetter, validText: " Min 1 uppercase", invalidText: "Min 1 uppercase")
            return true
        default:
            return true
        }
    }
//     Function to update label text and color
    private func updateLabel(_ label: UILabel, isValid: Bool, validText: String, invalidText: String) {
//        label.text = isValid ? "✓ \(validText)" : "✕ \(invalidText)"
        label.textColor = isValid ? .systemBlue : .red
    }
    // count => 8
    private func validatePasswordLength(_ password: String) -> Bool {
        let isPasswordValid = password.count >= 8
        return isPasswordValid
    }
    // min 1 digit
    private func validatePasswordContainsDigit(_ password: String) -> Bool {
        let digitPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[0-9].*")
        return digitPredicate.evaluate(with: password)
    }
    // min 1 lowercase
    private func validatePasswordContainsLowercase(_ password: String) -> Bool {
        let lowercasePredicate = NSPredicate(format: "SELF MATCHES %@", ".*[a-z].*")
        return lowercasePredicate.evaluate(with: password)
    }
    // min 1 uppercase
    private func validatePasswordContainsUppercase(_ password: String) -> Bool {
        let uppercasePredicate = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z].*")
        return uppercasePredicate.evaluate(with: password)
    }
} // extension


// questions
// 1 почему выходит ошибка когда я нажимаю на инпут
// 2023-06-22 23:48:57.228717+0300 TextFields[7977:125417] [Query] Error for queryMetaDataSync: 2
// 2 как упорядочить код?
// 3 почему Veil(pattern: "*****-#####") в * вписываются и буквы и цифры
// 4  label.text = isValid ? "✓ \(validText)" : "✕ \(invalidText)"  как вернуть на дефолтное значение если стираю текст
