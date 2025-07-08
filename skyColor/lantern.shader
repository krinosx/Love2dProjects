extern vec2 light_pos;
extern number light_power;
extern float light_size;
extern vec3 light_color;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    number distance =  sqrt(  pow( abs( ( light_pos[0] - screen_coords[0] ) ) ,2) + pow( abs( ( light_pos[1] - (screen_coords[1]) ) ) , 2 ) );

    //exp decay
    //number intensity =  pow (( 1.0 - ( clamp( (distance/light_size), 0, 1) )),3);

    //linear decay (with size control)
    number intensity =   1.0 - clamp((distance/light_size), 0, 1);
    
    //toon-like decay
    /*number intensity;
    if (clamp(distance/light_size,0,1) >= 1.0){
        intensity = 0.0;
    } else if (clamp(distance/light_size,0,1) > 0.9){
        intensity = 0.3;
    } else if (clamp(distance/light_size,0,1) > 0.7){
        intensity = 0.7;
    } else {
        intensity = 1.0;
    }*/

    //
    /*if (intensity < 0.05){
        discard;
    }*/
    
    vec4 texcolor = Texel(texture, texture_coords);

    return clamp(texcolor * vec4( light_power * intensity * color * vec4(light_color,1.0)),0,1) ;
}

vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}