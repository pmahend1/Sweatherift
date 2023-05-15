//
//  APIKeyInputView.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 5/14/23.
//

import SwiftUI

public enum RedactionReason {
   case placeholder
   case confidential
   case blurred
}

struct APIKeyInputView: View {
   @StateObject var viewModel = APIKeyInputViewModel()

   var isKeyPresent: Bool {
      if let apiKey = viewModel.keyChainService.keyValues[Constants.weatherAPIKey] as? String {
         if !apiKey.isEmpty {
            return true
         }
      }
      return false
   }

   var body: some View {
      if let apiKey = viewModel.keyChainService.keyValues[Constants.weatherAPIKey] as? String {
         Text("Current API Key")
            .font(.caption2)
         Text(apiKey)
            .redacted(reason: !viewModel.showAPIKey ? .placeholder : [])
            .font(.body)
            .overlay {
               Text("Show")
                  .opacity(viewModel.showAPIKey ? 0 : 1)
                  .font(.caption2)
            }
            .contentShape(Rectangle())
            .onTapGesture {
               viewModel.showAPIKey.toggle()
            }
      }

      VStack(alignment: .center, spacing: .zero) {
         VStack(alignment: .leading, spacing: 4) {
            Text("Key")
               .font(.caption)
               .padding(.leading, 2)

            TextField("Enter Key", text: $viewModel.text)
               .textFieldStyle(.roundedBorder)
         }

         Button(isKeyPresent ? "Change" : "Save") {
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
