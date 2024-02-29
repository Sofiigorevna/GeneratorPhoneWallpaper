//
//  CustomTextField.swift
//  GeneratorPhoneWallpaper
//
//  Created by 1234 on 27.02.2024.
//

import UIKit

final class CustomTextField: UITextField {
    
    // MARK: - State
    
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 55)
    
    // MARK: - Initializers
    init(placeholder: String) {
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error in CustomTextField")
    }
    
    // MARK: - Override methods
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    // MARK: - Methods

    private func setupTextField(placeholder: String) {
        textColor = .white
        keyboardType = .webSearch
        backgroundColor = .black
        layer.cornerRadius = 14
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.5
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        font = UIFont(name: "SignikaNegative-VariableFont_wght", size: 12)

    }
}
