//
//  AchievementDetailView.swift
//  AppLesson5
//
//  Created by Даниил Суханов on 10.02.2025.
//

import UIKit

fileprivate enum UIConstants {
    enum CornerRadius {
        static let base: CGFloat = 16
    }
    
    enum Shadow {
        static let color: CGColor = UIColor.black.cgColor
        static let opacity: Float = 0.1
        static let radius: CGFloat = 8
        static let offset = CGSize(width: 0, height: -3)
    }
    
    enum Layout {
        static let horizontalMargin: CGFloat = 16
        static let verticalSpacingBase: CGFloat = 16
        static let verticalSpacingSmall: CGFloat = 8
        static let topMargin: CGFloat = 16
        static let progressBarHeight: CGFloat = 8
    }
    
    enum ImageViewSize {
        static let icon: CGFloat = 80
    }
    
    enum Other {
        static let progressBarMinValue = 0.0
        static let progressBarMaxValue = 100.0
        static let progressBarDefaultValue = 0.0
    }
}

final class AchievementDetailView: UIView {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressBar = ProgressBar(
        minValue: UIConstants.Other.progressBarMinValue,
        maxValue: UIConstants.Other.progressBarMaxValue,
        currentValue: UIConstants.Other.progressBarDefaultValue
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        layer.cornerRadius = UIConstants.CornerRadius.base
        layer.shadowColor = UIConstants.Shadow.color
        layer.shadowOpacity = UIConstants.Shadow.opacity
        layer.shadowRadius = UIConstants.Shadow.radius
        layer.shadowOffset = UIConstants.Shadow.offset
        
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(progressBar)
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: UIConstants.Layout.topMargin
            ),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.widthAnchor.constraint(
                equalToConstant: UIConstants.ImageViewSize.icon
            ),
            iconImageView.heightAnchor.constraint(
                equalToConstant: UIConstants.ImageViewSize.icon
            ),
            
            titleLabel.topAnchor.constraint(
                equalTo: iconImageView.bottomAnchor,
                constant: UIConstants.Layout.verticalSpacingBase
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: UIConstants.Layout.horizontalMargin
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -UIConstants.Layout.horizontalMargin
            ),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: UIConstants.Layout.verticalSpacingSmall
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: UIConstants.Layout.horizontalMargin
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -UIConstants.Layout.horizontalMargin
            ),
            
            progressBar.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: UIConstants.Layout.verticalSpacingBase
            ),
            progressBar.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: UIConstants.Layout.horizontalMargin
            ),
            progressBar.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -UIConstants.Layout.horizontalMargin
            ),
            progressBar.heightAnchor.constraint(equalToConstant: UIConstants.Layout.progressBarHeight),
            progressBar.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -UIConstants.Layout.topMargin
            )
        ])
    }
    
    func configure(with achievement: Achievement) {
        iconImageView.image = UIImage(systemName: achievement.iconName)
        titleLabel.text = achievement.title
        descriptionLabel.text = achievement.description
        progressBar.currentValue = CGFloat(achievement.progressBar)
    }
}
