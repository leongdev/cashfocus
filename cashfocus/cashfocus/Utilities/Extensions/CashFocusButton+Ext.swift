//
//  FocusHeaderButton+Ext.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-22.
//

import UIKit

extension CashFocusButton {
  func startAnimationPressButton() {
    addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
    addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
  }
  
  @objc private func animateDown(sender: UIButton) {
    animate(sender, transform: CGAffineTransform.identity.translatedBy(x: 1, y: 3), shadowHeightOffdet: 0.0)
  }
   
  @objc private func animateUp(sender: UIButton) {
    animate(sender, transform: .identity, shadowHeightOffdet: 5.0)
  }
  
  private func animate(_ button: UIButton, transform: CGAffineTransform, shadowHeightOffdet: CGFloat) {
    UIView.animate(
      withDuration: 0.4,
      delay: 0,
      usingSpringWithDamping: 0.5,
      initialSpringVelocity: 3,
      options: [.curveEaseInOut],
      animations: {
      button.transform = transform
      button.layer.shadowOffset = CGSize(width: 0.0, height: shadowHeightOffdet)
    }, completion: nil)
  }
}
