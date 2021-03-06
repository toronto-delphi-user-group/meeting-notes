# Introduction to FireMonkey 3D

FireMonkey is Embarcadero's cross-platform UI framework. On top of the regular UI elements you would expect, it also includes some interesting hardware accelerated graphics features, and built-in 3D functionality.

We will demonstrate how to create 3D applications, combine 2D and 3D elements in the UI and how to create and use 3D objects.

---

### Answers to some questions asked at the meeting

**Q**: Can you click on a 3d shape and know where it was clicked?

**A**: Yes. Mouse events on TControl3D provides RayPos and RayDir vectors. You can use RayCastIntersect to find where that mouse operation intersects with any given TControl3D. A new sample application named ClickShape was added that demonstrate this.


**Q**: In TModel3D, can the MeshCollection property actually hold multiple meshes?

**A**: Yes. Some models include multiple meshes and each mesh can have its own material/texture. The FireMonkey model in the Assets folder includes two meshes.

---
### Resources:
* [FireMonkey Docwiki page](http://docwiki.embarcadero.com/RADStudio/en/FireMonkey)
* [FMX Linux](https://www.fmxlinux.com)
* [FMX Linux bundled with Delphi Enterprise (announced June 25th)](https://community.idera.com/developer-tools/b/blog/posts/announcing-fmx-linux-bundling-with-delphi-and-rad-studio)

* [TMesh in FireMonkey 3D](https://www.youtube.com/watch?v=NyXeUOGaMo8)

---
* [QuarkCube](https://www.youtube.com/user/QuarkCube/videos)
* [Eight 3D Demos Featuring Volume Rendering, Textures, Shaders, Materials, Polygons, And Models In Delphi FireMonkey](https://community.idera.com/developer-tools/b/blog/posts/eight-3d-demos-featuring-volume-rendering-textures-shaders-materials-polygons-and-models-in-delphi-firemonkey)

* [Planet Textures](https://www.solarsystemscope.com/textures)
* [NASA's Visibe Earth textures](https://visibleearth.nasa.gov/view.php?id=74518)
* [Free 3D models (Google to the rescue)](https://www.google.com/search?q=free+3d+models)
* [3D design software (many with free options)](https://all3dp.com/1/best-free-3d-modeling-software-3d-cad-3d-design-software)
* [3D Object Converter](http://3doc.i3dconverter.com/index.html) (supports 786 formats and is written in Delphi)
