import UIKit

public class ClassicFireworkController {

    public init() {}

    public var sparkAnimator: SparkViewAnimator {
        return ClassicFireworkAnimator()
    }

    public func createFirework(at origin: CGPoint, sparkSize: CGSize, scale: CGFloat) -> Firework {
        return ClassicFirework(origin: origin, sparkSize: sparkSize, scale: scale)
    }

    /// It allows fireworks to explodes in close range of corners of a source view
    public func addFireworks(count fireworksCount: Int = 1,
                      sparks sparksCount: Int = 8,
                      around sourceView: UIView,
                      sparkSize: CGSize = CGSize(width: 7, height: 7),
                      scale: CGFloat = 45.0,
                      maxVectorChange: CGFloat = 15.0,
                      animationDuration: TimeInterval = 0.4,
                      canChangeZIndex: Bool = true) {
        guard let superview = sourceView.superview else { fatalError() }

        let origins = [
            CGPoint(x: sourceView.frame.minX, y: sourceView.frame.minY),
            CGPoint(x: sourceView.frame.maxX, y: sourceView.frame.minY),
            CGPoint(x: sourceView.frame.minX, y: sourceView.frame.maxY),
            CGPoint(x: sourceView.frame.maxX, y: sourceView.frame.maxY),
        ]

        for _ in 0..<fireworksCount {
            let idx = Int(arc4random_uniform(UInt32(origins.count)))
            let origin = origins[idx].adding(vector: self.randomChangeVector(max: maxVectorChange))

            let firework = self.createFirework(at: origin, sparkSize: sparkSize, scale: scale)

            for sparkIndex in 0..<sparksCount {
                let spark = firework.spark(at: sparkIndex)
                spark.sparkView.isHidden = true
                superview.addSubview(spark.sparkView)

                if canChangeZIndex {
                    let zIndexChange: CGFloat = arc4random_uniform(2) == 0 ? -1 : +1
                    spark.sparkView.layer.zPosition = sourceView.layer.zPosition + zIndexChange
                } else {
                    spark.sparkView.layer.zPosition = sourceView.layer.zPosition
                }

                self.sparkAnimator.animate(spark: spark, duration: animationDuration)
            }
        }
    }

    private func randomChangeVector(max: CGFloat) -> CGVector {
        return CGVector(dx: self.randomChange(max: max), dy: self.randomChange(max: max))
    }

    private func randomChange(max: CGFloat) -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(max))) - (max / 2.0)
    }
}

