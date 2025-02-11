//
//  ProgressBar.swift
//  AppLesson5
//
//  Created by Даниил Суханов on 11.02.2025.
//

import UIKit

fileprivate enum UIConstants {
    static let cornerRadius: CGFloat = 4
}

final class ProgressBar: UIView {
    private let minValue: CGFloat
    private let maxValue: CGFloat
    var currentValue: CGFloat {
        didSet {
            updateProgress()
        }
    }
    
    private let trackView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = UIConstants.cornerRadius
        return view
    }()
    
    private let progressView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = UIConstants.cornerRadius
        return view
    }()
    
    private var progressConstraint: NSLayoutConstraint?
    
    init(minValue: CGFloat, maxValue: CGFloat, currentValue: CGFloat) {
        
        self.minValue = minValue
        self.maxValue = maxValue
        self.currentValue = currentValue
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(trackView)
        trackView.addSubview(progressView)
        
        trackView.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            trackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            trackView.topAnchor.constraint(equalTo: topAnchor),
            trackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            progressView.leadingAnchor.constraint(equalTo: trackView.leadingAnchor),
            progressView.topAnchor.constraint(equalTo: trackView.topAnchor),
            progressView.bottomAnchor.constraint(equalTo: trackView.bottomAnchor)
        ])
        
        progressConstraint = progressView.widthAnchor.constraint(equalToConstant: 0)
        progressConstraint?.isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateProgress()
    }
    
    private func updateProgress() {
        progressView.backgroundColor = currentValue > maxValue ? .red : .green
        let clampedValue = currentValue.clamped(to: minValue...maxValue)
        let progress = (clampedValue - minValue) / (maxValue - minValue)
        let newWidth = trackView.bounds.width * progress
        progressConstraint?.constant = newWidth
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}

fileprivate extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}
