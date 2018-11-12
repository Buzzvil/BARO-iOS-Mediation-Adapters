//
//  BRMopubAd.swift
//  BARO
//
//  Created by Jaehee Ko on 21/09/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import Foundation
import MoPub

class BRMopubAd: BRMediatedAd {
  let ad: MPNativeAd

  init(ad: MPNativeAd) {
    self.ad = ad
  }

  func registerView(view: BRAdView) {
    if let containerView = try? ad.retrieveAdView(), let _ = containerView.subviews.first as? BRAdView {
      containerView.frame = view.bounds
      containerView.tag = BRConfig.MEDIATION_AD_VIEW_TAG
      view.insertSubview(containerView, at: 0)
      view.ctaButton?.isUserInteractionEnabled = false
    }
    ad.delegate = view
  }
}
