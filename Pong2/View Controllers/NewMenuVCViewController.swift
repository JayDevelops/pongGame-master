//
//  NewMenuVCViewController.swift
//  Pong2
//
//  Created by Jesus Perez on 7/24/18.
//  Copyright © 2018 Jesus Perez. All rights reserved.
//

import UIKit

//Enums for the certain game types for easier data
enum gameType {
    case easy
    case medium
    case hard
    case player2
}

class NewMenuVCViewController: UIViewController {
    
    
    //The buttons that are pressed
    @IBAction func Player(_ sender: Any) {
        moveToGame(game: .player2)
    }
    
    //When easy mode is pressed
    @IBAction func easyMode(_ sender: Any) {
        moveToGame(game: .easy)
    }
    
    //When medium mode is pressed
    @IBAction func mediumMode(_ sender: Any) {
        moveToGame(game: .medium)
    }
    
    //When hard mode is pressed
    @IBAction func hardMode(_ sender: Any) {
        moveToGame(game: .hard)
    }

    
    //Make a universal segue for the game view controller
    func moveToGame (game : gameType)  {
        //The variable to know what your game vc is
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        //Now let the navigation controller move to the scene where it needs to be at when the user clicks the mode
        self.navigationController?.pushViewController(gameVC, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
