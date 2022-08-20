import Foundation

protocol PixelGenerator {
    func resolve(tracer: Tracer, point: CGPoint, size: CGSize) -> Color3
}

// if samples_per_pixel == 1
struct Simple: PixelGenerator {

    func resolve(tracer: Tracer, point: CGPoint, size: CGSize) -> Color3 {
        let u = point.x / size.width
        let v = point.y / size.height
        return tracer.trace(u, v)
    }
}

// if samples_per_pixel > 1
// Generating Pixels with Multiple Samples
struct Multiple: PixelGenerator {

    let samples_per_pixel: Int

    func resolve(tracer: Tracer, point: CGPoint, size: CGSize) -> Color3 {
        var pixel_color = Color3()
        for _ in 0 ..< samples_per_pixel {
            let u = (point.x + CGFloat.random(in: 0..<1)) / size.width
            let v = (point.y + CGFloat.random(in: 0..<1)) / size.height
            pixel_color += tracer.trace(u, v)
        }
        return pixel_color / Double(samples_per_pixel)
    }
}
