//
//  SignUpView.swift
//  Union_Forums
//
//  Created by Adam Long on 5/3/22.
//

import SwiftUI

struct SignUpView: View
{
    
    @Binding var showLoginAlert: Bool
    @Binding var isLoggedIn: Bool
    @Binding var loginIsShowed: Bool
    
    @State var username: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var ava: String = ""
    @State var bio: String = ""
    @State var confirmPassword: String = ""
    @State var errorMessage: String = ""
    
    let authThing = AppAuthModel()
    
    var body: some View
    {
        VStack()
        {
            Image("U")//lol
                .resizable()
                .scaledToFit()
                .padding(.bottom)
                .padding(10)
                .shadow(radius: 5.0, x: 10, y: 10)
                .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            VStack(alignment: .leading, spacing: 10) //Logo Camera w/ a U in the lens
            {
                TextField("First Name", text: self.$firstName)//or maybe a video camera
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 10, y: 10)
                    .disableAutocorrection(true)
                
                TextField("Last Name", text: self.$lastName)//or maybe a video camera
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 10, y: 10)
                    .disableAutocorrection(true)
                
                TextField("Username", text: self.$username)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 10, y: 10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                TextField("Email", text: self.$email)//or maybe a video camera
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 10, y: 10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: self.$password)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                SecureField("Confirm Password", text: self.$confirmPassword)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding([.leading, .trailing], 27.5)
            
            
            Button(action:
            {
                if email.isEmpty || password.isEmpty || confirmPassword.isEmpty
                {
                    errorMessage = "Please enter an email and/or password."
                    showLoginAlert.toggle()
                    return
                }
                if !(confirmPassword.elementsEqual(password))
                {
                    errorMessage = "Passwords do not match."
                    showLoginAlert.toggle()
                    return
                }
                
                authThing.signup(email: email, pass: password)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
                {
                    
                    if authThing.errorStr != ""//PROBLEM: I FIXED ITT!!!!
                    {//Took me 1 whole hour to figure out...
                        showLoginAlert.toggle()
                        errorMessage = authThing.errorStr
                        return
                    }
                    isLoggedIn.toggle()
                    loginIsShowed.toggle()
                }
                authThing.errorStr = ""
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
                {
                    authThing.login(email: email, pass: password)
                    authThing.createProfile(email: email, user: username, first: firstName, last: lastName, ava: ava, bio: bio)
                }
                
            })
            {
                Text("Signup")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.themeBlue)
                    .cornerRadius(15.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }
            .padding(.top, 20)//1:06 video time is critical & 1:23 is for videos
            
            /*
             https://www.youtube.com/watch?v=1HN7usMROt8
             */
            .alert(isPresented: $showLoginAlert)
            {
                authThing.errorShowAlert(error: errorMessage)
            }
            
            
            Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.themeOrange, Color.orange]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showLoginAlert: .constant(false), isLoggedIn: .constant(false), loginIsShowed: .constant(true))
    }
}
