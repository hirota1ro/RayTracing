import Cocoa
import ArgumentParser

@main
struct RayTracing: ParsableCommand {
    static let configuration = CommandConfiguration(
      helpNames: [.long, .customShort("?")])

    // @Flag
    // var verbose = false

    @Option(name: .shortAndLong, help: "the number of samples per pixel")
    var samples: Int = 1

    @Option(name: .shortAndLong, help: "the number of spheres in the scene")
    var count: Int = 1

    @Option(name: .shortAndLong, help: "the number of image width")
    var width: Int = 320

    @Option(name: .shortAndLong, help: "the number of image height")
    var height: Int = 240

    @Option(name: .shortAndLong, help: "the number of distance to focus")
    var focus: Double = 10.0

    @Option(name: .shortAndLong, help: "the number of aperture")
    var aperture: Double = 0.1

    @Option(name: .shortAndLong, help: "vertical field-of-view in degrees")
    var theta: Double = 20

    @Option(name: .shortAndLong, help: "file path name to output")
    var output: String?

    mutating func run() throws {
        guard let output = output else {
            print("needs: --output or -o argument")
            return
        }

        let world = World.random_scene(m: count)

        let lookfrom = Point3(x: 13, y: 2, z: 3) // Camera look from position
        let lookat = Point3(x: 0, y: 0, z: 0) // Camera look at position
        let vup = Vec3(x: 0, y: 1, z: 0) // Camera view up direction

        let camera = Camera.create(origin: lookfrom,
                                   lookat: lookat,
                                   vup: vup,
                                   theta: Double(theta).to_radians,
                                   aspect_ratio: Double(width) / Double(height),
                                   aperture: aperture,
                                   focus_dist: focus)

        let generator: PixelGenerator
        if samples > 1 {
            generator = Multiple(samples_per_pixel: samples)
        } else {
            generator = Simple()
        }
        let tracer = Tracer(world: world, camera: camera)
        let renderer = Renderer(tracer: tracer, generator: generator)
        let image = renderer.render(size: CGSize(width: width, height: height))

        let fileURL = URL(fileURLWithPath: output)
        saveFile(image: image, toURL: fileURL)
    }

    func saveFile(image: NSImage, toURL: URL) {
        guard let data = image.pngData else {
            print("no png data")
            return
        }
        do {
            try data.write(to: toURL, options: .atomic)
            print("succeeded to write \(toURL.path)")
        } catch {
            print("failed to write \(error)")
        }
    }
}
