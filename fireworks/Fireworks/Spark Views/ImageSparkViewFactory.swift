import UIKit

struct ImageSparkViewFactoryData: SparkViewFactoryData {

    let image: UIImage
    let size: CGSize
    let index: Int
}

struct ImageSparkViewFactory: SparkViewFactory {

    func create(with data: SparkViewFactoryData) -> SparkView {
        guard let data = data as? ImageSparkViewFactoryData else {
            fatalError("Wrong data.")
        }

        return ImageSparkView(image: data.image, size: data.size)
    }
}
