extern vec4 sky_color;
vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 texcolor = Texel(texture, texture_coords);
    return clamp(texcolor * color * sky_color,0,1);
}

vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}
