//
//  URLView.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 04.07.2023.
//

import UIKit
import SnapKit
import SafariServices

final class URLView: UIView {
    private let urlLabel: UILabel = {
        let label = UILabel()
        label.text = "Link"
        label.textColor = Colors.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let urlInput: UITextField = {
        let input = UITextField()
        input.borderStyle = .roundedRect
        input.font = UIFont.systemFont(ofSize: 17)
        input.textColor = Colors.black
        input.backgroundColor = Colors.inputGray
        input.layer.cornerRadius = 10
        input.clipsToBounds = true
        input.layer.borderWidth = 1.0
        input.layer.borderColor = Colors.inputGray.cgColor
        let placeholderText = "www.example.com"
        let placeholderFont = UIFont.systemFont(ofSize: 17)
        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [
            .foregroundColor: Colors.gray,
            .font: placeholderFont
        ])
        input.attributedPlaceholder = attributedPlaceholder
        input.returnKeyType = .go
        return input
    }()
    private var buttonTappedHandler: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupConstraints()
        setupTextFieldDelegate()
        setupTapGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        return nil
    }
    
    private func setupTextFieldDelegate() {
        urlInput.delegate = self
        urlInput.addTarget(self, action: #selector(validateUrl(_:)), for: .editingChanged)
    }
    
    private func setupConstraints() {
        addSubview(urlLabel)
        urlLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
        }
        addSubview(urlInput)
        urlInput.snp.makeConstraints { make in
            make.top.equalTo(urlLabel.snp.bottom).offset(Constants.Input.topOffset)
            make.edges.equalToSuperview().offset(0);
            make.height.equalTo(Constants.Input.height)
        }
    }
    
    private func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        endEditing(true)
    }
    
    @objc private func buttonTapped() {
        guard var text = urlInput.text else {
            return
        }
        // add prefix if www
        if !text.hasPrefix("http://") && !text.hasPrefix("https://") {
            text = "https://" + text
        }
        if let url = URL(string: text) {
            let safariViewController = SFSafariViewController(url: url)
            
            if let windowScene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                
                if let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
                    keyWindow.rootViewController?.present(safariViewController, animated: true, completion: nil)
                }
            }
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
            
            let domainSuffixes = [".com", ".org", ".gov", ".io", ".ua", ".ru"]
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
                textField.rightView = nil
                
                var urlString = text
                if !urlString.lowercased().hasPrefix("http://") && !urlString.lowercased().hasPrefix("https://") {
                    urlString = "https://" + urlString
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    if let url = URL(string: urlString) {
                        UIApplication.shared.open(url)
                    }
                }
            }
        } else {
            textField.rightView = nil
        }
    }
}

extension URLView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == urlInput {
            buttonTapped()
            return false
        } else {
            textField.resignFirstResponder()
            return true
        }
    }
    
}
