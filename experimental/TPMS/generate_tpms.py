import math
import numpy as np
import pyvista as pv

# Define the function
def function(shape, x, y, z, a):
    if shape == "Diamond":
        x_offset = 0
        y_offset = 0
        z_offset = 0
        return math.sin(a * (x+x_offset)) * math.sin(a * (y+y_offset)) * math.sin(a * (z+z_offset)) + math.sin(a * (x+x_offset)) * math.cos(a * (y+y_offset)) * math.cos(a * (z+z_offset)) + math.cos(a * (x+x_offset)) * math.sin(a * (y+y_offset)) * math.cos(a * (z+z_offset)) + math.cos(a * (x+x_offset)) * math.cos(a * (y+y_offset)) * math.sin(a * (z+z_offset)) > 0
    if shape == "Gyroid":
        x_offset = 0
        y_offset = 0
        z_offset = 0
        return math.cos(a * (x+x_offset)) * math.sin(a * (y+y_offset)) + math.cos(a * (y+y_offset)) * math.sin(a * (z+z_offset)) + math.cos(a * (z+z_offset)) * math.sin(a * (x+x_offset)) > 0
    if shape == "Schwarz P":
        x_offset = 0
        y_offset = 0
        z_offset = 0
        return math.cos(a * (x+x_offset)) + math.cos(a * (y+y_offset)) + math.cos(a * (z+z_offset)) < 0
    if shape == "Fischer-Koch S":
        x_offset = 0
        y_offset = 0
        z_offset = 0
        return math.cos(a * 2*(x+x_offset)) * math.sin(a * (y+y_offset)) * math.cos(a * (x+x_offset)) + math.cos(a * 2*(y+y_offset)) * math.sin(a * (z+z_offset)) * math.cos(a * (x+x_offset)) + math.cos(a * 2*(z+z_offset)) * math.sin(a * (x+x_offset)) * math.cos(a * (y+y_offset)) > 0

# Define the bounding box
bbox_min = (0, 0, 0)
bbox_max = (1.0, 1.0, 1.0)

for resolution in [11,21,31,41,51]:
    for shape in ["Diamond", "Schwarz P", "Fischer-Koch S", "Gyroid"]:
    # for shape in ["Diamond"]:
        print(f"{shape} {resolution}")

        # Compute the step size
        step = (bbox_max[0] - bbox_min[0]) / (resolution-1)

        # Iterate over the vertices and faces
        points = []
        for i in range(resolution):
            x = bbox_min[0] + i * step
            for j in range(resolution):
                y = bbox_min[1] + j * step
                for k in range(resolution):
                    z = bbox_min[2] + k * step
                    value = function(shape, x, y, z, math.radians(360))
                    if value:
                        points.append([x,y,z])
        points = np.array(points)

        cloud = pv.PolyData(points)
        # volume = cloud.delaunay_3d(alpha=step*math.sqrt(2), progress_bar=True)
        volume = cloud.delaunay_3d(alpha=step, progress_bar=True)
        shell = volume.extract_geometry()
        shell.save(f"{shape}_{resolution}_r3.stl")
        # shell.plot()
        
