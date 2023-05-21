//
//  APIKeyInputView.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 5/14/23.
//

import SwiftUI

struct APIKeyInputView: View {
   @StateObject var viewModel = APIKeyInputViewModel()

   var body: some View {
      if let apiKey = viewModel.keyChainService.keyValues[Constants.weatherAPIKey] as? String {
         Text(Localized.currentAPIKey)
            .font(.caption2)
         Text(apiKey)
            .redacted(reason: !viewModel.showAPIKey ? .placeholder : [])
            .font(.body)
            .overlay {
               Text(Localized.show)
                  .opacity(viewModel.showAPIKey ? 0 : 1)
                  .font(.caption2)
            }
            .contentShape(Rectangle())
            .onTapGesture {
               viewModel.showAPIKey.toggle()
            }
      }

      VStack(alignment: .center, spacing: .zero) {
         Text(Localized.registerAtHttpsOpenweathermapOrg)
         Text(Localized.goToHttpsHomeOpenweathermapOrgApiKeysToGetAKey)
            .padding(.top, 10)

         VStack(alignment: .leading, spacing: 4) {
            Text(Localized.key)
               .font(.caption)
               .padding(.leading, 2)

            TextField(Localized.enterKey, text: $viewModel.text)
               .textFieldStyle(.roundedBorder)
         }

         Button(viewModel.isKeyPresent ? Localized.change : Localized.save) {
            _ = viewModel.save()
         }
         .font(.body.bold())
         .frame(width: 200, height: 40)
         .background(Color.accentColor)
         .foregroundColor(.primary)
         .clipShape(RoundedRectangle(cornerRadius: 10))
         .padding(.top, 10)
      }
      .padding(.all, 20)
   }
}

struct APIKeyInputView_Previews: PreviewProvider {
   static var previews: some View {
      APIKeyInputView()
   }
}
