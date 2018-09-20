import UIKit

class ClassicFirework: Firework {

    /**
     x     |     x
        x  |   x
           |
     ---------------
         x |  x
       x   |
           |     x
     **/

    private struct FlipOptions: OptionSet {

        let rawValue: Int

        static let horizontally = FlipOptions(rawValue: 1 << 0)
        static let vertically = FlipOptions(rawValue: 1 << 1)
    }

    private enum Quarter {

        case topRight
        case bottomRight
        case bottomLeft
        case topLeft
    }

    var origin: CGPoint
    var scale: CGFloat
    var sparkSize: CGSize

    var maxChangeValue: Int {
        return 10
    }

    var trajectoryFactory: SparkTrajectoryFactory {
        return ClassicSparkTrajectoryFactory()
    }

    var classicTrajectoryFactory: ClassicSparkTrajectoryFactoryProtocol {
        return self.trajectoryFactory as! ClassicSparkTrajectoryFactoryProtocol
    }

    var sparkViewFactory: SparkViewFactory {
        return CircleColorSparkViewFactory()
    }

    private var quarters = [Quarter]()

    init(origin: CGPoint, sparkSize: CGSize, scale: CGFloat) {
        self.origin = origin
        self.scale = scale
        self.sparkSize = sparkSize
        self.quarters = self.shuffledQuarters()
    }

    func sparkViewFactoryData(at index: Int) -> SparkViewFactoryData {
        return DefaultSparkViewFactoryData(size: self.sparkSize, index: index)
    }

    func sparkView(at index: Int) -> SparkView {
        return self.sparkViewFactory.create(with: self.sparkViewFactoryData(at: index))
    }

    func trajectory(at index: Int) -> SparkTrajectory {
        let quarter = self.quarters[index]
        let flipOptions = self.flipOptions(for: quarter)
        let changeVector = self.randomChangeVector(flipOptions: flipOptions, maxValue: self.maxChangeValue)
        let sparkOrigin = self.origin.adding(vector: changeVector)
        return self.randomTrajectory(flipOptions: flipOptions).scale(by: self.scale).shift(to: sparkOrigin)
    }

    private func flipOptions(`for` quarter: Quarter) -> FlipOptions {
        var flipOptions: FlipOptions = []
        if quarter == .bottomLeft || quarter == .topLeft {
            flipOptions.insert(.horizontally)
        }

        if quarter == .bottomLeft || quarter == .bottomRight {
            flipOptions.insert(.vertically)
        }

        return flipOptions
    }

    private func shuffledQuarters() -> [Quarter] {
        var quarters: [Quarter] = [
            .topRight, .topRight,
            .bottomRight, .bottomRight,
            .bottomLeft, .bottomLeft,
            .topLeft, .topLeft
        ]

        var shuffled = [Quarter]()
        for _ in 0..<quarters.count {
            let idx = Int(arc4random_uniform(UInt32(quarters.count)))
            shuffled.append(quarters[idx])
            quarters.remove(at: idx)
        }

        return shuffled
    }

    private func randomTrajectory(flipOptions: FlipOptions) -> SparkTrajectory {
        var trajectory: SparkTrajectory

        if flipOptions.contains(.vertically) {
            trajectory = self.classicTrajectoryFactory.randomBottomRight()
        } else {
            trajectory = self.classicTrajectoryFactory.randomTopRight()
        }

        return flipOptions.contains(.horizontally) ? trajectory.flip() : trajectory
    }

    private func randomChangeVector(flipOptions: FlipOptions, maxValue: Int) -> CGVector {
        let values = (self.randomChange(maxValue), self.randomChange(maxValue))
        let changeX = flipOptions.contains(.horizontally) ? -values.0 : values.0
        let changeY = flipOptions.contains(.vertically) ? values.1 : -values.0
        return CGVector(dx: changeX, dy: changeY)
    }

    private func randomChange(_ maxValue: Int) -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(maxValue)))
    }
}
