//
//  TextFieldsTests.swift
//  TextFieldsTests
//
//  Created by SHIN MIKHAIL on 20.06.2023.
//

import XCTest
@testable import TextFields

class PasswordValidatorTests: XCTestCase {

    func testValidatePasswordLength() {
        XCTAssertTrue(PasswordValidator.validatePasswordLength("passwordpassword"))
        XCTAssertFalse(PasswordValidator.validatePasswordLength("pass"))
    }

    func testValidatePasswordContainsDigit() {
        XCTAssertTrue(PasswordValidator.validatePasswordContainsDigit("password123"))
        XCTAssertFalse(PasswordValidator.validatePasswordContainsDigit("password"))
    }

    func testValidatePasswordContainsLowercase() {
        XCTAssertTrue(PasswordValidator.validatePasswordContainsLowercase("password"))
        XCTAssertFalse(PasswordValidator.validatePasswordContainsLowercase("PASSWORD"))
    }

    func testValidatePasswordContainsUppercase() {
        XCTAssertTrue(PasswordValidator.validatePasswordContainsUppercase("PASSWORD"))
        XCTAssertFalse(PasswordValidator.validatePasswordContainsUppercase("password"))
    }
}
