import Foundation

/// 素材
protocol Material {
    /// 散乱させる
    /// attenuation 減衰
    func scatter(ray: Ray, rec: HitRecord) -> (attenuation: Color3, scattered: Ray)?
}
