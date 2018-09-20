import UIKit

final class DuckSparkViewFactory: SparkViewFactory {

    func create(with data: SparkViewFactoryData) -> SparkView {
        guard let image = UIImage(named: "duck") else {
            fatalError("Couldn't find a duck!")
        }

        return ImageSparkView(image: image, size: data.size)
    }
}
