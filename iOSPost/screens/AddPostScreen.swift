

import SwiftUI

struct AddPostScreen: View {
    @ObservedObject var database = RealtimeStore()
    @ObservedObject var storage = StorageStore()
    @Environment(\.presentationMode) var presentation
    @State var isLoading = false
    @State var title: String = ""
    @State var content: String = ""
    
    @State var defImage = UIImage(imageLiteralResourceName: "ic_picker")
    @State var pickedImage: UIImage? = nil
    @State var showImagePicker: Bool = false
    
    func addNewPost(urlString: String){
        let post = Post(title: title, content: content,imgUrl: urlString)
        database.storePost(post: post, completion: { success in
            isLoading = false
            if success {
                self.presentation.wrappedValue.dismiss()
            }
        })
    }
    
    func uploadImage(){
        isLoading = true
        storage.uploadImage(pickedImage!, completion: {downloadURL in
            let urlString = downloadURL!.absoluteString
            print(urlString)
            addNewPost(urlString: urlString)
        })
    }
    
    var body: some View {
        ZStack{
            VStack{
                Button(action: {
                    self.showImagePicker.toggle()
                }, label: {
                    Image(uiImage: pickedImage ?? defImage).resizable().frame(height: 100).frame(width: 100).scaledToFit()
                })
                .sheet(isPresented: $showImagePicker, onDismiss: {
                    self.showImagePicker = false
                }, content: {
                    ImagePicker(image: self.$pickedImage, isShown: self.$showImagePicker)
                })
                
                TextField("Title", text: $title)
                    .frame(height: 50).padding(.leading, 10)
                    .background(Color.gray.opacity(0.2)).cornerRadius(8)
                TextField("Content", text: $content)
                    .frame(height: 70).padding(.leading, 10)
                    .background(Color.gray.opacity(0.2)).cornerRadius(8)
                
                Button(action: {
                    //addNewPost()
                    uploadImage()
                }, label: {
                    Spacer()
                    Text("Add").foregroundColor(.white)
                    Spacer()
                })
                .frame(height: 45).background(Color.blue).cornerRadius(8)
                Spacer()
            }.padding()
            if isLoading {
                ProgressView()
            }
        }
    }
}

struct AddPostScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddPostScreen()
    }
}
