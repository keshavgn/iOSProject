//
//  CustomAlertView.swift
//  iOSProject
//
//  Created by Keshav on 21/02/18.
//  Copyright © 2018 Keshav. All rights reserved.
//

import UIKit

protocol CustomAlertViewDelegate {
    func didTapDoneButton()
    func didTapCancelButton()
}

final class CustomAlertView: UIView {
    
    var delegate: CustomAlertViewDelegate?
    var shouldShowCancel = true

    private var contentView: AlertView = {
        let subView = AlertView()
        return subView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        contentView.doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchDragInside)
        contentView.cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchDragInside)
        contentView.shouldShowCancel = shouldShowCancel
    }
    
    override func layoutSubviews() {
        let maxWidth: CGFloat = 300
        let width = frame.size.width - 40
        let subViewWidth = width > maxWidth ? maxWidth : width
        let subViewHeight: CGFloat = 180
        iOS_centerSubview(contentView, width: subViewWidth, height: subViewHeight)
    }
}

extension CustomAlertView {
    public func udpateTitle(title: String) {
        contentView.titleLabel.text = title
    }
    
    public func udpateDescription(description: String) {
        contentView.descriptionLabel.text = description
    }
    
    @objc private func doneButtonAction() {
        delegate?.didTapDoneButton()
    }
    
    @objc private func cancelButtonAction() {
        delegate?.didTapCancelButton()
    }
}

final class AlertView: UIView, Cardable {
    var maskedCarner: CACornerMask  = [.layerMinXMinYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private var lineView: UIView = {
        let subView = UIView()
        subView.backgroundColor = UIColor.gray
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()
    
    var doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("OK", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    private var dividerView: UIView = {
        let subView = UIView()
        subView.backgroundColor = UIColor.gray
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()
    
    var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("CANCEL", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    var shouldShowCancel = true
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.white
        setupUI()
    }
    
    override func layoutSubviews() {
        layoutCard()
    }
}

extension AlertView {
    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true

        addSubview(descriptionLabel)
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(lineView)
        lineView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        lineView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        lineView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true

        addSubview(doneButton)
        doneButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        doneButton.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        if shouldShowCancel {
            doneButton.widthAnchor.constraint(equalToConstant: frame.size.width/2).isActive = true
            
            addSubview(dividerView)
            dividerView.leftAnchor.constraint(equalTo: doneButton.rightAnchor, constant: 1).isActive = true
            dividerView.topAnchor.constraint(equalTo: doneButton.topAnchor).isActive = true
            dividerView.widthAnchor.constraint(equalToConstant: 1).isActive = true
            dividerView.bottomAnchor.constraint(equalTo: doneButton.bottomAnchor).isActive = true

            addSubview(cancelButton)
            cancelButton.leftAnchor.constraint(equalTo: doneButton.rightAnchor).isActive = true
            cancelButton.topAnchor.constraint(equalTo: doneButton.topAnchor).isActive = true
            cancelButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
            cancelButton.widthAnchor.constraint(equalTo: doneButton.widthAnchor).isActive = true
        } else {
            doneButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        }
    }
}
