//
//  GameScene.swift
//  Pong2
//
//  Created by Jesus Perez on 7/21/18.
//  Copyright © 2018 Jesus Perez. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //Make those variables to SKSprite Nodes, Global Scope
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    //Now make those labels into SKSprite node Labels
    var bottomLabel = SKLabelNode()
    var topLabel = SKLabelNode()
    
    //Make a count score
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        //Now set those variables to the name for the labels
        bottomLabel = self.childNode(withName: "bottomLabel") as! SKLabelNode
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        
        //Set those variables to their sk sprite nodes objects
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        //Place the paddles programatically according to the size of the screen
        enemy.position.y = (self.frame.height / 2) - 50
        main.position.y = (-self.frame.height / 2) + 50
        
        //Give the view a frame from a border
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        //Now add that border to the view so the ball can bounce!
        self.physicsBody = border
        
        //Start the game here
        startGame()
    
    }
    
    
    
    // MARK: Start the Game Function Here
    func startGame() {
        score = [0,0]
        
        //The Starting labels here
        bottomLabel.text = "\(score[0])"
        topLabel.text = "\(score[1])"
        
        //launch the ball with the physics body method to the ball
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
    }
    
    
    // MARK: Add The Score and make the ball go different according to who won!
    func addScore(playerWhoWon : SKSpriteNode) {
        //Remove the forces (velocity) and center the ball again before the if,else stuff
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        
        //Make the randomness in here
        let dxValues = [9, 10, 11, 10, 10, 11, 10, 11, 10, 9, 10]
        let dyValues = [10, 10, 10, 11, 10, 10, 9, 10, 11, 10, 10]
        
        var randomDX = dxValues[Int(arc4random_uniform(10))]
        var randomDY = dyValues[Int(arc4random_uniform(10))]
        
        if randomDY == randomDX {
            randomDY += 1
            randomDX -= 1
        }
        
        print("RandomDX: \(randomDX), RandomDY: \(randomDY)")

        
        //Statements to check who won and add the score approptiately
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -randomDX, dy: -randomDY))
        }   else if playerWhoWon == enemy   {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: randomDX, dy: randomDY))
        }
        
        //make those labels change with the array dynamically as somebody scores
        bottomLabel.text = "\(score[0])"
        topLabel.text = "\(score[1])"
    }
    
        
    ////////////
    // MARK: Make the Paddle Move for the player
    
    //When the on the x axis will be updated to that paddle on the first touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches  {
            //Grabs the location of the view from your touch
            let location = touch.location(in: self)
            
        //If theres a second player mode selected by the user
        if currentGameType == .player2 {
                
                //If the location is at the top, for the top player? Oh yea the enemy haha
                if location.y > 0   {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
                
                //If the location is at the bottom, for the bottom player? Oh yea it is for the bottom
                if location.y < 0   {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
                
                //Else if its any other single player mode, only the main will be movable
            }   else    {
                main.run(SKAction.moveTo(x: location.x, duration: 0.1))
                
            }

        }
    }
    
    
    
    //Now when the user moves the finget it will be the same
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches  {
            let location = touch.location(in: self)
            
            //If theres a second player mode selected by the user
            if currentGameType == .player2  {
                
                //If the location is at the top, for the top player? Oh yea the enemy haha
                if location.y > 0   {
                     enemy.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
                
                //If the location is at the bottom, for the bottom player? Oh yea it is for the bottom
                if location.y < 0   {
                     main.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
            
            //Else if its any other single player mode, only the main will be movable
            }   else    {
                main.run(SKAction.moveTo(x: location.x, duration: 0.1))
                
            }
    
        }
        
    }
    
    
    
    
    ////////////
    // MARK: Make the CPU Here
    
    override func update(_ currentTime: TimeInterval) {
        
        //switch the game type for whatever the user pressed upon
        switch currentGameType {
        case .easy:
             enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.5))
            break
            
        case .medium:
             enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
            break
            
        case .hard:
             enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
            
        case .player2:
            //Its in the touches movement
            break
        }
       
        if ball.position.y <= main.position.y - 30  {
            addScore(playerWhoWon: enemy)
            
        }   else if ball.position.y >= enemy.position.y + 30   {
            addScore(playerWhoWon: main)
        }
        
    }

}
