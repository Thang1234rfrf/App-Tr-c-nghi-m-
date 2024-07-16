import UIKit
import Firebase
import GoogleSignIn

class FirstControll: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let signInButton = GIDSignInButton()
        signInButton.center = view.center
        view.addSubview(signInButton)

        // Automatically sign in the user.
//        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
//            if let error = error {
//                print("Error restoring previous sign-in: \(error)")
//            } else if let user = user {
//                self.handleSignIn(user: user)
//            }
//        }
        
    }
    @IBAction func ok(_ sender: Any) {
    
    
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//
//        let configuration = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = configuration
//
//        GIDSignIn.sharedInstance.signIn(withPresenting: self ) { result, error in
//            if let error = error {
//                print("Error signing in: \(error)")
//                return
//            }
//
//            guard let user = result?.user else { return }
//            self.handleSignIn(user: user)
            
//        }
       

       
    }

    func handleSignIn(user: GIDGoogleUser) {
        guard let idToken = user.idToken?.tokenString else { return }
        let accessToken = user.accessToken.tokenString

        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: accessToken)

        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Firebase sign-in error: \(error)")
                return
            }
            // User is signed in
            // Perform any operations on signed in user here.
            print("User signed in: \(authResult?.user.email ?? "No email")")
        }
    }
}
