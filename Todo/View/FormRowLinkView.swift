//
//  FormRowLinkView.swift
//  Todo App
//
//  Created by Christos Eteoglou on 2023-11-09.
//

import SwiftUI

struct FormRowLinkView: View {
    var icon: String
    var color: Color
    var text: String
    var link: String
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundStyle(Color.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(text)
                .foregroundStyle(Color.gray)
            
            Spacer()
            
            Button {
                guard let url = URL(string: self.link), UIApplication.shared.canOpenURL(url) else {
                    return
                }
                UIApplication.shared.open(url as URL)
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
            }
            .tint(Color(.systemGray2))
        }
    }
}

#Preview {
    FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://christoseteoglou.com")
}
