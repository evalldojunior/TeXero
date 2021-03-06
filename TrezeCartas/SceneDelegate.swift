//
//  SceneDelegate.swift
//  TrezeCartas
//
//  Created by Wilton Ramos on 05/02/21.
//

import UIKit
import SwiftUI
import GameKit

protocol GameCenterDelegate {
    func presentGameCenter()
}


class HostControllerWithGameCenter<T>: UIHostingController<T>, GKGameCenterControllerDelegate where T: View {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate, GameCenterDelegate {
    func presentGameCenter() {
        let vc = GKGameCenterViewController()
                
        vc.gameCenterDelegate = window!.rootViewController as? GKGameCenterControllerDelegate
                vc.viewState = .achievements
                
                //vc.leaderboardIdentifier = "LGPC.highscore"
        window!.rootViewController!.present(vc, animated: true)
    }
    

    var window: UIWindow?

    func authenticateUser(_ viewController: UIViewController) {
        
        let localPlayer: GKLocalPlayer = GKLocalPlayer.local
        
        localPlayer.authenticateHandler = { (vc, error) -> Void in
            if let vc = vc {
                //show game center sign in controller
                viewController.present(vc, animated: true, completion: nil)
               
            }
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Get the managed object context from the shared persistent container.
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
        // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
        let contentView = MenuDecksView(gameCenterDelegate: self).environment(\.managedObjectContext, context)

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = HostControllerWithGameCenter(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
            
            self.authenticateUser(window.rootViewController!)
            
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

class HostingController<ContentView>: UIHostingController<ContentView> where ContentView : View {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
