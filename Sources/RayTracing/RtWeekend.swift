import Foundation

extension Double {

    var to_radians : Double { return self * .pi / 180.0 }
    var to_degrees : Double { return self / .pi * 180.0 }

    func clamp(min: Double, max: Double) -> Double {
        if self < min { 
            return min
        }
        if self > max {
            return max
        }
        return self
    }
}
