import Foundation
import MetalKit

public extension ShaderExtension where Base: MTKView {
  func set(renderer: ShaderRenderer) {
    base.framebufferOnly = false
    base.drawableSize = base.frame.size
    base.delegate = renderer
  }
}
