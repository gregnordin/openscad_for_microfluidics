# Purpose

Explore Triply Periodic Minimal Surface (TPMS) structures as possible 3D printed high surface area components.

# Approach

- Create unit cell with discrete blocks.
    - Integer number of blocks in each direction of the 3D unit cell.
    - Create a block if the center of the block is inside the TPMS.
- Save unit cell to STL file.
- Use unit cell by importing STL into a device design file.
- Scale unit cell so that each block corresponds to a pixel &times; pixel &times; layer thickness voxel.
- Place as many translated and scaled unit cells as needed to create desired TPMS region.

# Open questions

- Use TPMS unit cell as-is, or use it with a difference operation like all other negative space components.
    - If the former, substitute a large rectanguler box for the TPMS region in a negative space design, then fill the box with TPMS unit cells.
    - If the latter, need to create negative space TPMS unit cell.