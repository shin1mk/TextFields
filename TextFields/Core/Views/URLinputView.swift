////
////  URLinput.swift
////  TextFields
////
////  Created by SHIN MIKHAIL on 01.07.2023.
////
//
//import UIKit
//import SnapKit
//import SafariServices
//
//final class URLinputView: UIView, UITextFieldDelegate {
//    private let urlLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Link"
//        label.textColor = Colors.black
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 17)
//        return label
//    }()
//    private let urlInput: UITextField = {
//        let input = UITextField()
//        input.borderStyle = .roundedRect
//        input.font = UIFont.systemFont(ofSize: 17)
//        input.textColor = Colors.black
//        input.backgroundColor = Colors.inputGray
//        input.layer.cornerRadius = 10
//        input.clipsToBounds = true
//        input.layer.borderWidth = 1.0
//        input.layer.borderColor = Colors.inputGray.cgColor
//        let placeholder = "www.example.com"
//        let placeholderFont = UIFont.systemFont(ofSize: 17)
//        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
//            .foregroundColor: Colors.lightGray,
//            .font: placeholderFont
//        ])
//        input.attributedPlaceholder = attributedPlaceholder
//        input.returnKeyType = .go
//        //        setupUrlInputTarget(for: textFieldURL)
//        //        input.addTarget(self, action: #selector(urlInputChanged), for: .editingChanged)
//        return input
//    }()
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//        setupConstraints()
//        setupTextFieldDelegate()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    private func setupTextFieldDelegate() {
//        urlInput.delegate = self
//    }
//
//    @objc private func buttonTapped() {
//        guard var text = urlInput.text else {
//            return
//        }
//        // add prefix if www
//        if !text.hasPrefix("http://") && !text.hasPrefix("https://") {
//            text = "http://" + text
//        }
//        if let url = URL(string: text) {
//               let safariViewController = SFSafariViewController(url: url)
//               MainController.present(safariViewController, animated: true, completion: nil)
//           }
//    }
//
//    private func setupConstraints() {
//        addSubview(urlLabel)
//        urlLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(Constants.Label.topOffset)
//            make.leading.equalToSuperview().offset(Constants.leading)
//        }
//        addSubview(urlInput)
//        urlInput.snp.makeConstraints { make in
//            make.top.equalTo(urlLabel.snp.bottom).offset(Constants.Input.topOffset)
//            make.leading.trailing.equalToSuperview().inset(Constants.leading)
//            make.height.equalTo(Constants.Input.height)
//        }
//    }
//}
//extension URLinputView {
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text == textField.text else { return }
//        // prefix
//        let urlRegex = "^(http://)?(https://)?(www\\.)?([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?([a-zA-Z]{2})?$"
//        let urlPredicate = NSPredicate(format: "SELF MATCHES %@", urlRegex)
//        let isValid = urlPredicate.evaluate(with: text)
//
//        textField.layer.borderColor = isValid ? Colors.blue.cgColor : Colors.red.cgColor
//
//        if isValid {
//            textField.rightViewMode = .always
//
//            let domainSuffixes = [".com", ".org", ".gov", ".io", ".ua", ".ru"]
//            var suffixFound = false
//            //if suffix has
//            for suffix in domainSuffixes {
//                if text.lowercased().hasSuffix(suffix) {
//                    suffixFound = true
//                    break
//                }
//            }
//            // if suffix found start counter
//            if suffixFound {
//                textField.rightView = nil
//
//                var urlString = text
//                if !urlString.lowercased().hasPrefix("http://") && !urlString.lowercased().hasPrefix("https://") {
//                    urlString = "http://" + urlString
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                    if let url = URL(string: urlString) {
//                        UIApplication.shared.open(url)
//                    }
//                }
//            }
//        } else {
//            textField.rightView = nil
//        }
//    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == urlInput {
//            buttonTapped()
//        } else {
//            textField.resignFirstResponder()
//        }
//        return true
//    }
//
//    private func updateLabel(_ label: UILabel, isValid: Bool, validText: String) {
//        label.textColor = isValid ? Colors.systemBlue : .red
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.layer.borderColor = Colors.blue.cgColor
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        textField.layer.borderColor = Colors.inputGray.cgColor
//    }
//}
