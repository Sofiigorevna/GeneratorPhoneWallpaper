//
//  DetailViewController.swift
//  GeneratorPhoneWallpaper
//
//  Created by 1234 on 27.02.2024.
//

import UIKit
import Lottie

class DetailViewController: UIViewController {
    
    // MARK: - State
    
    let viewController = WallpaperViewController()
    let animationView = LottieAnimationView(name: "Aniki Hamster")
    weak var timer: Timer?
    private var remainingTime = 5
    
    var url = String()
    var textForRequest = String()
    
    // MARK: - Outlets
    
    private lazy var labelTime: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 22)
        label.textColor = .black
        label.numberOfLines =  1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //  MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = .purple
        setupHierarchy()
        setupLayout()
        startTimer()
        updateTimerLabel()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(animationView)
        view.addSubview(labelTime)
    }
    
    private func setupLayout() {
        animationView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(300)
        }
        
        labelTime.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(60)
            make.top.equalTo(170)
            make.leading.equalTo(40)
        }
    }
    
    private func setupLottieAnimation() {
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
    }
    
    //  MARK: - Methods
    
    func performServerRequest(text: String) {
        
        NetworkManager.sharedInstance.fetchAPIData(prompt: text) { [weak self] result in
            switch result {
            case .success(let data):
                guard let url = data.proxyLinks.first
                else {
                    return
                }
                
                self?.url = url
                self?.viewController.configuration(url: url)
                self?.stopTimer()
                self?.animationView.stop()
                self?.pushTransition()
            case .failure(let error):
                self?.showRetryAlert()
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Time
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if remainingTime > 0 {
            self.animationView.play()
            remainingTime -= 1
            updateTimerLabel()
        } else {
            stopTimer()
            self.labelTime.text = "we need a little more time"
        }
    }
    
    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
        self.remainingTime = 5
    }
    
    func updateTimerLabel() {
        let seconds = self.remainingTime % 60
        self.labelTime.text = "estimated time" + " " + String(format: "%02d", seconds) + " " + "sec"
    }
    
    //  MARK: - Methods
    
    func pushTransition() {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showRetryAlert() {
        let alertController = UIAlertController(title: "Ошибка", message: "Не удалось получить ответ от сервера. Повторить запрос?", preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Повторить", style: .default) { [weak self] (_) in
            // Повторение запроса
            guard let text = self?.textForRequest else {
                return
            }
            
            self?.performServerRequest(text: text)
            self?.startTimer()
            self?.updateTimerLabel()
        }
        alertController.addAction(retryAction)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { [weak self] (_) in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func config(text: String) {
        self.performServerRequest(text: text)
        self.textForRequest = text
    }
}

