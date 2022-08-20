import Foundation

/// 光線
struct Ray {
    var origin: Vec3
    var direction: Vec3
}

extension Ray {
    func at(_ t: Double) -> Vec3 { return origin + t * direction }
}
