//
//  BRBaiduMedationAdapter.swift
//  BARO
//
//  Created by Jaehee Ko on 04/09/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import Foundation
import DUModuleSDK

class BRBaiduMediationAdapter: BRMediationAdapter, DUNativeAdDelegate {
  var baiduNativeAdLoader: DUNativeAd!

  required init(ad: BRAd) {
    super.init(ad: ad)

    DUAdNetwork.setConsentStatus(true)
    DUAdNetwork.setLogLevel(.none)

    guard let appId = ad.creative.mediationPublisherId else { return }
    DUAdNetwork.initWithConfigDic(["native": [["pid": ad.creative.mediationPlacementId]]], withLicense: appId)
  }

  func load(userProfile: BRUserProfile? = nil, location: BRLocation? = nil, completion: @escaping (BRAd?, Error?) -> Void) {
    guard let placementId = ad.creative.mediationPlacementId else { return }

    BRLogger.log("Loading ad via Baidu mediation...")

    self.userProfile = userProfile
    self.location = location
    self.completion = completion

    baiduNativeAdLoader = DUNativeAd(placementID: placementId)
    baiduNativeAdLoader.delegate = self
    baiduNativeAdLoader.load()
  }

  func nativeAdDidLoad(_ nativeAd: DUNativeAd) {
    ad.creative.title = nativeAd.title
    ad.creative.description = nativeAd.shortDesc
    ad.creative.imageURL = nativeAd.imgeUrl
    ad.creative.iconURL = nativeAd.iconUrl
    ad.creative.callToAction = nativeAd.callToAction
    ad.mediatedAd = BRBaiduAd(ad: nativeAd)
    ad.isLoaded = ad.creative.imageURL != nil

    completion(ad, nil)
    completion = nil
  }

  func nativeAd(_ nativeAd: DUNativeAd, didFailWithError error: Error) {
    completion(nil, error)
    completion = nil
  }
}
