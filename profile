import SwiftUI

struct ProfileView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var navigateToEdit = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 28) {
                    
                    // User Info
                    VStack(spacing: 8) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                        
                        Text(username.isEmpty ? "Guest" : username)
                            .font(.headline)
                        
                        Text(email.isEmpty ? "Email not set" : email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 20)
                    
                    // View / Edit Profile Button
                    NavigationLink(destination: EditProfileView(username: $username, email: $email)) {
                        Text("Edit Profile")
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
                    VStack(alignment: .leading, spacing: 20) {
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
                    VStack(alignment: .leading, spacing: 20) {
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
                    
                    Spacer(minLength: 30)
                    
                    // Logout Button
                    Button(action: {
                        // Clear saved credentials and go back to LoginView
                        UserDefaults.standard.removeObject(forKey: "savedUsername")
                        UserDefaults.standard.removeObject(forKey: "savedPassword")
                        UserDefaults.standard.removeObject(forKey: "savedEmail")
                        
                        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            if let window = scene.windows.first {
                                window.rootViewController = UIHostingController(rootView: LoginView())
                                window.makeKeyAndVisible()
                            }
                        }
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
                    .padding(.bottom, 150)
                }
            }
            .onAppear {
                // Load saved user data
                username = UserDefaults.standard.string(forKey: "savedUsername") ?? ""
                email = UserDefaults.standard.string(forKey: "savedEmail") ?? ""
            }
        }
    }
}

struct EditProfileView: View {
    @Binding var username: String
    @Binding var email: String
    
    @State private var newUsername: String = ""
    @State private var newPassword: String = ""
    @State private var newEmail: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Edit Profile")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            
            TextField("Username", text: $newUsername)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            SecureField("Password", text: $newPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Email", text: $newEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            // Save Button
            Button(action: {
                if !newUsername.isEmpty {
                    username = newUsername
                    UserDefaults.standard.set(newUsername, forKey: "savedUsername")
                }
                
                if !newPassword.isEmpty {
                    UserDefaults.standard.set(newPassword, forKey: "savedPassword")
                }
                
                if !newEmail.isEmpty {
                    email = newEmail
                    UserDefaults.standard.set(newEmail, forKey: "savedEmail")
                }
                
                dismiss()
            }) {
                Text("Save Changes")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding(.horizontal)
            }
            
            // Back Button
            Button(action: {
                dismiss()
            }) {
                Text("Cancel")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .foregroundColor(.black)
                    .cornerRadius(25)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .onAppear {
            newUsername = username
            newEmail = email
        }
    }
}

#Preview {
    ProfileView()
}
