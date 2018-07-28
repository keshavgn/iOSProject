// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum Localized {
  /// detecting scene...
  static let answerLabelDefault = Localized.tr("Localizable", "answer_label_default")
  /// Camera
  static let cameraButtonTitle = Localized.tr("Localizable", "camera_button_title")
  /// Cancel
  static let cancelButtonTitle = Localized.tr("Localizable", "cancel_button_title")
  /// Gallery
  static let galleryButtonTitle = Localized.tr("Localizable", "gallery_button_title")
  /// Add image from Camera/Gallery
  static let initalLabelDefault = Localized.tr("Localizable", "inital_label_default")

  enum AlertDelete {
    /// Are you sure, you want to delete contact
    static let contactDescription = Localized.tr("Localizable", "alert_delete.contact_description")
    /// Delete Contact
    static let contactTitle = Localized.tr("Localizable", "alert_delete.contact_title")
  }

  enum ContactsScreen {
    /// Logout
    static let logoutTitle = Localized.tr("Localizable", "contacts_screen.logout_title")
    /// Contacts
    static let title = Localized.tr("Localizable", "contacts_screen.title")
  }

  enum HomeScreen {
    /// Home
    static let backButtonTitle = Localized.tr("Localizable", "home_screen.back_button_title")
    /// Energize
    static let siriShortcutName = Localized.tr("Localizable", "home_screen.siri_shortcut_name")
    /// iOS Project
    static let title = Localized.tr("Localizable", "home_screen.title")
    /// iOS Project!
    static let titleDebug = Localized.tr("Localizable", "home_screen.title_debug")
  }

  enum LoginScreen {
    /// Login Failed
    static let loginFail = Localized.tr("Localizable", "login_screen.login_fail")
    /// Register Failed
    static let registerFail = Localized.tr("Localizable", "login_screen.register_fail")
    /// Login
    static let title = Localized.tr("Localizable", "login_screen.title")
  }

  enum Pagecontrol {
    /// Delete
    static let delete = Localized.tr("Localizable", "pagecontrol.delete")
    /// Like
    static let like = Localized.tr("Localizable", "pagecontrol.like")
    /// Custom Page Control
    static let title = Localized.tr("Localizable", "pagecontrol.title")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension Localized {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
