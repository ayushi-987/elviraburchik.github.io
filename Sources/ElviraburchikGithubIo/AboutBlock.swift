import Foundation

enum ImageOrientation {
    case vertical
    case horizontal
}

extension ImageOrientation {
    func cssClass() -> String {
        switch self {
        case .horizontal:
            return "about-image-horizontal"
        case .vertical:
            return "about-image-vertical"
        }
    }
}

struct AboutBlock {
    let bodyIndexPath: String
    let imagePath: String?
    let imageOrientation: ImageOrientation?
    let header: String?
    let description: String?
    
    init(bodyIndexPath: String,
         imagePath: String,
         imageOrientation: ImageOrientation,
         header: String? = nil,
         description: String?  = nil) {
        self.bodyIndexPath = bodyIndexPath
        self.imagePath = imagePath
        self.imageOrientation = imageOrientation
        self.header = header
        self.description = description
    }
}

extension AboutBlock {
    static let flo = AboutBlock(bodyIndexPath: "Content/about/flo.md",
                                imagePath: "../flo.jpg",
                                imageOrientation: .vertical)
    
    static let mo = AboutBlock(bodyIndexPath: "Content/about/mo.md",
                                imagePath: "../mo_conf_2019.jpg",
                                imageOrientation: .horizontal,
                                header: "Event organization 🗓️",
                                description:
                                 """
                                    For some reason, I enjoy encouraging people to share their
                                    knowledge via public talks much more than speaking by myself, so 👇
                                """)
    
    static let meetups = AboutBlock(bodyIndexPath: "Content/about/meetups.md",
                                    imagePath: "../talk.jpg",
                                    imageOrientation: .horizontal)
}
