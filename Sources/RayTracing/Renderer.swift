import Cocoa

struct Renderer {
    let tracer: Tracer
    let generator: PixelGenerator
}

extension Renderer {
    func render(size: CGSize) -> NSImage {
        let image_width: Int = Int(ceil(size.width))
        let image_height: Int = Int(ceil(size.height))
        var bitmap = BitmapBuffer(width: image_width, height: image_height)
        let progress = Progress()
        for j in 0 ..< image_height {
            progress.progress(ratio: Float(j) / Float(image_height))
            for i in 0 ..< image_width {
                let p = CGPoint(x: i, y: j)
                var pixel_color = generator.resolve(tracer: tracer, point: p, size: size)
                pixel_color = pixel_color.gamma
                bitmap[i, image_height - 1 - j] = pixel_color.rgb
            }
        }
        progress.end()
        return bitmap.image!
    }
}
