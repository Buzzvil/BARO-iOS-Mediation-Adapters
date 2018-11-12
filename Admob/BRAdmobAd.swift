//
//  BRAdmobAd.swift
//  BARO
//
//  Created by Jaehee Ko on 20/09/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import Foundation
import BARO
import GoogleMobileAds

class BRAdmobAd: BRMediatedAd {
  let ad: GADUnifiedNativeAd

  init(ad: GADUnifiedNativeAd) {
    self.ad = ad
  }

  func registerView(view: BRAdView) {
    let admobAdView = GADUnifiedNativeAdView(frame: view.bounds)
    admobAdView.nativeAd = ad
    admobAdView.nativeAd?.delegate = view
    admobAdView.callToActionView = view.ctaButton
    admobAdView.tag = BRConfig.MEDIATION_AD_VIEW_TAG
    view.addSubview(admobAdView)
    view.ctaButton?.isUserInteractionEnabled = false
  }
}
