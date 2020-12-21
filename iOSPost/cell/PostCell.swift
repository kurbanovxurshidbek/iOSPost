

import SwiftUI
import SDWebImageSwiftUI

struct PostCell: View {
    var post: Post
    
    var body: some View {
        HStack{
            if post.imgUrl != nil {
                WebImage(url: URL(string: post.imgUrl!))
                    .resizable()
                    .frame(height:100).frame(width:100)
            }else{
                Image("ic_picker").resizable().frame(height:100).frame(width:100)
            }
            VStack(alignment: .leading){
                
                Text(post.title!.uppercased())
                    .fontWeight(.bold)
                Text(post.content!).padding(.top,5)
            }.padding()
        }
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post: Post(title: "title", content: "content"))
    }
}
