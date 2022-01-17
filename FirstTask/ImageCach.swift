import Foundation
import UIKit

// MARK: - ThemeManager

final class ImageCach {
    private let imageCache = NSCache<NSString, UIImage>()
    private(set) var imageKeys: [NSString]
    
    init() {
        imageKeys = []
        for i in 1...40 {
            imageKeys.append(NSString(string: "image\(i)"))
        }
    }
    
    func fetchImage(atIndex index: Int, resizedTo size: CGSize, completion: @escaping (UIImage?, Int) -> Void) {
        guard 0 <= index, index < imageKeys.count else {
            assertionFailure("Image with invalid index requested")
            completion(nil, index)
            return
        }
        
        let imageKey = imageKeys[index]
         
        if let cachedImage = imageCache.object(forKey: imageKey) {
            completion(cachedImage, index)
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {
                completion(nil, index)
                return
            }
            guard let image = UIImage(named: String(imageKey)) else {
                assertionFailure("Image is missing from the asset catalog")
                completion(nil, index)
                return
            }
            
            let resizedImage = image.resized(to: size)
            
            self.imageCache.setObject(resizedImage, forKey: imageKey)
            completion(resizedImage, index)
        }
    }
}

extension UIImage {
    func resized(to targetSize: CGSize) -> UIImage {
        let widthRatio  = (targetSize.width  / size.width)
        let heightRatio = (targetSize.height / size.height)
        let effectiveRatio = max(widthRatio, heightRatio)
        let newSize = CGSize(width: size.width * effectiveRatio, height: size.height * effectiveRatio)
        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
