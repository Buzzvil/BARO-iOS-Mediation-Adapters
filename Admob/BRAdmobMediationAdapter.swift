//
//  BRAdmobMediationAdapter.swift
//  BARO
//
//  Created by Jaehee Ko on 04/09/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import Foundation
import BARO
import GoogleMobileAds

private var GADMobileAdsConfigured: Bool = false

class BRAdmobMediationAdapter: BRMediationAdapter, GADUnifiedNativeAdLoaderDelegate {
  var adLoader: GADAdLoader!

  required init(ad: BRAd) {
    super.init(ad: ad)

    guard let applicationId = ad.creative.mediationPublisherId else { return }
    if !GADMobileAdsConfigured {
      GADMobileAds.configure(withApplicationID: applicationId)
      GADMobileAdsConfigured = true
    }
  }

  override func load(userProfile: BRUserProfile? = nil, location: BRLocation? = nil, completion: @escaping (BRAd?, Error?) -> Void) {
    guard let unitId = ad.creative.mediationPlacementId else { return }

    BRLogger.log("Loading ad via Admob mediation...")

    self.userProfile = userProfile
    self.location = location
    self.completion = completion

    let imageLoadOptions = GADNativeAdImageAdLoaderOptions()
    imageLoadOptions.disableImageLoading = true

    adLoader = GADAdLoader(adUnitID: unitId,
                           rootViewController: nil,
                           adTypes: [GADAdLoaderAdType.unifiedNative],
                           options: [imageLoadOptions])
    adLoader.delegate = self
    adLoader.load(GADRequest())
  }

  func adLoader(_ adLoader: GADAdLoader,
                didReceive nativeAd: GADUnifiedNativeAd) {
    ad.creative.title = nativeAd.headline
    ad.creative.description = nativeAd.body
    ad.creative.callToAction = nativeAd.callToAction

    if let imageURL = nativeAd.images?.first?.imageURL {
      ad.creative.imageURL = imageURL.absoluteString
    }

    if let iconURL = nativeAd.icon?.imageURL {
      ad.creative.iconURL = iconURL.absoluteString
    }
    ad.mediatedAd = BRAdmobAd(ad: nativeAd)
    ad.isLoaded = ad.creative.imageURL != nil

    completion(ad, nil)
    completion = nil
  }

  func adLoaderDidFinishLoading(_ adLoader: GADAdLoader) {
    // The adLoader has finished loading ads, and a new request can be sent.
  }

  func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
    completion(nil, error)
    completion = nil
  }
}
