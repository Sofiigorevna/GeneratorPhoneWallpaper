//
//  ViewController.swift
//  GeneratorPhoneWallpaper
//
//  Created by 1234 on 25.02.2024.
//

import UIKit

class GeneratorViewController: UIViewController {
    
    var text = "the cute white cat portrait ((beautiful pale cyberpunk female with heavy black eyeliner)), blue eyes, shaved side haircut, hyper detail, cinematic lighting, magic neon, dark red city"
    
    // MARK: - State
    
    private var mainView = MainView()
    
    //  MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        mainView.textField.delegate = self
        pushTransition()
        navigationController?.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        mainView.setGradientBackground()
    }
    
    //  MARK: - Actions
    
    func pushTransition() {
        mainView.onCompletion = { [weak self] in
            guard let self else {
                return
            }
            
            if self.mainView.textField.text == "" {
                
            ShowAlert.shared.alert(view: self, title: "Nothing was written", message: "Please enter your request in the text field")
                
            } else {
                let viewController = DetailViewController()
                viewController.config(text: self.mainView.textField.text!)
                self.navigationController?.pushViewController(viewController, animated: true)
                self.mainView.textField.text = ""
                
            }
        }
    }
}

extension GeneratorViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(GeneratorViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }
}

extension GeneratorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        self.pushTransition()
        
        return true
    }
}

extension GeneratorViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return PushTransition()
        }
        return nil
    }
}


