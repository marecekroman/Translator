//
//  About.swift
//  Translator
//
//  Created by Roman Mareček on 25.12.2022.
//

import SwiftUI

struct About: View {
    var body: some View {
        VStack {
                ZStack{
                    Text("This application was made by Roman Marecek as a school project")
                    .foregroundColor(.red)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
