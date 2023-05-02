//
//  CachedAsyncImageView.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 5/2/23.
//

import SwiftUI

struct CachedAsyncImageView: View {
   // MARK: - Properties

   private let placeholder: Image
   @StateObject private var imageLoader: CachedAsyncImageLoader

   // MARK: - Init

   init(url: URL, placeholder: Image = Image(systemName: "photo")) {
      _imageLoader = StateObject(wrappedValue: CachedAsyncImageLoader(url: url))
      self.placeholder = placeholder
   }

   // MARK: - Body

   var body: some View {
      Group {
         if let image = imageLoader.image {
            Image(uiImage: image)
               .scaledToFit()
         } else {
            placeholder
               .scaledToFit()
         }
      }
      .onAppear {
         imageLoader.load()
      }
   }
}

struct CachedAsyncImage_Previews: PreviewProvider {
   static var previews: some View {
      if let URLUnwrapped = URL(string: "https://placehold.co/600x400") {
         CachedAsyncImageView(url: URLUnwrapped)
      }
   }
}
