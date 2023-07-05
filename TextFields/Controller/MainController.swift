//
//  MainController.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 20.06.2023.
//

import UIKit
import SnapKit

final class MainController: UIViewController {
    // MARK: Properties
    private let noDigitsView = NoDigitsView()
    private let maxLengthView = MaxLengthView()
    private let onlyCharactersView = OnlyCharactersView()
    private let urlView = URLView()
    private let passwordView = PasswordView()
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Text Fields"
        title.font = UIFont.systemFont(ofSize: 34, weight: .medium)
        title.textColor = Colors.black
        title.textAlignment = .center
        return title
    }()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setupScrollView()
        setupTapGestureRecognizer()
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    private let contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    private var contentSizeConstraint: NSLayoutConstraint!
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().priority(300)
            make.width.equalTo(scrollView.snp.width)
        }
        
        // add title
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(Constants.topOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(Constants.trailing)
        }
        // add no digits view
        contentView.addSubview(noDigitsView)
        noDigitsView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(Constants.trailing)
        }
        // add max length view
        contentView.addSubview(maxLengthView)
        maxLengthView.snp.makeConstraints { make in
            make.top.equalTo(noDigitsView.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(Constants.trailing)
        }
        // add only characters view
        contentView.addSubview(onlyCharactersView)
        onlyCharactersView.snp.makeConstraints { make in
            make.top.equalTo(maxLengthView.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(Constants.trailing)
        }
        // add URL view
        contentView.addSubview(urlView)
        urlView.snp.makeConstraints { make in
            make.top.equalTo(onlyCharactersView.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(Constants.trailing)
        }
        // add password view
        contentView.addSubview(passwordView)
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(urlView.snp.bottom).offset(Constants.Label.topOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(Constants.trailing)
        }
        contentSizeConstraint = contentView.bottomAnchor.constraint(equalTo: noDigitsView.bottomAnchor, constant: Constants.bottomOffset)
        contentSizeConstraint.isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentSizeConstraint.constant = view.frame.height
        scrollView.contentSize = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
// MARK: extension
extension MainController {
    private func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        view.endEditing(true)
    }
}
