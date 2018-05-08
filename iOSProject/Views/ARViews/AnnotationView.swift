//
//  AnnotationView.swift
//  iOSProject
//
//  Created by Keshav on 27/03/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit
import HDAugmentedReality

protocol AnnotationViewDelegate {
    func didTouch(annotationView: AnnotationView)
}

class AnnotationView: ARAnnotationView {
    var delegate: AnnotationViewDelegate?
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
        label.textColor = UIColor.white
        return label
    }()
    var distanceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
        label.textColor = UIColor.green
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        loadUI()
    }
    
    func loadUI() {
        titleLabel.removeFromSuperview()
        distanceLabel.removeFromSuperview()
        addSubview(titleLabel)
        addSubview(distanceLabel)
        
        if let annotation = annotation as? Place {
            titleLabel.text = annotation.place
            distanceLabel.text = String(format: "%.2f km", annotation.distanceFromUser / 1000)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 10, y: 0, width: self.frame.size.width, height: 30)
        distanceLabel.frame = CGRect(x: 10, y: 30, width: self.frame.size.width, height: 20)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.didTouch(annotationView: self)
    }
}
