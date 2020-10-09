// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let ar = ImageAsset(name: "AR")
  internal static let fireBase = ImageAsset(name: "FireBase")
  internal static let googleSteetView = ImageAsset(name: "GoogleSteetView")
  internal static let icon1 = ImageAsset(name: "Icon1")
  internal static let icon10 = ImageAsset(name: "Icon10")
  internal static let icon11 = ImageAsset(name: "Icon11")
  internal static let icon12 = ImageAsset(name: "Icon12")
  internal static let icon2 = ImageAsset(name: "Icon2")
  internal static let icon3 = ImageAsset(name: "Icon3")
  internal static let icon4 = ImageAsset(name: "Icon4")
  internal static let icon5 = ImageAsset(name: "Icon5")
  internal static let icon6 = ImageAsset(name: "Icon6")
  internal static let icon7 = ImageAsset(name: "Icon7")
  internal static let icon8 = ImageAsset(name: "Icon8")
  internal static let icon9 = ImageAsset(name: "Icon9")
  internal static let machineLearning = ImageAsset(name: "MachineLearning")
  internal static let pageControl = ImageAsset(name: "PageControl")
  internal static let arrowUp = ImageAsset(name: "arrow_up")
  internal static let close = ImageAsset(name: "close")
  internal static let hdarClose = ImageAsset(name: "hdar_close")
  internal static let icon = ImageAsset(name: "icon")
  internal static let trashBin = ImageAsset(name: "trash_bin")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
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
