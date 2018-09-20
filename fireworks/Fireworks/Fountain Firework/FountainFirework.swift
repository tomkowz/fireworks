import UIKit

class FountainFirework: Firework {

    /**
      x   x x  x x
         x   x x
       x   x    x
        x x x x
         x x x
          x x
           x
           x
     -------------
    **/

    var origin: CGPoint
    var scale: CGFloat
    var sparkSize: CGSize

    var maxChangeValue: Int {
        return 10
    }

    var trajectoryFactory: SparkTrajectoryFactory {
        return FountainSparkTrajectoryFactory()
    }

    private var defaultTrajectoryFactory: DefaultSparkTrajectoryFactory {
        return self.trajectoryFactory as! DefaultSparkTrajectoryFactory
    }

    var sparkViewFactory: SparkViewFactory {
        return CircleColorSparkViewFactory()
    }

    init(origin: CGPoint, sparkSize: CGSize, scale: CGFloat) {
        self.origin = origin
        self.sparkSize = sparkSize
        self.scale = scale
    }

    func sparkViewFactoryData(at index: Int) -> SparkViewFactoryData {
        return DefaultSparkViewFactoryData(size: self.sparkSize, index: index)
    }

    func sparkView(at index: Int) -> SparkView {
        return self.sparkViewFactory.create(with: self.sparkViewFactoryData(at: index))
    }

    func trajectory(at index: Int) -> SparkTrajectory {
        return self.defaultTrajectoryFactory.random().scale(by: self.scale).shift(to: self.origin)
    }
}
