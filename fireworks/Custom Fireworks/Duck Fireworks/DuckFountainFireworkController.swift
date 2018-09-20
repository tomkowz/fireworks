import UIKit

final class DuckFountainFireworkController: FountainFireworkController {

    override func createFirework(at origin: CGPoint, sparkSize: CGSize, scale: CGFloat) -> Firework {
        return DuckFountainFirework(origin: origin, sparkSize: sparkSize, scale: scale)
    }
}
