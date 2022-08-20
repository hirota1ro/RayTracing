import Foundation

/// 当たり判定可能なオブジェクトのリスト
struct HittableList {
    var objects: [Hittable]
}

extension HittableList {
    init() { objects = [] }
    mutating func clear() { objects.removeAll() }
    mutating func add(_ object: Hittable) { objects.append(object) }
}

extension HittableList: Hittable {

    func hit(ray: Ray, t_min: Double, t_max: Double) -> HitRecord? {
        var found: HitRecord? = nil
        var closest_so_far = t_max
        for object in objects {
            if let rec = object.hit(ray: ray, t_min: t_min, t_max: closest_so_far) {
                closest_so_far = rec.t
                found = rec
            }
        }
        return found
    }
}
