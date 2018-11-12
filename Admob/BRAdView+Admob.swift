//
//  BRAdView+Admob.swift
//  BARO
//
//  Created by Jaehee Ko on 20/09/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import Foundation
import BARO
import GoogleMobileAds

extension BRAdView: GADUnifiedNativeAdDelegate {
  public func nativeAdDidRecordImpression(_ nativeAd: GADUnifiedNativeAd) {
  }

  public func nativeAdDidRecordClick(_ nativeAd: GADUnifiedNativeAd) {
    guard let ad = ad else { return }
    BRAdTracker().clicked(ad: ad)
  }
}
