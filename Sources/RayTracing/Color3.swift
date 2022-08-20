import Foundation

struct Color3 {
    var r: Double
    var g: Double
    var b: Double
}

extension Color3 {
    init() {
        r = 0
        g = 0
        b = 0
    }
    init(r: Int, g: Int, b: Int) {
        self.r = Double(r)
        self.g = Double(g)
        self.b = Double(b)
    }
}
extension Color3 {
    static func + (u: Color3, v: Color3) -> Color3 { return Color3(r: u.r + v.r, g: u.g + v.g, b: u.b + v.b) }
    static func * (t: Double, v: Color3) -> Color3 { return Color3(r: v.r * t, g: v.g * t, b: v.b * t) }
    static func * (u: Color3, v: Color3) -> Color3 { return Color3(r: u.r * v.r, g: u.g * v.g, b: u.b * v.b) }
    static func / (v: Color3, t: Double) -> Color3 { return Color3(r: v.r / t, g: v.g / t, b: v.b / t) }
    static func += (u: inout Color3, v: Color3) { u = u + v }
}
extension Color3 {
    static func random(in range: Range<Double>) -> Color3 {
        let r = Double.random(in: range)
        let g = Double.random(in: range)
        let b = Double.random(in: range)
        return Color3(r:r, g:g, b:b)
    }
    var gamma: Color3 {
        return Color3(r:sqrt(r), g:sqrt(g), b:sqrt(b))
    }

    var rgb: UInt32 { 
        let r = UInt32(r * 255.5)
        let g = UInt32(g * 255.5)
        let b = UInt32(b * 255.5)
        return (r<<16) | (g<<8) | b
    }
}
extension Color3: CustomStringConvertible {
    var description: String { return "(\(r), \(g), \(b))" }
}
