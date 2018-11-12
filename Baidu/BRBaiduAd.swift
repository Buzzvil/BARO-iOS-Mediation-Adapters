//
//  BRBaiduAd.swift
//  BARO
//
//  Created by Jaehee Ko on 20/09/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import Foundation
import DUModuleSDK

class BRBaiduAd: BRMediatedAd {
  let ad: DUNativeAd

  init(ad: DUNativeAd) {
    self.ad = ad
  }

  func registerView(view: BRAdView) {
    ad.delegate = view
    ad.registerView(forInteraction: view, with: nil, withClickableViews: [view.ctaButton!, view.iconImageView!])
  }
}
