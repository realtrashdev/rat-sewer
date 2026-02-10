shader_type canvas_item;

uniform float fill_amount : hint_range(0.0, 1.0);
uniform float interval : hint_range(0.0, 0.5) = 0.05;

uniform vec4 filled_color : source_color;
uniform vec4 transparent_color : source_color;

void fragment() {
	vec2 uv = UV - mod(UV, interval);
	
	if (uv.x + uv.y < fill_amount * 2.0) {
		COLOR = transparent_color;
	}
	else {
		COLOR = filled_color;
	}
}
