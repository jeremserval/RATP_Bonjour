import Foundation

public enum L10n {
    static func localizedString(for key: String) -> String {
        NSLocalizedString(key, comment: "")
    }

    public static let mainTitle: String = L10n.localizedString(for: "mainTitle")

    public static let errorDefaultMessage: String = L10n.localizedString(for: "error.default.message")
    public static func errorMessage(message: String) -> String {
        L10n.tr("Localizable", "error.default", String(describing: message))
    }

    public static let prmAccess: String = L10n.localizedString(for: "prmAccess")
    public static func openingHours(hours: String) -> String {
        L10n.tr("Localizable", "openingHours", String(describing: hours))
    }
}

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
      let format = Bundle.main.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
