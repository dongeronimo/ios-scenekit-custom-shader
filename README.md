### Scenekit with custom Metal shader

This project shows how to use a custom Metal shader in Scenekit. The key class is SCNProgram. In it you can set which function to use in vertex shader and in fragment shader, finding it by name. The API tries to locate your functions in the Metal shaders inside your App.

## Creating the Shader:

The shader must conform to Scenekit's input structures. 
```
struct MyNodeBuffer {
    float4x4 modelTransform;
    float4x4 modelViewTransform;
    float4x4 normalTransform;
    float4x4 modelViewProjectionTransform;
};

typedef struct {
    float3 position [[ attribute(SCNVertexSemanticPosition) ]];
} MyVertexInput;

struct SimpleVertex
{
    float4 position [[position]];
};

vertex SimpleVertex myVertex(MyVertexInput in [[ stage_in ]],
                             constant SCNSceneBuffer& scn_frame [[buffer(0)]],
                             constant MyNodeBuffer& scn_node [[buffer(1)]])
{
    //...
}
```
MyNodeBuffers seems to be the Uniforms of GLSL, while MyVertexInput are the attributes varying with each vertex.

## Passing the shader to the object
As mentioned above, SCNProgram has two properties that can have the names of the functions attributed to.

## Results:
The yellow box is using my simple shader.
![alt text](https://github.com/dongeronimo/ios-scenekit-custom-shader/raw/master/IMG_2645.jpg "Final Result")

