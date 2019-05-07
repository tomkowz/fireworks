import UIKit

public protocol ClassicSparkTrajectoryFactoryProtocol: SparkTrajectoryFactory {

    func randomTopRight() -> SparkTrajectory
    func randomBottomRight() -> SparkTrajectory
}
