//
//  ProfileView.swift
//  Union_Forums
//
//  Created by Adam Long on 4/27/22.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseAuth

struct ProfileView: View
{
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @StateObject var settingsData = UserSettingsViewModel()
    //@State var showPhotoPickerView: Bool = false
    @State var status = false
    var appModel = AppAuthModel()
    @Binding var isLoggedIn: Bool
    @Binding var loginIsShowed: Bool
    
    var body: some View
    {
        VStack
        {
            HStack
            {//copy for new question lol
                
                Text("Posts")
                    .font(.custom("Righteous-Regular", size: 32.0))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    //action
                }, label: {
                    Image(systemName: "gear.badge.checkmark")
                        .font(.title)
                        .foregroundColor(.white)
                })
            }
            .padding()
            .padding(.top,edges!.top)//sum movie science shadow effect
            .background(Color.themeOrange)
            .shadow(color: Color.white.opacity(0.06), radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5.0)
            
            if settingsData.userInfo.ava != ""
            {
                ZStack
                {
                    WebImage(url: URL(string: settingsData.userInfo.ava))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 125, height: 125)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    
                    if settingsData.isLoading
                    {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.themeBlue))
                    }
                }
                .padding(.top, 25)
                .onTapGesture {
                    settingsData.imgPicker.toggle()
                }
            }
            else
            {
                ZStack
                {
                    Button(action:
                    {
                        settingsData.imgPicker.toggle()
                        //set photo to the ava var on firebase
                    }, label:
                    {
                        Image("placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125.0, height: 125.0)
                            .clipShape(Circle())
                    })
//                        .sheet(isPresented: $showPhotoPickerView)
//                        {
//                            PhotoSelectorView()
//                        }
                }
            }
            
            HStack(spacing: 15)
            {
                Text(settingsData.userInfo.username)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                //edit button? view notes
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "square.and.pencil")
                        .font(.custom("Righteous-Regular", size: 18.0))
                        .foregroundColor(.black)
                })
            }
            .padding()
            
            HStack(spacing: 15)
            {
                Text(settingsData.userInfo.bio)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                //edit button? view notes
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "square.and.pencil")
                        .font(.custom("Righteous-Regular", size: 18.0))
                        .foregroundColor(.black)
                })
            }
            
            Button(action: {
                status = appModel.logout(stat: status)//this doesnt work I quit for now
            }, label: {
                Text("Logout")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(4)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(Color.themeOrange)
                    .clipShape(Capsule())
            })
            .sheet(isPresented: $loginIsShowed)
            {
                LoginView(loginIsShowed: $loginIsShowed, isLoggedIn: $isLoggedIn)
            }
            
            Spacer()
            
        }
        .sheet(isPresented: $settingsData.imgPicker)
        {
            PhotoSelectorView(picker: $settingsData.imgPicker, imgData: $settingsData.imgData)
        }
        .onChange(of: settingsData.imgData, perform: { value in
            settingsData.updateAvatar()
        })
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(isLoggedIn: .constant(false), loginIsShowed: .constant(true))
    }
}
