//
//  MainView.swift
//  GeneratorPhoneWallpaper
//
//  Created by 1234 on 27.02.2024.
//

import SnapKit
import UIKit

final class MainView: UIView {
    
    
    typealias CompletionBlock = () -> Void
    var onCompletion: CompletionBlock?

    
    // MARK: - Outlets
    
     lazy var textField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Search your picture...")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
     lazy var imageButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 3.5
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "violet")
        button.frame = CGRect(x: 16, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(buttonTapped),for: .touchUpInside)
        return button
    }()
    
    let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 30))
    

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarhy()
        setupLayout()
        setupTextField()
        keyboardAppear()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error in MainView")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit NotificationCenter")
    }
    
    // MARK: - Setup
    
    private func setupHierarhy() {
        self.addSubview(textField)
    }
    
    private func setupLayout() {
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(620)
            make.width.equalTo(350)
            make.height.equalTo(45)
        }
    }
    
    private func setupTextField() {
        rightView.addSubview(imageButton)
        textField.rightView = rightView
        textField.rightViewMode = .always
    }
    //  MARK: - Actions

    @objc func buttonTapped() {
        self.onCompletion?()
    }
    
    //  MARK: - Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setGradientBackground() {
        let violet = UIColor(named: "violet")?.cgColor ?? UIColor.purple.cgColor
        let black = UIColor.black.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [violet, black]
        gradientLayer.locations = [0.0, 0.5]
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at:0)
    }
    
    // MARK: - Keyboard appear funcs
    
    func keyboardAppear() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(sender:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(sender:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        textField.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(450)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        textField.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(620)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}



