import Foundation

struct HitRecord {
    let p: Point3
    let normal: Vec3
    let material: Material
    let t: Double
    let front_face: Bool
}

/// 当たり判定可能
protocol Hittable {
    func hit(ray: Ray, t_min: Double, t_max: Double) -> HitRecord?
}
