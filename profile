import SwiftUI

// MARK: - Profile Screen
struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                // User Info
                VStack(spacing: 8) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                    
                    Text("Username")
                        .font(.headline)
                    
                    Text("Email.com")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 40)
                
                // View Profile Button
                Button(action: {
                    // Action for viewing profile
                }) {
                    Text("View Full Profile")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .padding(.horizontal)
                }
                
                Divider()
                
                // Switch Account
                HStack {
                    Text("Switch Account")
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                Divider()
                
                // Support Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Support")
                        .font(.headline)
                    
                    HStack {
                        Text("App feedback")
                        Spacer()
                        Image(systemName: "arrow.up.right")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Help centre")
                        Spacer()
                        Image(systemName: "arrow.up.right")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                // Preferences Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Preferences")
                        .font(.headline)
                    
                    HStack {
                        Text("Language")
                        Spacer()
                        Text("English")
                            .foregroundColor(.gray)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Notification")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Logout Button
                Button(action: {
                    // Log out action
                }) {
                    Text("Log out")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .padding(.horizontal)
                }
                .padding(.bottom, 20)
            }
            .navigationBarTitle("Account", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

// MARK: - Update HomeView Header
struct HomeView: View {
    @State private var showProfile = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Fixed Header
            HStack {
                Text("Home")
                    .font(.system(size: 28, weight: .bold))
                
                Spacer()
                
                Button(action: {
                    showProfile.toggle()
                }) {
                    Text("Done")
                        .font(.system(size: 16, weight: .semibold))
                }
                .sheet(isPresented: $showProfile) {
                    ProfileView()
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Spacer()
        }
    }
}
