import Foundation

struct Vec3 {
    var x: Double
    var y: Double
    var z: Double
}

extension Vec3 {
    init() {
        x = 0
        y = 0
        z = 0
    }
    init(x: Int, y: Int, z: Int) {
        self.x = Double(x)
        self.y = Double(y)
        self.z = Double(z)
    }
    var length: Double { return sqrt(length_squared) }
    var length_squared: Double { return x * x + y * y + z * z }
    func dot(_ v: Vec3) -> Double { return x * v.x + y * v.y + z * v.z }
    func cross(_ v: Vec3) -> Vec3 {
        return Vec3(x: y * v.z - z * v.y,
                    y: z * v.x - x * v.z,
                    z: x * v.y - y * v.x)
    }
    var unit_vector: Vec3 { return self / length }
}
extension Vec3 {
    static prefix func - (v: Vec3) -> Vec3 { return Vec3(x: -v.x, y: -v.y, z: -v.z) }
    static func + (u: Vec3, v: Vec3) -> Vec3 { return Vec3(x: u.x + v.x, y: u.y + v.y, z: u.z + v.z) }
    static func - (u: Vec3, v: Vec3) -> Vec3 { return Vec3(x: u.x - v.x, y: u.y - v.y, z: u.z - v.z) }
    static func * (v: Vec3, t: Double) -> Vec3 { return Vec3(x: v.x * t, y: v.y * t, z: v.z * t) }
    static func * (t: Double, v: Vec3) -> Vec3 { return Vec3(x: v.x * t, y: v.y * t, z: v.z * t) }
    static func * (u: Vec3, v: Vec3) -> Vec3 { return Vec3(x: u.x * v.x, y: u.y * v.y, z: u.z * v.z) }
    static func / (v: Vec3, t: Double) -> Vec3 { return Vec3(x: v.x / t, y: v.y / t, z: v.z / t) }
    static func += (u: inout Vec3, v: Vec3) { u = u + v }
    static func -= (u: inout Vec3, v: Vec3) { u = u - v }
    static func *= (v: inout Vec3, t: Double) { v = v * t }
    static func /= (v: inout Vec3, t: Double) { v = v / t }
}
extension Vec3 {

    /// Return true if the vector is close to zero in all dimensions.
    var near_zero: Bool {
        let s = 1e-8
        return (abs(x) < s) && (abs(y) < s) && (abs(z) < s)
    }

    /// 反射する
    /// - Parameter n: normal vector 法線ベクトル
    /// - Returns: このベクトルを法線nの平面で反射させたときの新しいベクトル
    func reflect(_ n: Vec3) -> Vec3 { return self - 2 * self.dot(n) * n }

    /// 屈折する
    /// - Parameters:
    ///  - n: normal vector 法線ベクトル
    ///  - ratio: η/η'   η:= refractive indices (typically air = 1.0, glass = 1.3–1.7, diamond = 2.4).
    /// - Returns: このベクトルを屈折率 ratio, 法線nの平面で屈折させたときの新しいベクトル
    func refract(_ n: Vec3, ratio: Double) -> Vec3 {
        let cos_theta = Swift.min(-self.dot(n), 1.0)
        let r_out_perp: Vec3 = ratio * (self + cos_theta * n)
        let r_out_parallel: Vec3 = -sqrt(abs(1.0 - r_out_perp.length_squared)) * n
        return r_out_perp + r_out_parallel
    }

    static func random(in range: Range<Double>) -> Vec3 {
        let x = Double.random(in: range)
        let y = Double.random(in: range)
        let z = Double.random(in: range)
        return Vec3(x: x, y: y, z: z)
    }

    static func random_unit_vector() -> Vec3 {
        return Vec3.random(in: -1 ..< 1).unit_vector
    }

    static func random_in_unit_sphere() -> Point3 {
        return random_unit_vector() * Double.random(in: 0 ..< 1)
    }

    // unused
    static func random_in_hemisphere(normal: Vec3) -> Vec3 {
        let in_unit_sphere: Vec3 = Vec3.random_in_unit_sphere()
        if (in_unit_sphere.dot(normal) > 0.0) {
            // In the same hemisphere as the normal
            return in_unit_sphere
        } else {
            return -in_unit_sphere
        }
    }
}
extension Vec3: CustomStringConvertible {
    var description: String { return "(\(x), \(y), \(z))" }
}

typealias Point3 = Vec3

