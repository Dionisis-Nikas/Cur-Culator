//
//  UrlImageView.swift
//  
//
//  Created by Dennis Nikas on 5/9/21.
//  
//

import SwiftUI

struct UrlImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage!)
            .resizable()
            .scaledToFit()
            .frame(width: 15, height: 15)
    }
    
    static var defaultImage = UIImage(systemName: "flag.slash.circle.fill")
}




	
