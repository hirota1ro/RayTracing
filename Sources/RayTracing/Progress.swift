import Foundation

class Progress {

    var start: Date
    var last: Date

    init() {
        start = Date()
        last = Date()
    }

    func progress(ratio: Float) {
        let span = Date().timeIntervalSince(last)
        if 1 < span {
            let percent = Int(ratio * 100)

            let elapsed = Date().timeIntervalSince(start)
            let total = elapsed / TimeInterval(ratio)
            let remains = total - elapsed
            let t = format(remains)

            print("\(percent)% (estimated time remaining: \(t))")
            last = Date()
        }
    }

    func end() {
        let elapsed = Date().timeIntervalSince(start)
        //let s = String(format: "%.2f", elapsed)
        let t = format(elapsed)
        print("elapsed: \(t)")
    }

    func format(_ t: TimeInterval) -> String {
        if t < 1 {
            return String(format: "%.2f″", t)
        }
        if t < 60 { // 60秒(1分)未満
            let sec = Int(t)
            return "\(sec)″"
        }

        if t < 60 * 60 { // 60分(1時間)未満
            let sec = Int(t) % 60
            let min = Int(t) / 60
            return "\(min)′\(sec)″"
        }

        if t < 60 * 60 * 24 { // 24時間(1日)未満
            let tt = Int(t) / 60
            let min = tt % 60
            let hour = tt / 60
            return "\(hour)°\(min)′"
        }

        //if t < 60 * 60 * 60 * 24 {
            let ttt = Int(t) / 60 / 60
            let h = ttt % 24
            let day = ttt / 24
            return "\(day)days\(h)°"
        //}
    }
}
