// Example from Godot Shaders.com
// https://godotshaders.com/shader/vignette-blur
shader_type canvas_item;

uniform float amount = 0.7; // Controls the strength of the vignette
uniform vec4 color : source_color = vec4(0.0, 0.0, 0.0, 1.0); // The color of the vignette

void fragment() {
	vec2 uv = UV;
	vec2 center = vec2(0.5);
	float dist = distance(uv, center);
	float vignette = smoothstep(amount, 1.0, dist);
	vec4 screen_color = texture(hint_screen_texture, uv);
	COLOR = mix(screen_color, color, vignette);
}
