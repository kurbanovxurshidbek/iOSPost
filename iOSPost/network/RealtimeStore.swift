

import Foundation
import SwiftUI
import Firebase
import FirebaseDatabase

class RealtimeStore: ObservableObject {
    var ref: DatabaseReference = Database.database().reference(withPath: "posts")
    @Published var items: [Post] = []
    
    func storePost(post: Post, completion: @escaping (_ success: Bool) -> ()) {
        var success = true
        let toBePosted = ["title": post.title!, "content": post.content!, "imgUrl": post.imgUrl!]
        
        ref.childByAutoId().setValue(toBePosted){ (error, ref) -> Void in
            if error != nil{
                success =  false
            }
        }
        completion(success)
    }
    
    func loadPosts(completion: @escaping () -> ()) {
        ref.observe(DataEventType.value) { (snapshot) in
            self.items = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    let value = snapshot.value as? [String: AnyObject]
                    let title = value!["title"] as? String
                    let content = value!["content"] as? String
                    let imgUrl = value!["imgUrl"] as? String
                    self.items.append(Post(title: title, content: content,imgUrl: imgUrl))
                }
            }
            completion()
        }
    }
}
