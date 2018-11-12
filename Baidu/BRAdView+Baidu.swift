//
//  BRAdView+Baidu.swift
//  BARO
//
//  Created by Jaehee Ko on 20/09/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import Foundation
import DUModuleSDK

extension BRAdView: DUNativeAdDelegate {
  public func nativeAdWillLogImpression(_ nativeAd: DUNativeAd) {
  }

  public func nativeAdDidClick(_ nativeAd: DUNativeAd) {
    guard let ad = ad else { return }
    BRAdTracker().clicked(ad: ad)
  }
}
