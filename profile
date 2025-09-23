import SwiftUI
import SwiftData
import PhotosUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.modelContext) private var context
    @Query private var users: [User]

    @State private var username: String = ""
    @State private var email: String = ""
    @State private var profileImageData: Data? = nil

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 28) {

                    // User Info
                    VStack(spacing: 8) {
                        if let data = profileImageData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.gray)
                                .clipShape(Circle())
                        }

                        Text(username.isEmpty ? "Guest" : username)
                            .font(.headline)
                        Text(email.isEmpty ? "Email not set" : email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 20)

                    NavigationLink(destination: EditProfileView(username: $username,
                                                               email: $email,
                                                               profileImageData: $profileImageData)) {
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

                    HStack {
                        Text("Switch Account")
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)

                    Divider()

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

                    Button(action: { appState.isLoggedIn = false }) {
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
                if let current = UserDefaults.standard.string(forKey: "currentUsername"),
                   let user = users.first(where: { $0.username == current }) {
                    username = user.username
                    email = user.email ?? ""
                    profileImageData = user.profileImage
                }
            }
        }
    }
}

struct EditProfileView: View {
    @Binding var username: String
    @Binding var email: String
    @Binding var profileImageData: Data?

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Query private var users: [User]

    @State private var newUsername: String = ""
    @State private var newPassword: String = ""
    @State private var newEmail: String = ""
    @State private var selectedItem: PhotosPickerItem? = nil

    var body: some View {
        VStack(spacing: 20) {
            Text("Edit Profile")
                .font(.largeTitle)
                .bold()
                .padding(.top)

            if let data = profileImageData,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
                    .clipShape(Circle())
            }

            TextField("Username", text: $newUsername)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            SecureField("Password", text: $newPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("Email", text: $newEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                Text("Change Profile Image")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .foregroundColor(.black)
                    .cornerRadius(25)
                    .padding(.horizontal)
            }
            .onChange(of: selectedItem) { newValue in
                guard let newValue else { return }
                Task {
                    if let data = try? await newValue.loadTransferable(type: Data.self) {
                        profileImageData = data
                    }
                }
            }

            Button(action: {
                guard let currentUsername = UserDefaults.standard.string(forKey: "currentUsername"),
                      let user = users.first(where: { $0.username == currentUsername }) else { return }

                if !newUsername.isEmpty { user.username = newUsername }
                if !newPassword.isEmpty { user.password = newPassword }
                if !newEmail.isEmpty { user.email = newEmail }
                if let img = profileImageData {
                    user.profileImage = img
                    // Save image to UserDefaults so HomeView/SearchView can access it
                    UserDefaults.standard.set(img, forKey: "savedProfileImage")
                }

                try? context.save()

                username = user.username
                email = user.email ?? ""
                UserDefaults.standard.set(user.username, forKey: "currentUsername")

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

            Button(action: { dismiss() }) {
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
