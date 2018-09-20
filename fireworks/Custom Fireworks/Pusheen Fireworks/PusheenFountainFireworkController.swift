import UIKit

final class PusheenFountainFireworkController: FountainFireworkController {

    override func createFirework(at origin: CGPoint, sparkSize: CGSize, scale: CGFloat) -> Firework {
        return PusheenFountainFirework(origin: origin, sparkSize: sparkSize, scale: scale)
    }
}
