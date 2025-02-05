//
//  ProfileViewController.swift
//  AppLesson5
//
//  Created by Даниил Суханов on 05.02.2025.
//

import UIKit

private enum UserInfo {
    static let name = "Федор Конюхов"
    static let bio = "Ну, наверное, в описании не нуждается"
}

private enum UIConstants {
    static let cardCornerRadius: CGFloat = 32
    static let cardShadowOpacity: Float = 0.1
    static let cardShadowRadius: CGFloat = 8
    static let cardShadowOffset: CGSize = CGSize(width: 0, height: -3)
    
    static let collectionItemSize: CGSize = CGSize(width: 150, height: 150)
    static let collectionMinimumInteritemSpacing: CGFloat = 12
    static let collectionMinimumLineSpacing: CGFloat = 16
    static let collectionSectionInset: UIEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 16, right: 16)
    
    static let profileStackSpacing: CGFloat = 16
    static let profileStackPadding: CGFloat = 24
    static let avatarImageSize: CGFloat = 80
    
    static let cardDefaultBottomConstant: CGFloat = 50
    static let collectionHiddenAlpha: CGFloat = 0
    static let leadingInset: CGFloat = 16
    static let cardViewHeight: CGFloat = 200
}

class ProfileViewController: UIViewController {
    
    private var cardBottomConstraint: NSLayoutConstraint!
    private var isCardCollapsed = true
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = UIConstants.cardCornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = UIConstants.cardShadowOpacity
        view.layer.shadowRadius = UIConstants.cardShadowRadius
        view.layer.shadowOffset = UIConstants.cardShadowOffset
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = UserInfo.name
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let boiLabel: UILabel = {
        let label = UILabel()
        label.text = UserInfo.bio
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.alpha = UIConstants.collectionHiddenAlpha
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupUI()
    }
    
    private func setupUI() {
        let profileStackView: UIStackView = UIStackView(arrangedSubviews: [avatarImageView, nameLabel, boiLabel])
        profileStackView.axis = .vertical
        profileStackView.spacing = UIConstants.profileStackSpacing
        profileStackView.alignment = .center
        profileStackView.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.addSubview(profileStackView)
        view.addSubview(cardView)
        
        cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlerCardTop)))
        
        let nameLabelHeight = nameLabel.intrinsicContentSize.height
        let stackViewBottomPadding: CGFloat = 16
        let initialCardPosition = -(nameLabelHeight + stackViewBottomPadding + view.safeAreaInsets.bottom)
        cardBottomConstraint = cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: initialCardPosition)
        
        NSLayoutConstraint.activate([
            cardBottomConstraint,
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: initialCardPosition),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.leadingInset),
            cardView.heightAnchor.constraint(equalToConstant: UIConstants.cardViewHeight),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.leadingInset),
            
            profileStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: UIConstants.profileStackPadding),
            profileStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -UIConstants.profileStackPadding),
            profileStackView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            
            avatarImageView.widthAnchor.constraint(equalToConstant: UIConstants.avatarImageSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: UIConstants.avatarImageSize)
            
        ])
    }
    
    @objc func handlerCardTop() {
        isCardCollapsed.toggle()
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
            if self.isCardCollapsed {
                let nameLabelHeight = self.nameLabel.intrinsicContentSize.height
                let stackViewBottomPadding: CGFloat = 16
                let targetPosition = -(nameLabelHeight + stackViewBottomPadding + self.view.safeAreaInsets.bottom)
                self.cardBottomConstraint.constant = targetPosition
            } else {
                self.cardBottomConstraint.constant = -(self.view.frame.height - self.view.safeAreaInsets.top - UIConstants.cardViewHeight)
            }
            
            self.boiLabel.alpha = self.isCardCollapsed ? 0 : 1
            
            self.view.layoutIfNeeded()
        }
    }


}

