import Foundation

struct Camera {
    let origin: Point3
    let lower_left_corner: Point3
    let horizontal: Vec3
    let vertical: Vec3
    let u: Vec3
    let v: Vec3
    let w: Vec3
    let lens_radius: Double
}

extension Camera {
    func getRay(s: Double, t: Double) -> Ray {
        return Ray(origin: origin, direction: lower_left_corner + s * horizontal + t * vertical - origin)
    }
}

extension Camera {

    /// - Parameters:
    ///   - origin: camera look from position
    ///   - vup: camera view up direction
    ///   - theta: vertical field-of-view in radians
    /// - Returns: a camera
    static func create(origin: Point3,
                       lookat: Point3,
                       vup: Vec3,
                       theta: Double,
                       aspect_ratio: Double,
                       aperture: Double,
                       focus_dist: Double) -> Camera {

        let h = tan(theta/2)
        let viewport_height = 2.0 * h
        let viewport_width = aspect_ratio * viewport_height

        let w = (origin - lookat).unit_vector
        let u = vup.cross(w).unit_vector
        let v = w.cross(u)

        let horizontal = focus_dist * viewport_width * u
        let vertical = focus_dist * viewport_height * v
        let lower_left_corner = origin - horizontal/2 - vertical/2 - focus_dist * w
        let lens_radius = aperture / 2

        return Camera(origin: origin, lower_left_corner: lower_left_corner, horizontal: horizontal, vertical: vertical,
                      u: u, v: v, w: w, lens_radius: lens_radius)
    }

    // static func create() -> Camera {
    //     let aspect_ratio = 16.0 / 9.0
    //     let viewport_height = 2.0
    //     let viewport_width = aspect_ratio * viewport_height
    //     let focal_length = 1.0

    //     let origin = Point3(x: 0, y: 0, z: 0)
    //     let horizontal = Vec3(x: viewport_width, y: 0.0, z: 0.0)
    //     let vertical = Vec3(x: 0.0, y: viewport_height, z: 0.0)
    //     let lower_left_corner = origin - horizontal/2 - vertical/2 - Vec3(x: 0, y: 0, z: focal_length)

    //     let w = (origin - lookat).unit_vector
    //     let u = vup.cross(w).unit_vector
    //     let v = w.cross(u)
    //     let horizontal = viewport_width * u
    //     let vertical = viewport_height * v
    //     let lower_left_corner = origin - horizontal/2 - vertical/2 - w
    // }
}
