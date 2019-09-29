//
//  GameViewController.swift
//  hello-world-scenekit
//
//  Created by LUCIANO G LISBOA on 27/09/19.
//  Copyright © 2019 LUCIANO G LISBOA. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        showMyFirstScene()
    }
    private func showMyFirstScene(){
        //Pega a cena - Os SCNScenes são objetos que contêm as cenas do SceneKit e tem uma estrutura
        //de nós.
        guard let myScene = SCNScene(named: "art.scnassets/first_scene.scn")
            else {fatalError("Unable to load scene")}
        //Pega o sceneView - O SCNView é o responsável por renderizar as cenas e controlá
        let scnView = self.view as! SCNView
        scnView.scene = myScene
        scnView.backgroundColor = UIColor.black
        scnView.autoenablesDefaultLighting = true
        // Pra ativar as funçoes pré definidas de câmera
        scnView.allowsCameraControl = true
    }
    @IBAction func sceneTapped(_ sender: UITapGestureRecognizer) {
        //Pega onde na tela o usuário fez o tap
        let scnView = self.view as! SCNView
        let p = sender.location(in: scnView)
        //Pega em quem toquei
        let hitResults = scnView.hitTest(p, options: [:])
        if (hitResults.count > 0 ){
            let result = hitResults[0]
            //result.node.name
            let material = result.node.geometry!.firstMaterial!//Pega o material
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            material.diffuse.contents = UIColor(displayP3Red: CGFloat(Double.random),
                                                green: CGFloat(Double.random),
                                                blue: CGFloat(Double.random),
                                                alpha:  1.0)
            SCNTransaction.commit()
        }
    }
    override var shouldAutorotate: Bool {
        return true
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

// MARK: Random no double
public extension Double {
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static var random: Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
}
