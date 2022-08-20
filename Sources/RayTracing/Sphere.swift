import Foundation

/// 球体
struct Sphere {
    let center: Point3  //!< 中心
    let radius: Double  //!< 半径
    let material: Material  //!< 素材
}

extension Sphere: Hittable {

    func hit(ray: Ray, t_min: Double, t_max: Double) -> HitRecord? {
        let oc: Vec3 = ray.origin - center
        let a = ray.direction.length_squared
        let half_b = oc.dot(ray.direction)
        let c = oc.length_squared - radius*radius

        let discriminant = half_b*half_b - a*c

        guard discriminant >= 0 else { return nil }

        let sqrtd = sqrt(discriminant)

        // Find the nearest root that lies in the acceptable range.
        var root = (-half_b - sqrtd) / a
        if !(t_min < root && root < t_max) {
            root = (-half_b + sqrtd) / a

            guard t_min < root && root < t_max else { return nil }
        }

        let t: Double = root
        let p: Point3 = ray.at(t)
        let outward_normal: Vec3 = (p - center) / radius
        let front_face = ray.direction.dot(outward_normal) < 0
        let normal = front_face ? outward_normal : -outward_normal

        return HitRecord(p: p, normal: normal, material: material, t: t, front_face: front_face)
    }

    // unused (old algorithm)
    func hit_sphere(center: Point3, radius: Double, ray: Ray) -> Double {
        let oc: Vec3 = ray.origin - center
        let a = ray.direction.length_squared
        let half_b = oc.dot(ray.direction)
        let c = oc.length_squared - radius*radius
        let discriminant = half_b*half_b - a*c
        if discriminant < 0 {
            return -1.0
        } else {
            return (-half_b - sqrt(discriminant)) / a
        }
    }
}
