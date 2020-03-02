# MatlabRenderToolbox
 
<img align="center"  src="/results/overview.png" width="1200">

This is a simple render toolbox in Matlab. 
1. ```./examples/example_singlePair.m``` shows how to 
   * *render a shape* (with adjustable rotations to align the shape first)
   * *visualize some edges*
   * *color the mesh with per-vertex color assginment*
   * *visualize a per-vertex scalar fuction* (e.g., some descriptor)
   * *visualize a vector field*
2. ```./examples/example_shapeWithLandmarks.m``` shows how to add some landmarks as spheres to the given shape and render them altogether
3. ```./examples/example_shapePair.m``` shows to how to visualize a given point-wise map on a shape pair via color transfer. Two meshes are ploted in the same axis, and some corresponding landmarks or connecting lines can be visualized as well optionally. 

## Comments
- This toolbox gives so-so renderings (as shown above), but it is very fast and easy to play with (I feel so :)
- In this toolbox, I used some functions from [gptoolbox](https://github.com/alecjacobson/gptoolbox) by [Alec Jacobson](https://github.com/alecjacobson). This blog [Paper-worthy rendering in MATLAB](https://www.alecjacobson.com/weblog/?p=4732) by Alec might also be helpful.
- If you are looking for paper-level rendering toolbox, I found [this one](https://github.com/HTDerekLiu/BlenderToolbox), a blender toolbox with python scripts provided by [Hsueh-Ti Derek Liu](https://github.com/HTDerekLiu) extremely helpful. 
- update (2019-11-03): just find this [Matlab render toolbox](https://github.com/hexygen/SPRender) by [Yanir Kleiman](https://github.com/hexygen/) that might be helpful as well
- Please feel free to contact me (jing.ren@kaust.edu.sa) if you have any questions or suggestions to this toolbox ;)

