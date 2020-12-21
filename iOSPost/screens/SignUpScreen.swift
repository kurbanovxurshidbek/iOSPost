

import SwiftUI

struct SignUpScreen: View {
    @Environment(\.presentationMode) var presentation
    @State var isLoading = false
    @State var fullname = ""
    @State var email = ""
    @State var password = ""
    
    func doSignUp(){
        isLoading = true
        SessionStore().signUp(email: email, password: password, handler: {(res, err) in
            isLoading = false
            if err != nil {
                print("User not created")
                return
            }
            print("User created")
            presentation.wrappedValue.dismiss()
        })
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    Spacer()
                    Text("Create your account").font(.system(size: 30))
                    TextField("Fullname", text: $fullname)
                        .frame(height: 45).padding(.leading, 10)
                        .background(Color.gray.opacity(0.2)).cornerRadius(8)
                    TextField("Email", text: $email)
                        .frame(height: 45).padding(.leading, 10)
                        .background(Color.gray.opacity(0.2)).cornerRadius(8)
                    SecureField("Password", text: $password)
                        .frame(height: 45).padding(.leading, 10)
                        .background(Color.gray.opacity(0.2)).cornerRadius(8)
                    Button(action: {
                        doSignUp()
                    }, label: {
                        Spacer()
                        Text("Sign Up").foregroundColor(.white)
                        Spacer()
                    })
                    .frame(height: 45).background(Color.blue).cornerRadius(8)
                    Spacer()
                    
                    VStack{
                        Spacer()
                        HStack{
                            Text("Already have an account?")
                            Button(action: {
                                self.presentation.wrappedValue.dismiss()
                            }, label: {
                                Text("Sign In")
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

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
