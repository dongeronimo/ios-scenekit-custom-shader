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



You can use the [editor on GitHub](https://github.com/dongeronimo/ios-scenekit-custom-shader/edit/master/README.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/dongeronimo/ios-scenekit-custom-shader/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
