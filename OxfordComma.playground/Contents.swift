/*:
# How to use this playground
* This is place to play with fragment shaders without the need for a pesky
* mobile device.
* Progam your own shader function in `takeTheChapstick` in Dharamsala.metal. You
* can also add your own metal files/functions. In that case, change the name
* of the resource file to load the `MTLLibrary` or `functionName` to set on the `ShaderRenderer`.
*/
import Cocoa
import AppKit
import MetalKit
import PlaygroundSupport

let device = MTLCreateSystemDefaultDevice()!

var library: MTLLibrary?
do {
  let path = Bundle.main.path(forResource: "Dharamsala", ofType: "metal")
  let source = try String(contentsOfFile: path!, encoding: .utf8)
  library = try device.makeLibrary(source: source, options: nil)
} catch let error as NSError {
  print("library error: " + error.description)
}

let shaderView = MTKView(frame: NSRect(x: 0, y: 0, width: 400, height: 400), device: device)
let renderer = ShaderRenderer(device: device)
renderer.library = library
renderer.functionName = "takeTheChapstick"
shaderView.shader.set(renderer: renderer)

let view = NSView(frame: NSRect(x: 0, y: 0, width: 400, height: 400))
view.wantsLayer = true
view.layer?.backgroundColor = CGColor.white

PlaygroundPage.current.liveView = shaderView
