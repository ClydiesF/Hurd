//
//  DiscoveryView.swift
//  Hurd
//
//  Created by clydies freeman on 12/30/22.
//

import SwiftUI

struct DiscoveryView: View {
    @EnvironmentObject var vm: AuthenticationViewModel
    
    var body: some View {
        VStack {
            Text("Discovery View")
            
            Button("Sign out") {
                vm.signout()
            }
        }
    }
}

struct DiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveryView()
    }
}
