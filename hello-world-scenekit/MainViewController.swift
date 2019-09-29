import UIKit
import QuartzCore
import SceneKit

class MainViewController: UIViewController {
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var objectName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene();
    }
    private func setupScene(){
        //Pega a cena - Os SCNScenes são objetos que contêm as cenas do SceneKit e tem uma estrutura
        //de nós.
        guard let myScene = SCNScene(named: "art.scnassets/first_scene.scn")
            else {fatalError("Unable to load scene")}
        sceneView.scene = myScene
        sceneView.backgroundColor = UIColor.black
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        testShader(myScene: myScene)
    }
    private func testShader(myScene: SCNScene){
        //Search for the shaderBox
        let shaderBox: SCNNode = myScene.rootNode.childNode(withName: "shader box", recursively: true)!
        let program: SCNProgram = SCNProgram()//Instancia o objeto de programa
        program.fragmentFunctionName = "myFragment"
        program.vertexFunctionName = "myVertex"
        
        //.... http://dontpad.com/geronimol
        shaderBox.geometry!.firstMaterial?.program = program//Passa pro shaderBox
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        let p = sender.location(in: sceneView)
        let hitResults = sceneView.hitTest(p, options: [:])
        if (hitResults.count > 0 ){
            let result = hitResults[0]
            let node = result.node
            objectName.text = node.name
            if(node.name == "shader box"){
//                //É no shaderModifiers que eu enfio o meu shader custom.
//                //Ao tocar no botão vou jogar fora todo o shading e retornar um bagulho pink.
//                node.geometry!.shaderModifiers = [.fragment:
//                    """
//                    _output.color.rgb = float3(1.0, 0.0, 1.0);
//                    """]
            }
            else{
                changeDiffuseToRandomColor(node: node)
            }
        }
    }
    ///Sets the diffuse channel to some random color, changing from the old color to the
    ///new color in a half second.
    private func changeDiffuseToRandomColor(node: SCNNode){
        let material = node.geometry!.firstMaterial!//Pega o material
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        material.diffuse.contents = UIColor(displayP3Red: CGFloat(Double.random),
                                            green: CGFloat(Double.random),
                                            blue: CGFloat(Double.random),
                                            alpha:  1.0)
        SCNTransaction.commit()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
