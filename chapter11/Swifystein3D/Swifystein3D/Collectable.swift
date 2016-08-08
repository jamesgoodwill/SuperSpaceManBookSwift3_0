//
//  Collectable.swift
//  Swifystein3D
//
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation
import SceneKit

class Collectable {
    
    class func pyramidNode() -> SCNNode {
        
        // 1 Creating the SCNGeometry type
        let pyramid = SCNPyramid(width: 1.0, height: 2.0, length: 1.0)
        
        // 2 Create the node using the geometry type
        let pyramidNode = SCNNode(geometry: pyramid)
        pyramidNode.name = "pyramid"
        
        //3 Setting the node position
        let position = SCNVector3Make(30, 0, -40)
        pyramidNode.position = position
        
        // 4 Giving the node some color.
        pyramidNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        pyramidNode.geometry?.firstMaterial?.shininess = 1.0
        
        return pyramidNode
    }
    
    class func sphereNode() -> SCNNode {
        
        // 1 Creating the SCNGeometry type
        let sphere = SCNSphere(radius: 2.0)
        
        
        // 2 Create the node using the geometry type
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.name = "sphere"
        
        //3 Setting the node position
        let position  = SCNVector3Make(35, 2, -60)
        sphereNode.position = position
        
        // 4 Giving the node some color.
        sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        sphereNode.geometry?.firstMaterial?.shininess = 1.0
        
        return sphereNode
    }
    
    
    class func boxNode() -> SCNNode {
        
        // 1 Creating the SCNGeometry type
        let box = SCNBox(width: 3, height: 3, length: 3, chamferRadius: 0)
        
        // 2 Create the node using the geometry type
        let boxNode = SCNNode(geometry: box)
        boxNode.name = "box"
        
        //3 Setting the node position
        let position  = SCNVector3Make(20, 1.5, -20)
        boxNode.position = position
        
        // 4 Giving the node some color.
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        boxNode.geometry?.firstMaterial?.shininess = 1.0
        
        return boxNode
        
    }

    class func tubeNode() -> SCNNode {
        
        // 1 Creating the SCNGeometry type
        let tube = SCNTube(innerRadius: 1, outerRadius: 1.5, height: 2.0)
        
        // 2 Create the node using the geometry type
        let tubeNode = SCNNode(geometry: tube)
        tubeNode.name = "tube"
        
        //3 Setting the node position
        let position  = SCNVector3Make(-10, 0.75, -75)
        tubeNode.position = position
        
        // 4 Giving the node some color.
        tubeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        tubeNode.geometry?.firstMaterial?.shininess = 1.0
        
        return tubeNode
    }

    class func cylinderNode() -> SCNNode {
        
        // 1 Creating the SCNGeometry type
        let cylinder = SCNCylinder(radius: 3, height: 8)
        
        // 2 Create the node using the geometry type
        let cylinderNode = SCNNode(geometry: cylinder)
        cylinderNode.name = "cylinder"
        
        //3 Setting the node position
        let position = SCNVector3Make(0, 4, -25)
        cylinderNode.position = position
        
        // 4 Giving the node some color.
        cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        cylinderNode.geometry?.firstMaterial?.shininess = 1.0
        
        return cylinderNode
    }

    class func torusNode() -> SCNNode {
        
        // 1 Creating the SCNGeometry type
        let torus = SCNTorus(ringRadius: 7, pipeRadius: 2)
        
        
        // 2 Create the node using the geometry type
        let torusNode = SCNNode(geometry: torus)
        
        //3 Setting the node position
        let position =  SCNVector3Make(75, 1, -80)
        torusNode.position = position

        // 4 Giving the node some color.
        torusNode.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
        torusNode.geometry?.firstMaterial?.shininess = 1.0
        
        return torusNode
    }
}

