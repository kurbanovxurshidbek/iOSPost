
import SwiftUI

struct SignInScreen: View {
    @EnvironmentObject var session: SessionStore
    @State var isLoading = false
    @State var email = "khurshid@gmail.com"
    @State var password = "123qwe"
    
    func doSignIn(){
        isLoading = true
        SessionStore().signIn(email: email, password: password, handler: {(res,err) in
            isLoading = false
            if err != nil {
                print("Check email or password")
                return
            }
            print("User signed in")
            session.listen()
        })
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    Spacer()
                    Text("Welcome Back").font(.system(size: 30))
                    TextField("Email", text: $email)
                        .frame(height: 45).padding(.leading, 10)
                        .background(Color.gray.opacity(0.2)).cornerRadius(8)
                    SecureField("Password", text: $password)
                        .frame(height: 45).padding(.leading, 10)
                        .background(Color.gray.opacity(0.2)).cornerRadius(8)
                    Button(action: {
                        doSignIn()
                    }, label: {
                        Spacer()
                        Text("Sign In").foregroundColor(.white)
                        Spacer()
                    })
                    .frame(height: 45).background(Color.blue).cornerRadius(8)
                    Spacer()
                    VStack{
                        Spacer()
                        HStack{
                            Text("Don`t have an account?")
                            NavigationLink(
                                destination: SignUpScreen(),
                                label: {
                                    Text("Sign Up")
                                })
                        }
                    }.frame(maxWidth:.infinity, maxHeight: 200)
                }.padding()
                
                if isLoading {
                    ProgressView()
                }
            }
        }
    }
}

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}
