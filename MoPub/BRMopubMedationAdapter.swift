//
//  BRMopubMedationAdapter.swift
//  BARO
//
//  Created by Jaehee Ko on 21/09/2018.
//  Copyright © 2018 Buzzvil. All rights reserved.
//

import Foundation
import MoPub

private var MopubInitialized: Bool = false

class BRMopubMediationAdapter: BRMediationAdapter {
  required init(ad: BRAd) {
    super.init(ad: ad)

    if !MopubInitialized, let placementId = ad.creative.mediationPlacementId {
      let sdkConfig = MPMoPubConfiguration(adUnitIdForAppInitialization: placementId)
      MoPub.sharedInstance().initializeSdk(with: sdkConfig, completion: nil)
      MoPub.sharedInstance().logLevel = MPLogLevelError
      MopubInitialized = true
    }
  }

  override func load(userProfile: BRUserProfile? = nil, location: BRLocation? = nil, completion: @escaping (BRAd?, Error?) -> Void) {
    guard let unitId = ad.creative.mediationPlacementId else { return }

    BRLogger.log("Loading ad via Mopub mediation...")

    self.userProfile = userProfile
    self.location = location

    let settings = MPStaticNativeAdRendererSettings()
    settings.renderingViewClass = BRAdView.self

    let config = MPStaticNativeAdRenderer.rendererConfiguration(with: settings)

    let targeting = MPNativeAdRequestTargeting()
    targeting.desiredAssets = [kAdTitleKey, kAdTextKey, kAdMainImageKey, kAdIconImageKey, kAdCTATextKey]

    guard let request = MPNativeAdRequest(adUnitIdentifier: unitId, rendererConfigurations: [config!]) else { return }
    request.targeting = targeting
    request.start { (_, nativeAd, error) in
      if let nativeAd = nativeAd, let properties = nativeAd.properties {
        self.ad.creative.title = properties[kAdTitleKey] as? String
        self.ad.creative.description = properties[kAdTextKey] as? String
        self.ad.creative.imageURL = properties[kAdMainImageKey] as? String
        self.ad.creative.callToAction = properties[kAdCTATextKey] as? String
        self.ad.creative.iconURL = properties[kAdIconImageKey] as? String
        print(properties.description)

        self.ad.mediatedAd = BRMopubAd(ad: nativeAd)
        self.ad.isLoaded = self.ad.creative.imageURL != nil
        completion(self.ad, nil)
      } else {
        completion(nil, error)
      }
    }
  }
}
