//
//  UserService.swift
//  Zendesk Demo App
//
//  Created by Jara De Prest on 26/04/2021.
//  Copyright © 2021 Next Apps. All rights reserved.
//

import Alamofire
import Auth0
import UIKit
import Unified
import ZendeskCoreSDK

class UserService {

    // MARK: - Properties

    static let shared = UserService()

    var userId: String? {
        get {
            UserDefaults.userId
        }
        set {
            UserDefaults.userId = newValue
        }
    }

    var user: User? {
        get {
            UserDefaults.user
        }
        set {
            UserDefaults.user = newValue
        }
    }

    var isLoggedIn: Bool {
        Keychain.isUserAuthenticated && userId != nil
    }

    // MARK: - Lifecycle

    private init() { }
}

// MARK: - Internal methods

extension UserService {

    func login(_ completion: @escaping (Bool) -> Void) {
        Auth0
            .webAuth()
            .scope("openid profile email")
            .audience("https://premiumplus.eu.auth0.com/userinfo")
            .start { result in
                switch result {
                case .success(let credentials):
                    UserService.shared.userId = credentials.idToken
                    Keychain.setToken(credentials)
                    self.getUserInfo(for: credentials.accessToken, completion)
                case .failure(let error):
                    Unified.shareAuthInfo(token: nil, error: error)
                    completion(false)
                }
            }
    }

    func logout(_ completion: @escaping (Bool) -> Void) {
        Auth0
            .webAuth()
            .clearSession(federated: false) { success in
                if success {
                    Unified.logout()
                    Keychain.setUnAuthenticated()
                    self.user = nil
                    self.userId = nil
                    completion(true)
                } else {
                    completion(false)
                }
            }
    }

    func getToken() {
        guard let email = UserService.shared.user?.email,
              let name = UserService.shared.user?.name,
              let id = UserService.shared.user?.id
        else { return }

        let params = ["email": email, "name": name, "external_id": id]

        let request = AF.request("https://dev.premiumplus.io/jwt_chat/", method: .post, parameters: params)

        request.responseDecodable(of: JwtToken.self, completionHandler: { response in
            guard let data = response.value else {
                Unified.shareAuthInfo(token: nil, error: response.error)
                return
            }

            Unified.shareAuthInfo(token: data.jwt, error: nil)
        })
    }
}

// MARK: - Private methods

private extension UserService {
    func getUserInfo(for token: String?, _ completion: @escaping (Bool) -> Void) {
        guard let token = token else { return }

        Auth0
            .authentication()
            .userInfo(withAccessToken: token)
            .start { result in
                switch result {
                case .success(let result):
                    self.user = User(id: result.sub,
                                     name: result.name,
                                     givenName: result.givenName,
                                     familyName: result.familyName,
                                     email: result.email,
                                     emailVerified: result.emailVerified ?? false)
                    self.getToken()
                    self.setZendeskIdentity(with: result.email)
                    completion(true)
                case .failure(let error):
                    print("🔴 Something went wrong when getting userInfo: ", error.localizedDescription)
                    Unified.shareAuthInfo(token: nil, error: error)
                    completion(false)
                }
            }
    }

    func setZendeskIdentity(with email: String?) {
        guard let email = email else { return }
        let identity = Identity.createJwt(token: email)
        Zendesk.instance?.setIdentity(identity)
    }
}
