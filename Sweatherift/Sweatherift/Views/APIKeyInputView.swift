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
        Text(.init(Localized.registerAtHttpsOpenweathermapOrg))
        Text(.init(Localized.goToHttpsHomeOpenweathermapOrgApiKeysToGetAKey))
            .padding(.top, 10)

        Text(Localized.currentAPIKey)
            .font(.caption2)
            .padding(.top, 20)

        if viewModel.isKeyPresent {
            Text(viewModel.APIKey)
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
            VStack(alignment: .leading, spacing: 4) {
                Text(Localized.key)
                    .font(.caption)
                    .padding(.leading, 2)

                TextField(Localized.enterKey, text: $viewModel.text)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.alphabet)
                    .autocorrectionDisabled(true)

                Button(viewModel.isKeyPresent ? Localized.change : Localized.save) {
                    _ = viewModel.save()
                }
                .font(.body.bold())
                .frame(width: 200, height: 40)
                .background(Color.accent)
                .foregroundColor(Color.buttonLabelColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 10)

                if viewModel.showKeyUpdatedMessage {
                    Text(Localized.apiKeyHasBeenUpdated)
                        .font(.caption)
                        .padding(.top, 10)
                }
            }
            .padding(.all, 20)
            .onAppear {
                viewModel.loadData()
            }
        }
    }
}

struct APIKeyInputView_Previews: PreviewProvider {
    static var previews: some View {
        APIKeyInputView()
    }
}
