//: Playground - noun: a place where people can play

import Cocoa
import QuartzCore
import XCPlayground

let theFrame = NSRect(x: 0, y: 0, width: 568, height: 426)

class SimpleRendererView: NSView {
    override func drawRect(dirtyRect: NSRect) -> Void {
        let theContext = NSGraphicsContext.currentContext()!.CGContext

        let theNSImage = NSImage(named: "DSCN5021")!
        let theImage:CGImage = theNSImage.CGImageForProposedRect(nil,
            context: nil,
            hints: nil)!
        
        let bloomFilter = CIFilter(name: "CIBloom")!
        
        let inputCIImage = CIImage(CGImage: theImage)
        
        // Set some filter parameters.
        bloomFilter.setValue(inputCIImage, forKey:kCIInputImageKey)
        bloomFilter.setValue(20, forKey:kCIInputRadiusKey)
        let outputCIImage = bloomFilter.valueForKey(kCIOutputImageKey)! as! CIImage
        let ciContext = CIContext(CGContext: theContext, options: nil)
        ciContext.drawImage(outputCIImage, inRect:theFrame, fromRect:theFrame)
        // print("\(CGImageGetWidth(theImage))")
    }
}

let myView = SimpleRendererView(frame: theFrame)
XCPShowView("CoreImage filter applied", view: myView)

