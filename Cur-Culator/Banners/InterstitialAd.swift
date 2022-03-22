//
//  InterstitialAd.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 22/3/22.
//

import GoogleMobileAds
import UIKit
import SwiftUI
import WebKit

class InterstitialAd: NSObject {
    var interstitialAd: GADInterstitialAd?

    //Want to have one instance of the ad for the entire app
    //We can do this b/c you will never show more than 1 ad at once so only 1 ad needs to be loaded
    static let shared = InterstitialAd()

    func loadAd(withAdUnitId id: String) {
        let req = GADRequest()
        GADInterstitialAd.load(withAdUnitID: id, request: req) { interstitialAd, err in
            if let err = err {
                print("Failed to load ad with error: \(err)")
                return
            }

            self.interstitialAd = interstitialAd
        }
    }
}

final class InterstitialAdView: NSObject, UIViewControllerRepresentable, GADFullScreenContentDelegate {

    //Here's the Ad Object we just created
    let interstitialAd = InterstitialAd.shared.interstitialAd
    @Binding var isPresented: Bool
    @Binding var showingPopover: Bool

    var adUnitId: String

    init(isPresented: Binding<Bool>, showingPopover: Binding<Bool>, adUnitId: String) {
        self._isPresented = isPresented
        self._showingPopover = showingPopover

        self.adUnitId = adUnitId
        super.init()

        interstitialAd?.fullScreenContentDelegate = self //Set this view as the delegate for the ad
    }

    //Make's a SwiftUI View from a UIViewController
    func makeUIViewController(context: Context) -> UIViewController {
        let view = UIViewController()

        //Show the ad after a slight delay to ensure the ad is loaded and ready to present
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
            self.showAd(from: view)
        }

        return view
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }

    //Presents the ad if it can, otherwise dismisses so the user's experience is not interrupted
    func showAd(from root: UIViewController) {

        if let ad = interstitialAd {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                print("Showing full screen ad")
                ad.present(fromRootViewController: (UIApplication.shared.windows.last?.rootViewController)!)
            }
        } else {
            print("Ad not ready")
            self.isPresented.toggle()
            self.showingPopover.toggle()
        }
    }
    /// Tells the delegate that the ad failed to present full screen content.
      func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
          print(error.localizedDescription)
      }

      /// Tells the delegate that the ad will present full screen content.
      func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
      }

      

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        //Prepares another ad for the next time view presented
        InterstitialAd.shared.loadAd(withAdUnitId: adUnitId)

        //Dismisses the view once ad dismissed
        isPresented.toggle()
        showingPopover.toggle()
    }
}


struct FullScreenModifier<Parent: View>: View {
    @Binding var isPresented: Bool
    @Binding var showingPopover: Bool

    @State var adType: AdType

    //Select adType
    enum AdType {
        case interstitial
        case rewarded
    }

    var rewardFunc: () -> Void
    var adUnitId: String

    //The parent is the view that you are presenting over
    //Think of this as your presenting view controller
    var parent: Parent

    var body: some View {
        ZStack {
            parent

            if isPresented {
                EmptyView()
                    .edgesIgnoringSafeArea(.all)

                if adType == .interstitial {
                    InterstitialAdView(isPresented: $isPresented, showingPopover: $showingPopover, adUnitId: adUnitId)
                }
            }
        }
        .onAppear {
            //Initialize the ads as soon as the view appears
            if adType == .interstitial {
                InterstitialAd.shared.loadAd(withAdUnitId: adUnitId)
            }
        }
    }
}

extension View {


    public func presentInterstitialAd(isPresented: Binding<Bool>,showingPopover: Binding<Bool>, adUnitId: String) -> some View {
        FullScreenModifier(isPresented: isPresented, showingPopover: showingPopover, adType: .interstitial, rewardFunc: {}, adUnitId: adUnitId, parent: self)
    }
}
