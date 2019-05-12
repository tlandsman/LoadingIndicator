//
//  LoadingIndicatorView.swift
//  LoadingView
//
//  Created by Tanya Landsman on 5/11/19.
//  Copyright © 2019 Tanya Landsman. All rights reserved.
//

import UIKit

class LoadingIndicatorView: UIView {

    private let circleLayer = CAShapeLayer()
    let progressShape = CAShapeLayer()
    var percent = 0.75
    
    private let strokeEndAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = 2.5
        group.repeatCount = MAXFLOAT
        group.animations = [animation]
        group.speed = 1.5
        
        return group
    }()
    
    private let strokeStartAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = 0.5
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = 1.5
        group.repeatCount = MAXFLOAT
        group.animations = [animation]
     
        
        return group
    }()
    
    private let rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 3
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
            circleLayer.add(strokeEndAnimation, forKey: "strokeEnd")
            circleLayer.add(strokeEndAnimation, forKey: "strokeStart")
            circleLayer.add(rotationAnimation, forKey: "rotation")
        }
        else {
            circleLayer.removeAnimation(forKey: "strokeEnd")
            circleLayer.removeAnimation(forKey: "strokeStart")
            circleLayer.removeAnimation(forKey: "rotation")
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
        
        circleLayer.lineWidth = 8
        circleLayer.fillColor = nil
        circleLayer.strokeColor = UIColor.blue.cgColor
        layer.addSublayer(circleLayer)
 
        updateAnimation()
    }
    
    private func configureCircle() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - circleLayer.lineWidth / 2
        let startAngle = CGFloat(Double.pi/2)
        let endAngle = startAngle + CGFloat(Double.pi * 2)
        let path = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        circleLayer.position = center
        circleLayer.path = path.cgPath
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCircle()
    }
}
