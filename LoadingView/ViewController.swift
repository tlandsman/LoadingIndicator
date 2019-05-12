//
//  ViewController.swift
//  LoadingView
//
//  Created by Tanya Landsman on 5/11/19.
//  Copyright © 2019 Tanya Landsman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    weak var loadingIndicatorView: LoadingIndicatorView!
    weak var loadingIndicatorView2: LoadingIndicator2!
    weak var loadingImageView: LoadingImageView!
    weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

    }

    override func loadView() {
         super.loadView()
        
        setupLoadingView()
        setupNavBarItems()
    }
    
    private func setupLoadingView() {
        // loader 1
        let loadingView1 = LoadingIndicatorView()
        loadingView1.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loadingView1.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.loadingIndicatorView = loadingView1

        // loader 2 using 2 circle shapes
        let loadingView2 = LoadingIndicator2()
        loadingView2.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loadingView2.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.loadingIndicatorView2 = loadingView2
    
        //loader 3 using image
        let loadingImage = LoadingImageView(frame: .zero)
        loadingImage.addConstraints([
            loadingImage.widthAnchor.constraint(equalTo: loadingImage.heightAnchor, multiplier: 1),
            loadingImage.heightAnchor.constraint(equalToConstant: 100)
            ])
        self.loadingImageView = loadingImage
        
        let stackView = UIStackView(frame: .zero)
            stackView.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(stackView)
        self.view.addConstraints([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            ])
        
        stackView.addArrangedSubview(loadingView1)
        stackView.addArrangedSubview(loadingView2)
        stackView.addArrangedSubview(loadingImage)
        stackView.axis = .vertical
        stackView.spacing = 20

        self.stackView = stackView

    }
    
    
    private func setupNavBarItems() {
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopLoading)), animated: true)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startLoading)), animated: true)
    }
    
    @objc func startLoading() {
        print("loading")
        loadingIndicatorView.shouldAnimate = true
        loadingIndicatorView2.shouldAnimate = true
        loadingImageView.shouldAnimate = true
    }
    
    @objc func stopLoading() {
        print("stop")
        loadingIndicatorView.shouldAnimate = false
        loadingIndicatorView2.shouldAnimate = false
        loadingImageView.shouldAnimate = false
    }
    

}

