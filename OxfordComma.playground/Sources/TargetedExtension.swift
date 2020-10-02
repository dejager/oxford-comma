import Foundation

public struct ShaderExtension<Base> {
  public let base: Base

  public init(_ base: Base) {
    self.base = base
  }
}

/// Shader extension support.
public protocol ShaderExtensionCompatible {
  associatedtype CompatibleType

  static var shader: ShaderExtension<CompatibleType>.Type { get set }

  var shader: ShaderExtension<CompatibleType> { get set }
}

extension ShaderExtensionCompatible {
  public static var shader: ShaderExtension<Self>.Type {
    get {
      return ShaderExtension<Self>.self
    }
    set {
      // Enable base type "mutations"
    }
  }

  /// Shader extensions.
  public var shader: ShaderExtension<Self> {
    get {
      return ShaderExtension(self)
    }
    set {
      // Enable base type "mutations"
    }
  }
}

import class Foundation.NSObject

/// Extend NSObject with a proxy.
extension NSObject: ShaderExtensionCompatible {}
