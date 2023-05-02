//
//  CachedAsyncImageLoader.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 5/2/23.
//

import Foundation
import UIKit

class CachedAsyncImageLoader: ObservableObject {
   // MARK: - Properties

   private static let imageCache = Cache<URL, UIImage>()
   private let url: URL

   @Published var image: UIImage?

   // MARK: - Init

   init(url: URL) {
      self.url = url
   }

   // MARK: - Methods

   func load() {
      if let cachedImage = Self.imageCache.value(forKey: url) {
         image = cachedImage
         return
      }

      URLSession.shared.dataTask(with: url) { data, _, error in
         guard let data = data, error == nil else {
            return
         }

         DispatchQueue.main.async {
            if let loadedImage = UIImage(data: data) {
               Self.imageCache.insert(loadedImage,
                                      forKey: self.url,
                                      expirationDate: Date.now.addingTimeInterval(3600 * 12))
               self.image = loadedImage
            }
         }
      }.resume()
   }
}
