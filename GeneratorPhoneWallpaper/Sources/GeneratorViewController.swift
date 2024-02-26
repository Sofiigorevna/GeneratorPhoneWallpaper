//
//  ViewController.swift
//  GeneratorPhoneWallpaper
//
//  Created by 1234 on 25.02.2024.
//

import UIKit

class GeneratorViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .webSearch
        textField.placeholder = "Search..."
        textField.backgroundColor = .systemBrown
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.clearButtonMode = .whileEditing
        return textField
    }()

    //  MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
    }

    // MARK: - Setup
    
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
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }

}

