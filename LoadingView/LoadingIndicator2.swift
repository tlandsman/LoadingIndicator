//
//  LoadingIndicator2.swift
//  LoadingView
//
//  Created by Tanya Landsman on 5/11/19.
//  Copyright © 2019 Tanya Landsman. All rights reserved.
//

import UIKit


class LoadingIndicator2: UIView {

    private let circleLayer = CAShapeLayer()
    
    let progressShape = CAShapeLayer()
    var percent = 0.75
    

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
            progressShape.add(rotationAnimation, forKey: "rotation")
        }
        else {
            progressShape.removeAnimation(forKey: "rotation")
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
        self.translatesAutoresizingMaskIntoConstraints = false
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressShape)
        
        updateAnimation()
    }
    
    
    func updateIndicator(with percent: Double) {
        let shortestSide = min(frame.size.width, frame.size.height)
        let strokeWidth: CGFloat = 10.0
        let frame = CGRect(x: 0, y: 0, width: shortestSide - strokeWidth, height: shortestSide - strokeWidth)
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        circleLayer.frame = frame
        circleLayer.path = UIBezierPath(ovalIn: circleLayer.frame).cgPath
        circleLayer.position = center
        circleLayer.strokeColor = UIColor.blue.cgColor
        circleLayer.lineWidth = strokeWidth
        circleLayer.fillColor = UIColor.clear.cgColor
        
        progressShape.frame = frame
        progressShape.path = circleLayer.path
        progressShape.position = circleLayer.position
        progressShape.strokeColor = UIColor.white.cgColor
        progressShape.opacity = 0.5
        progressShape.lineWidth = circleLayer.lineWidth
        progressShape.fillColor = UIColor.clear.cgColor
        progressShape.strokeEnd = CGFloat(percent)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateIndicator(with: percent)
    }
}
