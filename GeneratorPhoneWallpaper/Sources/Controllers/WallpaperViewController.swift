//
//  WallpaperViewController.swift
//  GeneratorPhoneWallpaper
//
//  Created by 1234 on 29.02.2024.
//

import UIKit
import Kingfisher
import EasyTipView

class WallpaperViewController: UIViewController {
    
    var isHide: Bool = false
    var easyTipView: EasyTipView?
    var preferences = EasyTipView.Preferences()
    let feedBackGenerator = UIImpactFeedbackGenerator(style: .light)

    // MARK: - Outlets
    
    private lazy var picture: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var titleForTime: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 90)
        label.text = "22:00"
        label.numberOfLines =  1
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleForDate: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.text = "Friday, March 10"
        label.numberOfLines =  1
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackTitle: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleForDate,
                                                   titleForTime
                                                  ])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isHidden = true
        
        return stack
    }()
    
    lazy var savedButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 3.5
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(systemName: "arrow.down"), for: .normal)
        button.tintColor = .gray
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(saveButtonTapped),for: .touchUpInside)
        return button
    }()
    
    lazy var hideTitleButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 3.5
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .gray
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(hideTitleTime),for: .touchUpInside)
        return button
    }()
    
    lazy var backRootVCButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 3.5
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .gray
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(backButtonTapped),for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigationBar()
        setupHierarchy()
        setupLayout()
        setupEasyTipView()
        feedBackGenerator.prepare()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        easyTipView?.dismiss()
    }
    
    // MARK: - Setup
    
    func setupNavigationBar() {
        let back = UIBarButtonItem(customView: backRootVCButton)
        navigationItem.leftBarButtonItem = back
    }
    
    func setupEasyTipView() {
        preferences.drawing.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        preferences.drawing.foregroundColor = .white
        preferences.drawing.arrowPosition = .bottom
        easyTipView = EasyTipView(text: "Saved in gallery", preferences: preferences)
    }
    
    private func setupHierarchy() {
        view.addSubview(picture)
        picture.addSubview(stackTitle)
        picture.addSubview(savedButton)
        picture.addSubview(hideTitleButton)
    }
    
    private func setupLayout() {
        picture.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackTitle.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
        }
        
        savedButton.snp.makeConstraints { make in
            make.trailing.equalTo(-45)
            make.bottom.equalTo(-100)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        hideTitleButton.snp.makeConstraints { make in
            make.leading.equalTo(45)
            make.bottom.equalTo(-100)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        backRootVCButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
    }
    
    //  MARK: - Actions
    
    @objc func saveButtonTapped() {
        feedBackGenerator.impactOccurred()
        
        guard let image = picture.image else {
            return
        }
        
        saveImageToPhotoLibrary(image)
    }
    
    @objc func hideTitleTime() {
        if !isHide {
            stackTitle.isHidden = false
            hideTitleButton.setImage(UIImage(systemName: "eye"), for: .normal)
            isHide = true
        }
        else {
            stackTitle.isHidden = true
            hideTitleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            isHide = false
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    //  MARK: - Methods
    
    func configuration(url: String) {
        DownloadImgManager.setImage(
            with: URL(string: url),
            imageView: picture)
    }
    
    func showToolTip() {
            self.easyTipView?.show(forView: self.savedButton)
        Timer.scheduledTimer(
            withTimeInterval: 2.0,
            repeats: false) { [weak self] timer in
            self?.easyTipView?.dismiss()
        }
    }
    
    func saveImageToPhotoLibrary(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(
            image,
            self,
            #selector(imageCheck),
            nil)
            }
    
    @objc func imageCheck(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
            ShowAlert.shared.alert(
                view: self,
                title: "Oooops",
                message: "An error occurred, repeat the operation")
        } else {
            print("Изображение успешно сохранено в галерею")
            showToolTip()

        }
    }
}

