import UIKit

public protocol SparkTrajectoryFactory {}

public protocol DefaultSparkTrajectoryFactory: SparkTrajectoryFactory {

    func random() -> SparkTrajectory
}
