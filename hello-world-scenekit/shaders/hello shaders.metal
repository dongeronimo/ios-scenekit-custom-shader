#include <metal_stdlib>
using namespace metal;
#include <SceneKit/scn_metal>

struct MyNodeBuffer {
    float4x4 modelTransform;
    float4x4 modelViewTransform;
    float4x4 normalTransform;
    float4x4 modelViewProjectionTransform;
};

typedef struct {
    float3 position [[ attribute(SCNVertexSemanticPosition) ]];
    float3 normal   [[ attribute(SCNVertexSemanticNormal) ]];
    float2 texcoord0 [[ attribute(SCNVertexSemanticTexcoord0) ]];
    float2 texcoord1 [[ attribute(SCNVertexSemanticTexcoord1) ]];
    float2 texcoord2 [[ attribute(SCNVertexSemanticTexcoord2) ]];
} MyVertexInput;

struct SimpleVertex
{
    float4 position [[position]];
    //Essas vars, por não terem  o [[]] são interpoladas, náo são atributos
    float r;
    float g;
    float b;
};

vertex SimpleVertex myVertex(MyVertexInput in [[ stage_in ]],
                             constant SCNSceneBuffer& scn_frame [[buffer(0)]],
                             constant MyNodeBuffer& scn_node [[buffer(1)]])
{
    SimpleVertex vert;
    vert.position = scn_node.modelViewProjectionTransform * float4(in.position, 1.0);
    vert.r = in.position.x;
    vert.g = in.position.y;
    vert.b = in.position.b;
    return vert;
}

fragment float4 myFragment(SimpleVertex in [[stage_in]])
{
    float4 color;

    color = float4(in.r, in.g, in.b, 1.0);
    
    return color;
}
