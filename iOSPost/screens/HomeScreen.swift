
import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var database = RealtimeStore()
    @State var isLoading = false
    
    func doSignOut(){
        isLoading = true
        if SessionStore().signOut() {
            isLoading = false
            session.listen()
        }
    }
    
    func apiPosts(){
        isLoading = true
        database.loadPosts {
            isLoading = false
            print(database.items.count)
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                
                List{
                    ForEach(database.items, id:\.self){ item in
                        PostCell(post: item)
                    }
                }.listStyle(PlainListStyle())
                
                if isLoading {
                    ProgressView()
                }
            }
            .navigationBarItems(trailing:
                                    HStack{
                                        NavigationLink(
                                            destination: AddPostScreen(),
                                            label: {
                                                Image("ic_add")
                                            })
                                        Button(action: {
                                            doSignOut()
                                        }, label: {
                                            Image("ic_exit")
                                        })
                                    }
            )
            .navigationBarTitle("Posts",displayMode: .inline)
        }.onAppear{
            apiPosts()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
