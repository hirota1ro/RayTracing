import Cocoa

struct Tracer {

    let world: HittableList

    let camera: Camera

    let max_depth: Int = 50
}

extension Tracer {

    func trace(_ s: Double, _ t: Double) -> Color3 {
        let ray = camera.getRay(s: s, t: t)
        return ray_color(ray: ray, depth: max_depth)
    }

    func ray_color(ray: Ray, depth: Int) -> Color3 {
        // If we've exceeded the ray bounce limit, no more light is gathered.
        if depth <= 0 {
            return Color3()
        }
        if let rec = world.hit(ray: ray, t_min: 0, t_max: .infinity) {
            if let (attenuation, scattered) = rec.material.scatter(ray: ray, rec: rec) {
                return attenuation * ray_color(ray: scattered, depth: depth - 1)
            }
            return Color3()
        }
        let unit_direction: Vec3 = ray.direction.unit_vector
        let t: Double = 0.5 * (unit_direction.y + 1.0)
        // blendedValue=(1−𝑡)⋅startValue+𝑡⋅endValue,
        return (1.0 - t) * Color3(r: 1.0, g: 1.0, b: 1.0) + t * Color3(r: 0.5, g: 0.7, b: 1.0)
    }
}
