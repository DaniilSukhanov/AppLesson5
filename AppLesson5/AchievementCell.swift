//
//  AchievementCell.swift
//  AppLesson5
//
//  Created by Даниил Суханов on 05.02.2025.
//

import UIKit

private enum UIConstants {
    static let cornerRadius: CGFloat = 16
    static let shadowOpacity: Float = 0.1
    static let shadowRadius: CGFloat = 4
    static let shadowOffset: CGSize = CGSize(width: 0, height: 2)
    static let imageHeight: CGFloat = 60
    static let stackSpacing: CGFloat = 8
    static let stackPadding: CGFloat = 8
    static let titleLabelFont: UIFont = .systemFont(ofSize: 14, weight: .semibold)
    static let titleLabelTextColor: UIColor = .black
    static let coefficientWidthPadding: CGFloat = 0.1
    static let coefficientHeightPadding: CGFloat = 0.05
    static let coefficientScalePinch: CGFloat = 1.5
    static let coefficientScaleClosePinch: CGFloat = 0.5
}

class AchievementCell: UICollectionViewCell {
    private var achievement: Achievement?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .gray
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.titleLabelFont
        label.textColor = UIConstants.titleLabelTextColor
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = UIConstants.titleLabelTextColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(handlePinch)))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = UIConstants.cornerRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = UIConstants.shadowOpacity
        layer.shadowRadius = UIConstants.shadowRadius
        layer.shadowOffset = UIConstants.shadowOffset
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = UIConstants.stackSpacing
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.stackPadding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.stackPadding),
            imageView.heightAnchor.constraint(equalToConstant: UIConstants.imageHeight)
        ])
    }
    
    func configure(with achievement: Achievement) {
        titleLabel.text = achievement.title
        imageView.image = UIImage(systemName: achievement.iconName)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = achievement.color
        self.achievement = achievement
    }
}

private extension AchievementCell {
    func showDetailView(for achievement: Achievement) {
        guard let window else {
            return
        }
        let invisibilityView = UIView()
        invisibilityView.translatesAutoresizingMaskIntoConstraints = false
        
        let detailView = AchievementDetailView()
        detailView.layer.opacity = 0
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        window.addSubview(invisibilityView)
        invisibilityView.addSubview(detailView)
        detailView.configure(with: achievement)
        
        let widthPadding = window.frame.width * UIConstants.coefficientWidthPadding
        let heightPadding = window.frame.height * UIConstants.coefficientHeightPadding
        NSLayoutConstraint.activate([
            invisibilityView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            invisibilityView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            invisibilityView.topAnchor.constraint(equalTo: window.topAnchor),
            invisibilityView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
            
            detailView.leadingAnchor.constraint(equalTo: invisibilityView.leadingAnchor, constant: widthPadding),
            detailView.trailingAnchor.constraint(equalTo: invisibilityView.trailingAnchor, constant: -widthPadding),
            detailView.topAnchor.constraint(equalTo: invisibilityView.topAnchor, constant: heightPadding),
            detailView.bottomAnchor.constraint(equalTo: invisibilityView.bottomAnchor, constant: -heightPadding)
        ])
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handleClosePinch))
        invisibilityView.addGestureRecognizer(pinchGesture)
        
        UIView.animate(withDuration: 0.5) {
            detailView.layer.opacity = 1
        }
    }
    
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let achievement else {
            return
        }
        if gesture.state == .ended && gesture.scale > UIConstants.coefficientScalePinch {
            showDetailView(for: achievement)
        }
    }
    
    @objc func handleClosePinch(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .ended && gesture.scale < UIConstants.coefficientScaleClosePinch {
            UIView.animate(withDuration: 0.5) {
                gesture.view?.layer.opacity = 0
            } completion: { _ in
                gesture.view?.removeFromSuperview()
            }
            
        }
    }
}
