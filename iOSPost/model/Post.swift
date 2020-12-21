

import Foundation

struct Post: Hashable {
    var title: String?
    var content: String?
    var imgUrl: String?
    
    init(title: String?, content: String?) {
        self.title = title
        self.content = content
    }
    
    init(title: String?, content: String?, imgUrl: String?) {
        self.title = title
        self.content = content
        self.imgUrl = imgUrl
    }
}
