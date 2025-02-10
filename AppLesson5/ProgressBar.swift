//
//  ProgressBar.swift
//  AppLesson5
//
//  Created by Даниил Суханов on 11.02.2025.
//

import UIKit

final class ProgressBar: UIView {
    private let minValue: CGFloat
    private let maxValue: CGFloat
    var currentValue: CGFloat {
        didSet {
            let width = frame.width * currentValue / maxValue
            lineViewWidthAnchor?.constant = width > frame.width ? frame.width : width
        }
    }
    private var lineViewWidthAnchor: NSLayoutConstraint?
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    init(minValue: CGFloat = 0, maxValue: CGFloat = 100, currentValue: CGFloat = 0) {
        self.minValue = minValue
        self.maxValue = maxValue
        self.currentValue = currentValue
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)
        let width = frame.width * currentValue / maxValue
        lineViewWidthAnchor = lineView.widthAnchor.constraint(equalToConstant: width > frame.width ? frame.width : width)
        lineViewWidthAnchor?.isActive = true
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.topAnchor.constraint(equalTo: topAnchor),
            lineView.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
}
