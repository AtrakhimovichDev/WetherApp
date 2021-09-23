//
//  ViewAnimation.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 23.09.21.
//

import UIKit

class ViewAnimation {

    weak var delegate: ViewAnimationDelegate?

    private var mainView: UIView
    private var movingView: UIView
    private var leftConstraint: NSLayoutConstraint
    private var rightConstraint: NSLayoutConstraint

    internal init(mainView: UIView,
                  movingView: UIView,
                  leftConstraint: NSLayoutConstraint,
                  rightConstraint: NSLayoutConstraint) {
        self.mainView = mainView
        self.movingView = movingView
        self.leftConstraint = leftConstraint
        self.rightConstraint = rightConstraint
    }

    func makeViewAnimation(startLocation: CGFloat, lastLocation: CGFloat) {
        if lastLocation < startLocation {
            if movingView.frame.minX < 0 {
                makeLeftSideAnimation()
            } else {
                makeNormaStateAnimation()
            }
        } else {
            if movingView.frame.maxX > mainView.frame.width {
                makeRightSideAnimation()
            } else {
                makeNormaStateAnimation()
            }
        }
    }

    private func makeLeftSideAnimation() {
       moveImageView(leftConstraint: -movingView.frame.width,
                     rightConstraint: mainView.frame.width,
                     alpha: 0) { [weak self] _ in
        self?.delegate?.updateData()
        self?.movingView.frame.origin.x = self?.mainView.frame.maxX ?? 0
        self?.makeNormaStateAnimation()
       }
    }

    private func makeRightSideAnimation() {
        moveImageView(leftConstraint: mainView.frame.maxX,
                      rightConstraint: -movingView.frame.width,
                      alpha: 0) { [weak self] _ in
         self?.delegate?.updateData()
         self?.movingView.frame.origin.x = -(self?.movingView.frame.width ?? 0)
         self?.makeNormaStateAnimation()
        }
    }

    private func makeNormaStateAnimation() {
        moveImageView(leftConstraint: 60,
                      rightConstraint: 60,
                      alpha: 1,
                      completion: nil)
    }

    private func moveImageView(leftConstraint: CGFloat,
                               rightConstraint: CGFloat,
                               alpha: CGFloat,
                               completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.leftConstraint.constant = leftConstraint
            self.rightConstraint.constant = rightConstraint
            self.movingView.alpha = alpha
            self.mainView.layoutIfNeeded()
        }, completion: completion)

    }
}
