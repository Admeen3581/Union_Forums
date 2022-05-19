//
//  LoginView.swift
//  Union_Forums
//
//  Created by Adam Long on 4/21/22.
//

import SwiftUI

struct LoginView: View
{
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showLoginAlert: Bool = false
    @State private var errorMessage: String = ""
    
    @Binding var loginIsShowed: Bool
    @Binding var isLoggedIn: Bool
    
    let authThing = AppAuthModel()
    
    var body: some View
    {
        NavigationView
        {
            VStack()
            {
                Image("U")//lol
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom)
                    .padding(30)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .frame(width: 350, height: 350, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .leading, spacing: 15) //Logo Camera w/ a U in the lens
                {
                    TextField("Email", text: self.$email)//or maybe a video camera
                        
                        .padding()
                        .background(Color.themeTextField)
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    SecureField("Password", text: self.$password)
                        
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
                    if email.isEmpty || password.isEmpty
                    {
                        showLoginAlert.toggle()
                        errorMessage = "Please enter an email and/or password."
                        return
                    }else{
                        email = email.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: .illegalCharacters)
                        password = password.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: .illegalCharacters)
                    }
                    
                    authThing.login(email: email, pass: password)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6)
                    {
                        if authThing.errorStr != ""//PROBLEM: I FIXED ITT!!!!
                        {//Took me 1 whole hour to figure out...
                            showLoginAlert.toggle()
                            errorMessage = authThing.errorStr
                            return
                        }
                        
                        loginIsShowed.toggle()
                        isLoggedIn.toggle()
                    }
                    
                    authThing.errorStr = ""
                })
                {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.themeBlue)
                        .cornerRadius(15.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                }
                .padding(.top, 50)
                .alert(isPresented: $showLoginAlert)
                {
                    authThing.errorShowAlert(error: errorMessage)
                }
                
                Spacer()//for the biggy boiz
                
                    HStack(spacing: 0)
                    {
                        Text("New? Make an account ")//wtf is dis wording
                            .padding(.bottom, 20)
                            .font(.footnote)
                    
                        
                        NavigationLink(destination: SignUpView(showLoginAlert: $showLoginAlert, isLoggedIn: $isLoggedIn, loginIsShowed: $loginIsShowed),
                            label:
                            {
                                Text("Sign Up")
                                    .padding(.bottom, 20)
                                    .font(.footnote)
                            })
                    }
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.themeOrange, Color.orange]), startPoint: .top, endPoint: .bottom))
            .navigationBarTitle("Login")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
        }
    }
}
//Colors
extension Color
{
    static var themeTextField: Color
    {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}
extension Color
{
    static var themeOrange: Color
    {
        return Color(red: 252.0/255.0, green: 105.0/255.0, blue: 0.0/255.0, opacity: 1.0)
    }
}
extension Color
{
    static var themeBlue: Color
    {
        return Color(red: 43.0/255.0, green: 102.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}



struct LoginView_Previews: PreviewProvider
{
    static var previews: some View
    {
        LoginView(loginIsShowed: .constant(true), isLoggedIn: .constant(false))
    }
}

