shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

uniform vec4 shade_0 : source_color;
uniform vec4 shade_1 : source_color;
uniform vec4 shade_2 : source_color;
uniform vec4 shade_3 : source_color;

uniform vec4 recolor_shade_0 : source_color;
uniform vec4 recolor_shade_1 : source_color;
uniform vec4 recolor_shade_2 : source_color;
uniform vec4 recolor_shade_3 : source_color;

uniform float tolerance : hint_range(0.0, 0.1) = 0.01;

void fragment() {
    vec4 tex_color = texture(SCREEN_TEXTURE, SCREEN_UV);
    vec4 result_color = tex_color; // Default to original color
    
    // Use distance-based comparison instead of exact equality
    if (distance(tex_color.rgb, shade_0.rgb) < tolerance) {
        result_color = recolor_shade_0;
    }
    else if (distance(tex_color.rgb, shade_1.rgb) < tolerance) {
        result_color = recolor_shade_1;
    }
    else if (distance(tex_color.rgb, shade_2.rgb) < tolerance) {
        result_color = recolor_shade_2;
    }
    else if (distance(tex_color.rgb, shade_3.rgb) < tolerance) {
        result_color = recolor_shade_3;
    }
    
    COLOR = result_color;
}