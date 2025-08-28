import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                // Header
                HStack {
                    Text("Account")
                        .font(.system(size: 28, weight: .bold))
                    
                    Spacer()
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Scrollable Content
                ScrollView {
                    VStack(spacing: 24) { // Increased spacing
                        
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
                        .padding(.top, 20)
                        
                        // View Profile Button
                        Button(action: {}) {
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
                        VStack(alignment: .leading, spacing: 20) { // More spacing
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
                        VStack(alignment: .leading, spacing: 20) { // More spacing
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
                        
                        Spacer(minLength: 80) // Space before logout bar
                    }
                }
            }
            
            // Fixed Logout Button at bottom
            VStack {
                Spacer()
                Button(action: {}) {
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
        }
    }
}

