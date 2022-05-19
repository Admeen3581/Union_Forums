//
//  NewQuestionView.swift
//  Union_Forums
//
//  Created by Adam Long on 4/27/22.
//

import SwiftUI

struct NewQuestionView: View
{
    
    @State var question: String = ""
    
    var body: some View
    {
        ScrollView
        {
            VStack(alignment: .center, spacing: 0.10)
            {
                TextField("Ask Away!", text: self.$question)//or maybe a video camera
                    
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                
            }
        }
    }
}

struct NewQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        NewQuestionView()
    }
}

/*
 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/,
        label:
 {
     /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
 })
     .contextMenu(menuItems:
     {
         /*@START_MENU_TOKEN@*/Text("Menu Item 1")/*@END_MENU_TOKEN@*/
         /*@START_MENU_TOKEN@*/Text("Menu Item 2")/*@END_MENU_TOKEN@*/
         /*@START_MENU_TOKEN@*/Text("Menu Item 3")/*@END_MENU_TOKEN@*/
     })
 */
