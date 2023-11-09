//
//  FormRowStaticView.swift
//  Todo App
//
//  Created by Christos Eteoglou on 2023-11-09.
//

import SwiftUI

struct FormRowStaticView: View {
    var icon: String
    var firstText: String
    var secondText: String
    
    var body: some View {
      HStack {
        ZStack {
          RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(Color.gray)
          Image(systemName: icon)
            .foregroundColor(Color.white)
        }
        .frame(width: 36, height: 36, alignment: .center)
        
        Text(firstText).foregroundColor(Color.gray)
        Spacer()
        Text(secondText)
      }
    }
  }

#Preview {
    FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
        .previewLayout(.fixed(width: 375, height: 60))
        .padding()
}
