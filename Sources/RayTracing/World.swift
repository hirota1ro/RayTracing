import Foundation

struct World {
}

extension World {

    static func random_scene(m: Int) -> HittableList {
        var world = HittableList()

        let ground_material = Lambertian(albedo: Color3(r: 0.5, g: 0.5, b: 0.5))
        world.add(Sphere(center: Point3(x: 0, y: -1000, z: 0), radius: 1000, material: ground_material))

        for a in -m ..< m {
            for b in -m ..< m {
                let choose_mat = Double.random(in: 0..<1)
                let center = Point3(x: Double(a) + 0.9 * Double.random(in: 0..<1),
                                    y: 0.2,
                                    z: Double(b) + 0.9 * Double.random(in: 0..<1))

                if ((center - Point3(x: 4, y: 0.2, z: 0)).length > 0.9) {
                    let sphere_material: Material

                    if (choose_mat < 0.8) {
                        // diffuse
                        let albedo = Color3.random(in: 0 ..< 1) * Color3.random(in: 0 ..< 1)
                        sphere_material = Lambertian(albedo: albedo)
                    } else if (choose_mat < 0.95) {
                        // metal
                        let albedo = Color3.random(in: 0.5 ..< 1)
                        let fuzz = Double.random(in: 0 ..< 0.5)
                        sphere_material = Metal(albedo: albedo, fuzz: fuzz)
                    } else {
                        // glass
                        sphere_material = Dielectric(ir: 1.5)
                    }
                    world.add(Sphere(center: center, radius: 0.2, material: sphere_material))
                    //world.add(sphere(center, 0.2, sphere_material))
                    //world.add(sphere(center, 0.2, sphere_material))
                }
            }
        }

        let material1 = Dielectric(ir: 1.5)
        world.add(Sphere(center: Point3(x: 0, y:1, z:0), radius: 1.0, material: material1))

        let material2 = Lambertian(albedo: Color3(r: 0.4, g:0.2, b:0.1))
        world.add(Sphere(center: Point3(x: -4, y:1, z:0), radius: 1.0, material: material2))

        let material3 = Metal(albedo: Color3(r: 0.7, g:0.6, b:0.5), fuzz: 0.0)
        world.add(Sphere(center: Point3(x: 4, y:1, z:0), radius: 1.0, material: material3))

        return world
    }

    static func example_scene() -> HittableList {
        var world = HittableList()
        let material_ground = Lambertian(albedo: Color3(r: 0.8, g: 0.8, b: 0.0))
        // let material_center = Lambertian(albedo: Color3(x: 0.7, y: 0.3, z: 0.3))
        // let material_left   = Metal(albedo: Color3(x: 0.8, y: 0.8, z: 0.8), fuzz: 0.3)
        // let material_center = Dielectric(ir: 1.5)
        let material_center = Lambertian(albedo: Color3(r: 0.1, g: 0.2, b: 0.5))
        let material_left   = Dielectric(ir: 1.5)
        let material_right  = Metal(albedo: Color3(r: 0.8, g: 0.6, b: 0.2), fuzz: 1.0)

        world.add(Sphere(center: Point3(x: 0.0, y: -100.5, z: -1.0), radius: 100.0, material: material_ground))
        world.add(Sphere(center: Point3(x: 0.0, y:    0.0, z: -1.0), radius:   0.5, material: material_center))
        world.add(Sphere(center: Point3(x:-1.0, y:    0.0, z: -1.0), radius:   0.5, material: material_left))
        world.add(Sphere(center: Point3(x:-1.0, y:    0.0, z: -1.0), radius:  -0.4, material: material_left))
        world.add(Sphere(center: Point3(x: 1.0, y:    0.0, z: -1.0), radius:   0.5, material: material_right))
        return world
    }
}
