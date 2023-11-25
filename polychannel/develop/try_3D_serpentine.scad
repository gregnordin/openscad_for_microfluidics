use <../polychannel.scad>
use <../serpentine.scad>
use <../serpentinecircularends.scad>


default_params = [

];

nx = 3;
l = 15;
gap = 1;
chan_width = 1;
chan_height = 0.8;

echo();
for (i=[1:4]) {
    echo(i, i-1, i%2);
}
echo();
for (i=[0:7]) {
    echo(i, floor(i/2), floor((i+1)/2)%2);
}

serpentine_channel_circ(n=nx, l=l, gap=gap, cross_section=[chan_width, chan_height], clr="cornflowerblue");
end_1 = [(gap + chan_width) * floor(nx/2), l * floor((nx+1)/2)%2, 0];
echo([floor(nx/2), floor((nx+1)/2)%2, 0]);
echo(end_1);

translate([0, 0, -2]) 
    serpentine_channel(n=nx, l=l, gap=gap, size=[chan_width, chan_width, chan_height], clr="Salmon");
