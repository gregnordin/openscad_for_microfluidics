# Purpose

This document constitutes my rough working notes as I develop openscad code to support `polychannel` development, along with associated capabilities.

# Tuesday, 9/27/22

- Try out `rotate_extrude()`.
- Start creating `polylinehull` module.


# Wednesday, 9/28/22

- Create `polychannel` module.
- Create `serpentine` module.
- Create `serpentinecircularends` module.


# Thursday, 9/29/22

How create a polychannel that has one or more channel sections with a circular arc? Information needed for each arc (limit to only 90&deg; and 180&deg; arcs? Maybe also 45&deg; arcs, possibly 30/60&deg; arcs?):

- Cross sectional shape.
- Arc radius.
- Arc angular extent (usually 90&deg; or 180&deg;).
- Position for starting face of arc and vector for starting direction of arc (which is the surface normal of the starting face where the arc connects to the previous channel section).
- Whether the arc is in the xy, xz, or yz plane (i.e., axis of rotation for 90&deg;.

Approach:

- Convert relative positions to absolute positions (as needed).
- Parse shapes array and break into polychannel-arc-polychannel-arc sections.
- Sequentially handle polychannel sections with hull() and arc sections with rotate_extrude().

```
for shape in shapes:
    if shape == arc:
        create arc
    else:
        
```

```
shapes = {
    cube1
    cube2
    cube3 - position at face of arc
    arc1
    cube4 - position at face of arc
    cube5
}
relative_positions = {
    pos1
    pos2
    pos3
    0 (arc1 starts at position of last shape)
    0 (cube4 starts at position of arc endface)
    pos5
}
```

Alternatively, we could build a data structure where the shape and position information is all together:

```
polychannel_params = {
    {shape params-type and position}
}
```

Possibilities for circular arcs:

- [sweep()](https://github.com/openscad/list-comprehension-demos/blob/master/sweep.scad).
- [Snippet: Circular sector and arcs with OpenScad](https://www.xarg.org/snippet/circular-sector-and-arcs-with-openscad/) - looks simple, try it.
- [Circular sector and arc](https://openhome.cc/eGossip/OpenSCAD/SectorArc.html) - more complicated.


# 9/30/22 - 10/12/22

Try creating an arc with intersection of cubes rotated and moved along an arc. Led to idea to do something like this with flat plate-like shapes and hull() between them, which is compatible with the polychannel approach and would just need the shapes and positions of the shapes.

- `try_embed_function_in_array.scad`
    - &#9989; Try embedding the output of a function in a list&rarr; it works.
- `try_func_for_arc.scad`
    - &#9989; Create functions for absolute positions and relative positions along a 90&deg; arc.
    - &#9989; Make arc go from angle a to angle b (CCW).
    - &#9989; Make angle a and angle b handle CW as well as CCW directions.
    - &#9989; Put into a list with other positions.
- `try_shape3D_with_rotation`
    - &#9989; Add `rotate()` to shape3D.
        - &#9989; Shape data structure:
            - [`<shape>, <size>, <relative position>, <rotation>`]
                - `<shape>` = "cube" or "sphere/sphr"
                - `<size>` = [3, 2, 1]
                - `<position>` = [10, 12, 0] can be absolute or relative, always specify as relative and then use function to turn it into absolute?
                - `<rotation>` &rarr; angle (a=90), axis of rotation (v=[0, 0, 1]) = [90, [0, 0, 1]]
            - Example
                - `["sphr", [0.01, 4, 4], [0, 0, 0], [45, [0, 0, 1]]]`
        - &#9989; Can `relative position` be easily turned into `absolute position` with this data structure? Write functions to do it. **Use simple single purpose functions that work together.** Openscad functions are too limiting to do it all in one function.
- &#9989; Create new polychannel module to use the above shape3D and data structure. **Do a lot of debugging.**
- &#9989; Expand example test data.
- `try_abs_to_rel_pos_conversion.scad`
    - &#9989; Create function to take an data structure with absolute positions and turn it into one with relative positions. I need this to make it simpler to create an arc data structure with relative positions.
- `try_circular_arc_xy_for_polychannel.scad`
    - **Positive angle rotation from x to y around +z axis.**
    - &#9989; Create function to make new data structure entries for an xy arc that includes positions and shape rotation angles. Use absolute positions to make it tractable given Openscad's limitations for functions.
    - &#9989; Put into a list with other positions/shapes and input into polychannel.
    - &#9989; Create relative position arc function.
    - &#9989; Use absolute to relative position converstion in list with other positions/shapes and input into polychannel.
    - &#9989; Try more extensive set of arc angles.
- `try_circular_arc_xz_for_polychannel.scad`
    - **Positive angle rotation from x to z around -y axis.**
    - &#9989; Create functions for xz arcs.
- `try_circular_arc_yz_for_polychannel.scad`
    - **Positive angle rotation from y to z around +x axis.**
    - &#9989; Create functions for yz arcs.
- &#9989; Move xy, xz, yz arc functions to `polychannels.scad`
- &#9989; Change polychannel default to `relative_positions=true`
- &#9989; Add examples that illustrate use of polychannel and arc features.
    - &#9989; Multiple sequential 90&deg; bends - `polychannel_examples_90deg_bends.scad`.
    - &#9989; Individual arcs that show starting position and sense of angular rotation.
    - &#9989; Shape changing.
    - &#9989; Round channels and turns.
- &#10060; Add a starting position to arc creation function so can use absolute positions?
- &#9989; Move examples into an examples directory.
- &#9989; Improve examples and text in project wiki.
- &#9989; Fix README.md and notes-polychannel.md.
- &#9989; Utility functions
    - &#9989; Function to reverse the order of a list of shape/positions.
    - &#9989; Function to sum up all of the relative positions in a params list to give the final position.
    - &#9989; Function to get the final position from a list of shape/positions.
    - &#9989; Function to modify arc to be an ascending arc. Works for any arbitrary list of shape/positions.
    - Dallin's function to convert from shorter to longer shape/position format.
    - &#9989; Introduce `rot_x (ang)`, `rot_y(ang)`, `rot_z(ang)` `no_rot()` functions.
        - &#9989; Introduce a `no_rot()` function to use with the longer shape/position format to indicate the shape has no rotation.
- &#10060; Try to add an initial position to `arc_xz_rel_position` but failed--would have to completely re-do approach to how the function works.
- &#9989; ~~Modify `abs_to_rel_positions2()` to keep the first position and make all of the others relative.~~
- &#9989; Oops, I need to add r0 after doing a completely relative set of positions. **New function that in essence does a translate on a set of shape/pos from an arc function.** `set_first_position()` - success!
- &#9989; Refactor `arcs_set_first_position.scad`.
- &#9989; Try creating functions to do an xy arc specifying starting angle and delta angle, `try_arc_starting_and_delta_angles.scad`.
- &#9989; Create shorthand functions for cube and sphere shapes to reduce verbosity, `shorter_shape_pos_approach.scad`.
- &#9989; Re-do all arc functions to use starting angle and delta angle.
- &#9989; Create map of combinations of starting angles and delta angles for all arc functions.
- &#9989; Re-do examples to make use of new arc and helper functions.
- &#9989; Update README.md to use new methods.
- &#9989; Update project wiki page on polychannel.
- &#9989; Figure out how to use unicode characters.
- Update `serpentine.scad` and `serpentine_circularends.scad` to use latest polychannel methods.

# 10/13/22

## Look at how to implement cubic Bezier curve between two 3D points

Search for information about splines or Bezier curves to connect points in 3D, found exactly what I need at [Interpolating splines with 3d points](https://math.stackexchange.com/questions/2316499/interpolating-splines-with-3d-points).

Implement in python in `try_3D_Bezier.ipynb`. Playing with the magnitude of normal vectors is crucial in generating a nice curve.

Next

- Plot tangent with matplotlib ax.quiver()

# 10/14/22

- &#9989; Implement cubic Bezier curve using `polychannel()` between two 3D points in `try_3D_Bezier.scad`.
    - Use Nominal Animal's answer at [Interpolating splines with 3d points](https://math.stackexchange.com/questions/2316499/interpolating-splines-with-3d-points), Eq. 5.
    - Use `sympy` to take derivative of Eq. 5 to get tangent at point calculated with value `t`.
- &#9989; How rotate shape in openscad so it is normal to an arbitrary vector?
    - ~~[Wanted: rotate function on vectors](https://forum.openscad.org/Wanted-rotate-function-on-vectors-td11218.html)~~
    - Use libor's answer at [Rotating two vectors to point in the same direction](https://math.stackexchange.com/questions/114050/rotating-two-vectors-to-point-in-the-same-direction).
- I get [nan, nan, nan] when I do the cross product between parallel vectors. This doesn't seem to be causing a problem when fed into `rotate()` as the vector around which the rotation is to occur if the rotation angle is 0.
    - Write a function that replaces [nan, nan, nan] with [0, 0, 1]?
        - See [is_nan()](https://forum.openscad.org/is-nan-td28336.html) for a discussion about why the following user defined function works: `function is_nan(x) = x!=x;`

## More Bezier curve information

[Bezier curve visualization](expansion_chan_extension) - interactive, note effect of length of tangent vector.  
[Desmos interactive Bezier calculator](https://www.desmos.com/calculator/ebdtbxgbq0).  
[Parallel curves of cubic Béziers](https://raphlinus.github.io/curves/2022/09/09/parallel-beziers.html).  
[3D Helix Drawing using Bézier Curves](https://2015fallhw.github.io/arcidau/HelixDrawing.html).  
[Bezier Curves, pdf slides](https://katie.cs.mtech.edu/classes/csci441/Slides/26-BezierCurves.pdf).  
[Approximate a circle with cubic Bézier curves](https://spencermortensen.com/articles/bezier-circle/).    

# 10/21/22

- Use python and pyscript or panel to plot cubic Bezier curve with starting and end points and starting and end tangent vectors as inputs. Plot the curve and plot the starting and end tangent vectors. Checkbox to select automatic normalization. Checkbox to select 90&deg; circular arc (what about 45&deg;, 135&deg;, 180&deg;?). Mouse to grab and position starting and end points? Unit vector for tangent vector along with a multiplier? This visualization will be useful to teach people how to set up a cubic Bezier curve with the shape they want.
- Do the same except do multiple curves in series.

New ideas:

- Create functions for each type of common channel (size and shape) used in a design, then call function to return shape/size/pos list to insert into a polychannel param list.
    - The bottom line is to embed a lot of the microfluidic design choices into these functions defined for this specific microfluidic design.
    - Set in stone in the function:
        - Shape
        - Size (put it in the x-y plane with normal vector and rotate it to desired tangent direction? Play with different x-y dimensions and tangent directions to make sure it always does what I expect.)
        - N plates
    - Input into function:
        - Straight channel:
            - Length
            - Tangent vector
            - N plates = 1
        - Circular arc bend:
            - Start position
            - End position
            - Starting and ending tangent vectors?
        - Cubic Bezier curve:
            - Start position
            - End position
            - Starting and ending tangent vectors
- Use cubic Bezier curve for straight channels.
    - Use a function that returns Bezier curve with 2 thin plates at the ends.
    - Inputs:
        - Initial relative position.
        - Length.
        - Size: width and height for x-y channels and width and width for z channels.
        - Tangent vector for straight channel (can be anything, not restricted to just x, y, or z).
- Functions for sharp 90&deg; bends. Just returns the appropriately rotated and stretched thin plate.
- Do the same but for circular arc bends (bend radius a little bigger than the width, like for example, width + 4*px)?
- Cubic Bezier curve to approximate 90&deg; circular arcs. Other angular sweeps too?

# 10/22/22

- `try_Bezier_straight_chan.scad` &rarr; success. 
- Next: 
    - Make `_xy`, `_xz`, `_yz` functions all use `_straight_channel()` and add plate_norm as input argument.
    - create just xy and z channels.


---

Other possible modules for channel paths that use the new data format developed above and the hull-based polychannel approach:

- Method to create linked cubic Bezier curve, see my Notability notes for 11/14/22.
- Generalize `shape3D()` to accept `polyhedron` as well as `cube` and `sphere/sphr`.
- &#9989; S-curve &rarr; use cubic Bezier curve.
- [Bézier curve](https://en.wikipedia.org/wiki/B%C3%A9zier_curve) and linked Bezier curves.
    - [Python Bezier package](https://bezier.readthedocs.io/en/stable/python/reference/bezier.curve.html).
- [B-splines](https://en.wikipedia.org/wiki/B-spline)?
- Spirals.
- 3D serpentine channels with 90&deg; corners and with 180&deg; circular arc bends. Use `uniformly_increase_rel_pos_in_z()` or just use cubic Bezier curves.
    - Stacked in z with channels in xy.
    - Stacked in x or y with vertical channels.

