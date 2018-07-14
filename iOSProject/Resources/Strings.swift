// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum Localized {
  /// Are you sure, you want to delete contact
  static let alertDeleteContactDescription = Localized.tr("Localizable", "alert_delete_contact_description")
  /// Delete Contact
  static let alertDeleteContactTitle = Localized.tr("Localizable", "alert_delete_contact_title")
  /// detecting scene...
  static let answerLabelDefault = Localized.tr("Localizable", "answer_label_default")
  /// Camera
  static let cameraButtonTitle = Localized.tr("Localizable", "camera_button_title")
  /// Cancel
  static let cancelButtonTitle = Localized.tr("Localizable", "cancel_button_title")
  /// Contacts
  static let contactsScreenTitle = Localized.tr("Localizable", "contacts_screen_title")
  /// Gallery
  static let galleryButtonTitle = Localized.tr("Localizable", "gallery_button_title")
  /// Home
  static let homeScreenBackTitle = Localized.tr("Localizable", "home_screen_back_title")
  /// iOS Project
  static let homeScreenTitle = Localized.tr("Localizable", "home_screen_title")
  /// Add image from Camera/Gallery
  static let initalLabelDefault = Localized.tr("Localizable", "inital_label_default")
  /// Login Failed
  static let loginScreenLoginFail = Localized.tr("Localizable", "login_screen_login_fail")
  /// Register Failed
  static let loginScreenRegisterFail = Localized.tr("Localizable", "login_screen_register_fail")
  /// Login
  static let loginScreenTitle = Localized.tr("Localizable", "login_screen_title")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension Localized {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
