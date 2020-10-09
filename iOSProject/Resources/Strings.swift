// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localized {
  /// detecting scene...
  internal static let answerLabelDefault = Localized.tr("Localizable", "answer_label_default")
  /// Camera
  internal static let cameraButtonTitle = Localized.tr("Localizable", "camera_button_title")
  /// Cancel
  internal static let cancelButtonTitle = Localized.tr("Localizable", "cancel_button_title")
  /// Gallery
  internal static let galleryButtonTitle = Localized.tr("Localizable", "gallery_button_title")
  /// Add image from Camera/Gallery
  internal static let initalLabelDefault = Localized.tr("Localizable", "inital_label_default")

  internal enum AlertDelete {
    /// Are you sure, you want to delete contact
    internal static let contactDescription = Localized.tr("Localizable", "alert_delete.contact_description")
    /// Delete Contact
    internal static let contactTitle = Localized.tr("Localizable", "alert_delete.contact_title")
  }

  internal enum Chatbot {
    /// Send to Chat Bot
    internal static let sendButtonTitle = Localized.tr("Localizable", "chatbot.send_button_title")
    /// Chat Bot - Hotel booking
    internal static let title = Localized.tr("Localizable", "chatbot.title")
  }

  internal enum ContactsScreen {
    /// Logout
    internal static let logoutTitle = Localized.tr("Localizable", "contacts_screen.logout_title")
    /// Contacts
    internal static let title = Localized.tr("Localizable", "contacts_screen.title")
  }

  internal enum HomeScreen {
    /// Home
    internal static let backButtonTitle = Localized.tr("Localizable", "home_screen.back_button_title")
    /// Energize
    internal static let siriShortcutName = Localized.tr("Localizable", "home_screen.siri_shortcut_name")
    /// iOS Project
    internal static let title = Localized.tr("Localizable", "home_screen.title")
    /// iOS Project!
    internal static let titleDebug = Localized.tr("Localizable", "home_screen.title_debug")
  }

  internal enum ImageRecognition {
    /// Image Recognition
    internal static let title = Localized.tr("Localizable", "image_recognition.title")
  }

  internal enum LoginScreen {
    /// Login Failed
    internal static let loginFail = Localized.tr("Localizable", "login_screen.login_fail")
    /// Register Failed
    internal static let registerFail = Localized.tr("Localizable", "login_screen.register_fail")
    /// Login
    internal static let title = Localized.tr("Localizable", "login_screen.title")
  }

  internal enum MlScreen {
    /// Machine Learning
    internal static let title = Localized.tr("Localizable", "ml_screen.title")
  }

  internal enum Pagecontrol {
    /// Delete
    internal static let delete = Localized.tr("Localizable", "pagecontrol.delete")
    /// Like
    internal static let like = Localized.tr("Localizable", "pagecontrol.like")
    /// Custom Page Control
    internal static let title = Localized.tr("Localizable", "pagecontrol.title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localized {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
