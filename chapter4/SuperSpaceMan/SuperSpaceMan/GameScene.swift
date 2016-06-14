import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var backgroundNode : SKSpriteNode?
    var foregroundNode  : SKSpriteNode?
    var playerNode : SKSpriteNode?
    
    var impulseCount = 4
    let coreMotionManager = CMMotionManager()
    var xAxisAcceleration : CGFloat = 0.0
    
    let CollisionCategoryPlayer     : UInt32 = 0x1 << 1
    let CollisionCategoryPowerUpOrbs : UInt32 = 0x1 << 2

    required init?(coder aDecoder: NSCoder) {
    
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
    
        super.init(size: size)
        
        physicsWorld.contactDelegate = self
    
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0);
        
        backgroundColor = SKColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    
        isUserInteractionEnabled = true
        
        // adding the background
        backgroundNode = SKSpriteNode(imageNamed: "Background")
        backgroundNode!.size.width = self.frame.size.width
        backgroundNode!.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        backgroundNode!.position = CGPoint(x: size.width / 2.0, y: 0.0)
        addChild(backgroundNode!)
        
        foregroundNode = SKSpriteNode()
        addChild(foregroundNode!)
        
        // add the player
        playerNode = SKSpriteNode(imageNamed: "Player")
        
        playerNode!.physicsBody =
            SKPhysicsBody(circleOfRadius: playerNode!.size.width / 2)
        playerNode!.physicsBody!.isDynamic = false
        
        playerNode!.position = CGPoint(x: size.width / 2.0, y: 80.0)
        playerNode!.physicsBody!.linearDamping = 1.0
        playerNode!.physicsBody!.allowsRotation = false
        playerNode!.physicsBody!.categoryBitMask = CollisionCategoryPlayer
        playerNode!.physicsBody!.contactTestBitMask = CollisionCategoryPowerUpOrbs
        playerNode!.physicsBody!.collisionBitMask = 0
        
        foregroundNode!.addChild(playerNode!)
        
        var orbNodePosition = CGPoint(x: playerNode!.position.x,
            y: playerNode!.position.y + 100)
        
        for _ in 0...19 {
            
            let orbNode = SKSpriteNode(imageNamed: "PowerUp")
                
            orbNodePosition.y += 140
            orbNode.position = orbNodePosition
            orbNode.physicsBody = SKPhysicsBody(circleOfRadius: orbNode.size.width / 2)
            orbNode.physicsBody!.isDynamic = false
                
            orbNode.physicsBody!.categoryBitMask = CollisionCategoryPowerUpOrbs
            orbNode.physicsBody!.collisionBitMask = 0
            orbNode.name = "POWER_UP_ORB"
                
            foregroundNode!.addChild(orbNode)
        }
        
        orbNodePosition = CGPoint(x: playerNode!.position.x + 50, y: orbNodePosition.y)
        
        for _ in 0...19 {
            
            let orbNode = SKSpriteNode(imageNamed: "PowerUp")
            
            orbNodePosition.y += 140
            orbNode.position = orbNodePosition
            orbNode.physicsBody = SKPhysicsBody(circleOfRadius: orbNode.size.width / 2)
            orbNode.physicsBody!.isDynamic = false
            
            orbNode.physicsBody!.categoryBitMask = CollisionCategoryPowerUpOrbs
            orbNode.physicsBody!.collisionBitMask = 0
            orbNode.name = "POWER_UP_ORB"
            
            foregroundNode!.addChild(orbNode)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if !playerNode!.physicsBody!.isDynamic {
            
            playerNode!.physicsBody!.isDynamic = true
            
            coreMotionManager.accelerometerUpdateInterval = 0.3
            coreMotionManager.startAccelerometerUpdates(to: OperationQueue(), withHandler: {
                (data: CMAccelerometerData?, error: NSError?) in
                
                if let theError = error {
                    
                    print("There was an error: \(theError)")
                }
                else {
                    
                    self.xAxisAcceleration = CGFloat(data!.acceleration.x)
                }
            })
        }
        
        if impulseCount > 0 {
            
            playerNode!.physicsBody!.applyImpulse(CGVector(dx: 0.0, dy: 40.0))
            impulseCount -= 1
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
        
        let nodeB = contact.bodyB.node!
        
        if nodeB.name == "POWER_UP_ORB"  {
            
            impulseCount += 1
            nodeB.removeFromParent()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if playerNode!.position.y >= 180.0 {
            
            backgroundNode!.position =
                CGPoint(x: backgroundNode!.position.x,
                y: -((playerNode!.position.y - 180.0)/8))
            foregroundNode!.position =
                CGPoint(x: foregroundNode!.position.x,
                y: -(playerNode!.position.y - 180.0))
        }
    }
    
    override func didSimulatePhysics() {
        
        self.playerNode!.physicsBody!.velocity =
            CGVector(dx: self.xAxisAcceleration * 380.0,
                dy: self.playerNode!.physicsBody!.velocity.dy)
        
        if playerNode!.position.x < -(playerNode!.size.width / 2) {
            
            playerNode!.position =
                CGPoint(x: size.width - playerNode!.size.width / 2,
                    y: playerNode!.position.y);
        }
        else if self.playerNode!.position.x > self.size.width {
            
            playerNode!.position = CGPoint(x: playerNode!.size.width / 2,
                y: playerNode!.position.y);
        }
    }
    
    deinit {
        
        self.coreMotionManager.stopAccelerometerUpdates()
    }
}
