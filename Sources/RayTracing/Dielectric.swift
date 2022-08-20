import Foundation

/// 透明な物体…水、ガラス、ダイヤモンドなど
struct Dielectric {
    let ir: Double // Index of Refraction (絶対屈折率)
}

extension Dielectric: Material {

    func scatter(ray: Ray, rec: HitRecord) -> (attenuation: Color3, scattered: Ray)? {
        let attenuation = Color3(r: 1.0, g: 1.0, b: 1.0)
        let refraction_ratio: Double = rec.front_face ? (1.0/ir) : ir

        let unit_direction: Vec3 = ray.direction.unit_vector

        let cos_theta: Double = Swift.min(-unit_direction.dot(rec.normal), 1.0)
        let sin_theta: Double = sqrt(1.0 - cos_theta * cos_theta)

        let cannot_refract: Bool = refraction_ratio * sin_theta > 1.0

        let direction: Vec3
        if cannot_refract || Dielectric.reflectance(cos_theta, refraction_ratio) > Double.random(in: 0 ..< 1) {
            direction = unit_direction.reflect(rec.normal)
        } else {
            direction = unit_direction.refract(rec.normal, ratio: refraction_ratio)
        }

        let scattered = Ray(origin: rec.p, direction: direction)
        return (attenuation: attenuation, scattered: scattered)
    }

    static func reflectance(_ cosine: Double, _ ref_idx: Double) -> Double {
        // Use Schlick's approximation for reflectance.
        var r0 = (1 - ref_idx) / (1 + ref_idx)
        r0 = r0 * r0
        return r0 + (1 - r0) * pow((1 - cosine), 5)
    }
}
