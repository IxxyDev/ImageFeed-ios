import Foundation

protocol TokenStorage {
  var token: String? { get }
}

final class OAuth2TokenStorage {
  private enum Keys: String {
    case token
  }
  private let userDefaults: UserDefaults

  init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
  }
}

extension OAuth2TokenStorage: TokenStorage {
  var token: String? {
    get {
      userDefaults.string(forKey: Keys.token.rawValue)
    }
    set {
      userDefaults.set(newValue, forKey: Keys.token.rawValue)
    }
  }
}
