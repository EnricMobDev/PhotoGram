//
//  LogInViewController.swift
//  PhotoGram
//
//  Created by Enric Pou Villanueva on 13/8/18.
//  Copyright © 2018 Enric Pou Villanueva. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import Firebase

class LogInViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    // MARK: - Constants
    let FIRST_FIELD = 0
    let SECOND_FIELD = 1
    let WELCOME_VIEW_SEGUE = "showWelcomeView"
    let SECONDS_TO_WAIT_ANIMATION = 4
    
    // MARK: - IBOutlets
    @IBOutlet weak var loginEmailField: UITextField!
    @IBOutlet weak var loginPasswordField: UITextField!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        addGestureRecognizer()
        signInButton.style = .wide
    }

    
    // MARK: - IBActions
    @IBAction func signUpTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Nuevo Usuario",
                                      message: "Introduce tus datos por favor",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Guardar",
                                       style: .default) { (action) in
                                        
                                        if let secureTextfield = alert.textFields {
                                            
                                            if let emailField = secureTextfield[self.FIRST_FIELD].text, let passwordField = secureTextfield[self.SECOND_FIELD].text {
                                                
                                                Auth.auth().createUser(withEmail: emailField,
                                                                       password: passwordField) { user, error in
                                                }
                                            }
                                        }
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        if self.loginEmailField.text == "" || self.loginPasswordField.text == "" {
            
            let empyFieldError = "Por favor introduce email y contraseña"
            
            showAlertController(errorMessage: empyFieldError)
            
        } else {
            
            if let loginEmail = loginEmailField.text, let loginPassword = loginPasswordField.text {
                
                Auth.auth().signIn(withEmail: loginEmail, password: loginPassword) { (user, error) in
                    
                    if error == nil {
                        
                        self.addLoginAnimation()

                    } else {
                        
                        if let localizedError = error?.localizedDescription {
                            
                            self.showAlertController(errorMessage: localizedError)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func googleButton(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signIn()
    }

    @IBAction func recoverPassword(_ sender: Any) {
    }
    
    // MARK: - ShowAlerts
    public func showAlertController(errorMessage: String) {
        
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - AddGestureRecognizer
    private func addGestureRecognizer() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        let swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        swipe.direction = .down
        view.addGestureRecognizer(swipe)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - LoginAnimation
    public func addLoginAnimation() {
        
        let loginView = CorrectPasswordAnimation().showCorrectLoginAnimation()
        
        view.addSubview(loginView)
        
        goToWelcomeView()
    }
    
    private func goToWelcomeView() {
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + .seconds(self.SECONDS_TO_WAIT_ANIMATION), execute: {
            
            self.performSegue(withIdentifier: self.WELCOME_VIEW_SEGUE, sender: self)
        })
    }
    
    // MARK: - GoogleSignIn
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if let localizedError = error {
            
            self.showAlertController(errorMessage: localizedError.localizedDescription)
            
            return
        }
        
        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential, completion: { (user, error) in
            
            if let authError = error {
                
                self.showAlertController(errorMessage: authError.localizedDescription)
                
                return
            }
            
            self.addLoginAnimation()
        })
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}

