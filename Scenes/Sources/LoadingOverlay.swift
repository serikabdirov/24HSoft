//
//  LoadingOverlay.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 02.07.2025.
//

import UIKit
import SnapKit

final class LoadingOverlay {
    static let shared = LoadingOverlay()

    private var overlayView = UIView()
    private var activityIndicator = UIActivityIndicatorView(style: .large)

    private init() {
        setupViews()
    }

    private func setupViews() {
        overlayView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        overlayView.alpha = 0
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(activityIndicator)

        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(overlayView)
        }
    }

    func show(over view: UIView) {
        guard overlayView.superview == nil else { return }

        overlayView.frame = view.bounds
        view.addSubview(overlayView)

        UIView.animate(withDuration: 0.25) {
            self.overlayView.alpha = 1
        }

        activityIndicator.startAnimating()
    }

    func hide() {
        UIView.animate(withDuration: 0.25, animations: {
            self.overlayView.alpha = 0
        }) { _ in
            self.activityIndicator.stopAnimating()
            self.overlayView.removeFromSuperview()
        }
    }
}
