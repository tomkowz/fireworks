import UIKit

protocol SparkTrajectoryFactory {}

protocol DefaultSparkTrajectoryFactory: SparkTrajectoryFactory {

    func random() -> SparkTrajectory
}
