//
//  ReviewButton.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 20/10/22.
//

import SwiftUI
import StoreKit

struct ReviewButton: View {
    var body: some View {
        Button (action: {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        },
                label: {
            Text("Give a review")
                .font(.headline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
    }
}
