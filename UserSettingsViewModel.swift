//
//  UserSettingsViewModel.swift
//  Union_Forums
//
//  Created by Adam Long on 5/12/22.
//

import SwiftUI
import Firebase

class UserSettingsViewModel: ObservableObject
{
    @Published var userInfo = UserModel(username: "", firstname: "", lastname: "", ava: "", bio: "")
    
    @Published var imgPicker = false
    @Published var imgData = Data(count: 0)
    
    @Published var isLoading: Bool = false
    
    let ref = Firestore.firestore()
    let email = Auth.auth().currentUser!.email
    
    init()
    {
        fetchUser()
    }
    
    func fetchUser()
    {
        ref.collection("users").document(email!).getDocument(
            completion: {
                (doc, err) in
                guard let user = doc else {return}
                
                let username = user.data()?["username"] as! String
                let firstname = user.data()?["firstname"] as! String
                let lastname = user.data()?["lastname"] as! String
                let ava = user.data()?["ava"] as! String
                let bio = user.data()?["bio"] as! String
                
                
                
                DispatchQueue.main.async {
                    self.userInfo = UserModel(username: username, firstname: firstname, lastname: lastname, ava: ava, bio: bio)
                    
                }
            })
    }
    
//    func alertThing(msg: String, completion: @escaping (String) -> ())
//    {
//        let alert = UIAlertController(title: "Message", message: msg, preferredStyle: .alert)
//
//        alert.addTextField {(txt) in txt.placeholder = "123456"}
//
//        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive ))
//        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: {
//            (_) in
//            let code = alert.textFields![0].text ?? ""
//
//            if code == ""{
//                UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
//                return
//            }
//            completion(code)
//        }))
//        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
//    }
//
//    func updateInfo(field: String)
//    {
//        alertThing(msg: "Update \(field)", completion: {(txt) in
//            if txt != ""
//            {
//                ref.collection("users").document(email).updateData([
//                    field == "Name" ? "username" : txt,
//                ]) {err in
//                    if err != nil {return}
//                }
//            }
//        })
//    }
    
    func updateAvatar()
    {
        isLoading = true
        
        let bruh = AppAuthModel()
        
        bruh.uploadImage(imageData: imgData, path: "profile_Photos")
        {
            (url) in
            self.ref.collection("users").document(self.email!).updateData([
                "ava":url,
            ])
            {
                (err) in
                if err != nil{return}
                
                self.isLoading = false
                self.fetchUser()
            }
        }
    }
}
