//
//  TextFieldsUITests.swift
//  TextFieldsUITests
//
//  Created by SHIN MIKHAIL on 20.06.2023.
//

import XCTest

class OnlyCharactersViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    var onlyCharactersInput: XCUIElement!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()
        onlyCharactersInput = app.textFields["onlyCharactersInput"]
    }
    
    override func tearDownWithError() throws {
        app = nil
        onlyCharactersInput = nil
        
        try super.tearDownWithError()
    }
    
    func testOnlyCharactersInput() {
        onlyCharactersInput.tap()
        onlyCharactersInput.typeText("abc")
        XCTAssertEqual(onlyCharactersInput.value as? String, "abc") // only char

        onlyCharactersInput.typeText("123") // dig
        XCTAssertEqual(onlyCharactersInput.value as? String, "abc") // dig not added

        onlyCharactersInput.tap()
        onlyCharactersInput.press(forDuration: 1.0)
        onlyCharactersInput.typeText("defg-56789") // Вставка текста, содержащего символы и цифры
    }
}

