//
//  LoadingImageView.swift
//  LoadingView
//
//  Created by Tanya Landsman on 5/12/19.
//  Copyright © 2019 Tanya Landsman. All rights reserved.
//

import UIKit

class LoadingImageView: UIImageView {

    private let rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 1.5
        animation.repeatCount = MAXFLOAT
        return animation
    }()
    
    
    var shouldAnimate: Bool = false {
        didSet {
            updateAnimation()
        }
    }
    
    private func updateAnimation() {
        if shouldAnimate {
            self.layer.add(rotationAnimation, forKey: "rotation")
        }
        else {
            self.layer.removeAnimation(forKey: "rotation")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.image = UIImage(named: "loader")
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
