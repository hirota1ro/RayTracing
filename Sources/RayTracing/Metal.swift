import Foundation

/// 金属
struct Metal {
    let albedo: Color3
    let fuzz: Double /// 毛羽立ち、ぼやけ
}

extension Metal: Material {

    func scatter(ray: Ray, rec: HitRecord) -> (attenuation: Color3, scattered: Ray)? {
        let reflected: Vec3 = ray.direction.unit_vector.reflect(rec.normal)
        let scattered = Ray(origin: rec.p, direction: reflected + fuzz * Vec3.random_in_unit_sphere())
        let attenuation = albedo
        if scattered.direction.dot(rec.normal) > 0 {
            return (attenuation: attenuation, scattered: scattered)
        } else {
            return nil
        }
    }
}
