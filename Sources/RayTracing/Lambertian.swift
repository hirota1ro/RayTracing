import Foundation

/// ランバート反射とは、拡散反射表面を理想的に扱った反射モデルである。
/// https://ja.wikipedia.org/wiki/ランバート反射
/// アルベドとは、天体の外部からの入射光に対する、反射光の比である。(反射能)
/// https://ja.wikipedia.org/wiki/アルベド
struct Lambertian {
    let albedo: Color3 // 反射能
}

extension Lambertian: Material {

    func scatter(ray: Ray, rec: HitRecord) -> (attenuation: Color3, scattered: Ray)? {
        var scatter_direction = rec.normal + Vec3.random_unit_vector()

        // Catch degenerate scatter direction
        if scatter_direction.near_zero {
            scatter_direction = rec.normal
        }

        return (attenuation: albedo, scattered: Ray(origin: rec.p, direction: scatter_direction))
    }
}
