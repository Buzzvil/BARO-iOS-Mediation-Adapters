//
//  BRAdView+Mopub.swift
//  BARO
//
//  Created by Jaehee Ko on 21/09/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import Foundation
import MoPub

private func viewController(_ view: UIView) -> UIViewController {
  var responder: UIResponder? = view
  while !(responder is UIViewController) {
    responder = responder?.next
    if nil == responder {
      break
    }
  }
  return (responder as? UIViewController)!
}

extension BRAdView: MPNativeAdRendering, MPNativeAdDelegate {
  public func viewControllerForPresentingModalView() -> UIViewController! {
    return viewController(self)
  }

  public func willPresentModal(for nativeAd: MPNativeAd!) {
    ctaClicked(ctaButton!)
  }

  public func nativeTitleTextLabel() -> UILabel! {
    return titleLabel
  }

  public func nativeMainTextLabel() -> UILabel! {
    return descriptionLabel
  }

  public func nativeMainImageView() -> UIImageView! {
    return imageView
  }

  public func nativeIconImageView() -> UIImageView! {
    return iconImageView
  }

  public func nativeCallToActionTextLabel() -> UILabel! {
    return ctaButton?.titleLabel
  }

  public func nativePrivacyInformationIconImageView() -> UIImageView! {
    return adchoiceButton?.imageView
  }
}
