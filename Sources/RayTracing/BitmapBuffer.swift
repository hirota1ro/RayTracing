import Cocoa

struct BitmapBuffer {

    let width: Int
    let height: Int
    var data: Data

    let bitsPerComponent = 8
    let numberOfComponents = 3

    init(width: Int, height: Int) {
        assert(0 < width)
        assert(0 < height)
        self.width = width
        self.height = height
        self.data = Data(count: width * height * numberOfComponents)
    }

    /**
     * @param index pixel index (0..<(width*height))
     * @return rgb (0x00rrggbb)
     */
    subscript(index: Int) -> UInt32 {
        get {
            let i = index * numberOfComponents
            let r = UInt32(data[i])
            let g = UInt32(data[i+1])
            let b = UInt32(data[i+2])
            return (r << 16) | (g << 8) | (b)
        }
        set {
            let i = index * numberOfComponents
            let r = (newValue >> 16) & 0xFF
            let g = (newValue >> 8) & 0xFF
            let b = (newValue) & 0xFF
            data[i] = UInt8(r)
            data[i+1] = UInt8(g)
            data[i+2] = UInt8(b)
        }
    }

    /**
     * @param x 0..<width
     * @param y 0..<height
     * @return rgb (0x00rrggbb)
     */
    subscript(x: Int, y: Int) -> UInt32 {
        get { return self[y * width + x] }
        set { self[y * width + x] = newValue }
    }
}

extension BitmapBuffer {

    var cgImage: CGImage? {
        let bitsPerPixel = bitsPerComponent * numberOfComponents
        let bytesPerPixel = bitsPerPixel / 8
        let provider = CGDataProvider(data: data as CFData)
        return CGImage(width: width,
                       height: height,
                       bitsPerComponent: bitsPerComponent,
                       bitsPerPixel: bitsPerPixel,
                       bytesPerRow: width * bytesPerPixel,
                       space: CGColorSpaceCreateDeviceRGB(),
                       bitmapInfo: [],
                       provider: provider!,
                       decode: nil,
                       shouldInterpolate: false,
                       intent: .defaultIntent)
    }

    var image: NSImage? {
        if let img = cgImage {
            return NSImage(cgImage: img, size: CGSize(width: width, height: height))
        }
        return nil
    }
}
