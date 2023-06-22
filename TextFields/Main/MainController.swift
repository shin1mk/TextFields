//
//  MainController.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 20.06.2023.
//


import Foundation
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
    private let maxLengthCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let minimalLengthLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.text = "Min length 8 characters."
        return label
    }()
    private let minimalDigitLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.text = "Min 1 digit."
        return label
    }()
    private let minimalLowercaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.text = "Min 1 lowercase."
        return label
    }()
    private let minimalUppercaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.text = "Min 1 capital required."
        return label
    }()
    
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
        input.isSecureTextEntry = true // Set isSecureTextEntry property true
        return input
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupTapGestureRecognizer()
        setupDelegates()
        
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
        // Метка счетчика максимальной длины
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
        
        // link label
        self.view.addSubview(urlLabel)
        urlLabel.snp.makeConstraints { make in
            make.top.equalTo(onlyCharactersInput.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalToSuperview().inset(Constants.horizontalInset)
        }
        // link input
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
        
        // validation info label 1
        self.view.addSubview(minimalLengthLabel)
        minimalLengthLabel.snp.makeConstraints { make in
            make.top.equalTo(validationInput.snp.bottom).offset(15)
            make.leading.equalTo(validationInput.snp.leading)
            make.trailing.equalTo(validationInput.snp.trailing)
        }
        
        // validation info label 2
        self.view.addSubview(minimalDigitLabel)
        minimalDigitLabel.snp.makeConstraints { make in
            make.top.equalTo(minimalLengthLabel.snp.bottom).offset(5)
            make.leading.equalTo(minimalLengthLabel.snp.leading)
            make.trailing.equalTo(minimalLengthLabel.snp.trailing)
        }
        
        // validation info label 3
        self.view.addSubview(minimalLowercaseLabel)
        minimalLowercaseLabel.snp.makeConstraints { make in
            make.top.equalTo(minimalDigitLabel.snp.bottom).offset(5)
            make.leading.equalTo(minimalDigitLabel.snp.leading)
            make.trailing.equalTo(minimalDigitLabel.snp.trailing)
        }
        
        // validation info label 4
        self.view.addSubview(minimalUppercaseLabel)
        minimalUppercaseLabel.snp.makeConstraints { make in
            make.top.equalTo(minimalLowercaseLabel.snp.bottom).offset(5)
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
        
        textField.layer.borderColor = isValid ? Colors.blue.cgColor : UIColor.red.cgColor
        // if isvalid open safari
        if isValid {
            Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                var finalURLString = text
                if !text.hasPrefix("http://") && !text.hasPrefix("https://") {
                    finalURLString = "http://" + text
                }
                guard let url = URL(string: finalURLString) else {
                    return
                }
                UIApplication.shared.open(url)
            }
        }
    }
    
    
    
    
    
    
    
    
}
// MARK: - textfield
extension MainController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = Colors.inputGray.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // input no digits
        if textField == noDigitsInput {
            let characterSet = CharacterSet.decimalDigits
            return string.rangeOfCharacter(from: characterSet) == nil
        }
        
        // input count <= 10
        if textField == maxLengthInput {
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            
            if newLength > 10 {
                return false
            }
            
            maxLengthCountLabel.text = "\(newLength)/10"
            
            if newLength == 10 {
                maxLengthCountLabel.textColor = .red
            } else {
                maxLengthCountLabel.textColor = .black
            }
            return true
        }
        
        
        

        if textField == onlyCharactersInput {
            // Создайте экземпляр Veil с маской
            let mask = Veil(pattern: "*****-#####")

            // Получите текущий текст поля
            guard let currentText = textField.text else {
                return true
            }

            // Объедините текущий текст с добавленной строкой замены
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)

            // Удалите все символы, кроме букв и цифр
            _ = updatedText.filter { $0.isLetter || $0.isNumber }

            // Примените маску
            let maskedText = mask.mask(input: updatedText, exhaustive: false)

            // Установите отформатированный текст в поле
            textField.text = maskedText

            // Верните false, чтобы предотвратить автоматическую замену текста
            return false
        }

        
        
        
        
        
        
        
        
        // validation input
        if textField == validationInput {
            // Construct the new text with the replacement string
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            if updatedText.isEmpty {
                // Reset the UI to initial state
                textField.layer.borderColor = UIColor.systemBlue.cgColor
                
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
            
            // Update the UI based on the password validity
            updateLabel(minimalLengthLabel, isValid: isLengthValid, validText: "Min length 8 characters", invalidText: "Min length 8 characters")
            updateLabel(minimalDigitLabel, isValid: containsDigit, validText: "Min 1 digit", invalidText: "Min 1 digit")
            updateLabel(minimalLowercaseLabel, isValid: containsLowercaseLetter, validText: "Min 1 lowercase", invalidText: "Min 1 lowercase")
            updateLabel(minimalUppercaseLabel, isValid: containsUppercaseLetter, validText: "Min 1 uppercase", invalidText: "Min 1 uppercase")
            
            return true
        }
        return true
    }
    
    
    // Function to update label text and color
    private func updateLabel(_ label: UILabel, isValid: Bool, validText: String, invalidText: String) {
        label.text = isValid ? "✓ \(validText)" : "✕ \(invalidText)"
        label.textColor = isValid ? .systemBlue : .red
    }
    
    private func validatePasswordLength(_ password: String) -> Bool {
        let isPasswordValid = password.count >= 8
        return isPasswordValid
    }
    
    private func validatePasswordContainsDigit(_ password: String) -> Bool {
        let digitPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[0-9].*")
        return digitPredicate.evaluate(with: password)
    }
    
    private func validatePasswordContainsLowercase(_ password: String) -> Bool {
        let lowercasePredicate = NSPredicate(format: "SELF MATCHES %@", ".*[a-z].*")
        return lowercasePredicate.evaluate(with: password)
    }
    
    private func validatePasswordContainsUppercase(_ password: String) -> Bool {
        let uppercasePredicate = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z].*")
        return uppercasePredicate.evaluate(with: password)
    }
    
    
    
    
    
} // extension textfield



//
//
//
////изменить ифы на кейс и свитч
//extension MainController: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.layer.borderColor = Colors.blue.cgColor
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        textField.layer.borderColor = Colors.inputGray.cgColor
//    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        switch textField {
//        case noDigitsInput:
//            let characterSet = CharacterSet.decimalDigits
//            return string.rangeOfCharacter(from: characterSet) == nil
//
//        case maxLengthInput:
//            guard let text = textField.text else { return true }
//            let newLength = text.count + string.count - range.length
//
//            if newLength > 10 {
//                return false
//            }
//
//            maxLengthCountLabel.text = "\(newLength)/10"
//            maxLengthCountLabel.textColor = newLength == 10 ? .red : .black
//            return true
//
//        case onlyCharactersInput:
//            let regexPattern = "^[a-zA-Z]{5}-\\d{5}-.*$"
//            let inputString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
//            let isFormatValid = inputString.range(of: regexPattern, options: .regularExpression) != nil
//            return isFormatValid
//
//        case validationInput:
//            // Остальная часть вашего кода...
//            return true
//
//        default:
//            return true
//        }
//    }
//}
//
