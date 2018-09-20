import UIKit

final class DuckFountainFirework: FountainFirework {

    override var sparkViewFactory: SparkViewFactory {
        return DuckSparkViewFactory()
    }
}
