//
//  FireBase.swift
//  Union_Forums
//
//  Created by Adam Long on 5/1/22.
//

import SwiftUI
import Firebase
import FirebaseStorage

public class AppAuthModel: ObservableObject
{
    var errorStr: String = ""
    let auth = Auth.auth()
    
    //UID refers to the UID inputed & Error is an optional return refering to any errors returned.
    
    func login(email: String, pass: String)
    {
        auth.signIn(withEmail: email, password: pass)
        {
            uid, error in
            guard error == nil else
            {
                self.errorStr = error!.localizedDescription
                if self.errorStr.elementsEqual("There is no user record corresponding to this identifier. The user may have been deleted.")
                {
                    self.errorStr = "Email does not exist."
                }
                if self.errorStr.elementsEqual("The password is invalid or the user does not have a password.")
                {
                    self.errorStr = "Password is incorrect."
                }
                return//both of these repeat themselves.
            }
        }
    }
    
    func signup(email: String, pass: String)
    {
        auth.createUser(withEmail: email, password: pass)
        {
            uid, error in
            guard error == nil else
            {
                self.errorStr = error!.localizedDescription
                return
            }
        }
    }
    
    func logout(stat: Bool) -> Bool
    {
        try! auth.signOut()
        
        return !stat
    }
    
    func uploadImage(imageData: Data, path: String, completion: @escaping (String) -> ())
    {
        let storage = Storage.storage().reference()
        let email = auth.currentUser!.email as! String//might need it to be UID but idk yet.
        
        storage.child(path).child(email).putData(imageData, metadata: nil)
        {
            (_, err) in
            
            if err != nil
            {
                completion("")
                return
                
            }
            //21:00 ep1 for moah
            storage.child(path).child(email).downloadURL
            {
                (url, err) in
                if err != nil
                {
                    completion("")
                    return
                    
                }
                
                completion("\(url!)")
            }
        }
    }
    
    func createProfile(email: String, user: String, first: String, last: String, ava: String, bio: String)
    {
        let collectionRef = Firestore.firestore().collection("users")
        
        collectionRef.document(email).setData(
        [
//            "UID": userUID,
            "username": user,
            "firstname": first,
            "lastname": last,
            "ava": ava,
            "bio": bio
        ])
    }
    
//    func updateInformation(type: String, value: String)
//    {
//        let collectionRef = Firestore.firestore().collection("users")
//        guard let userEmail: String = auth.currentUser?.email else {return}
//
//        collectionRef.document(userEmail).updateData([
//            type: value,
//        ]) {err in
//            if err != nil {return}
//        }
//    }
    
    
    func errorShowAlert(error: String) -> Alert
    {
        return Alert(title: Text(error), dismissButton: .default(Text("Okay")))
    }
}
