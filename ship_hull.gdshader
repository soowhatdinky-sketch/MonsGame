shader_type spatial;
render_mode cull_back, diffuse_burley, specular_schlick_ggx;

uniform vec4 hull_color : source_color = vec4(0.035,0.06,0.09,1.0);
uniform vec4 emissive_color : source_color = vec4(0.0,0.55,1.0,1.0);
uniform float emissive_strength : hint_range(0.0,8.0) = 1.8;
uniform float panel_scale = 18.0;
uniform float edge_glow = 0.7;

void fragment() {
    vec3 p = VERTEX;
    vec2 grid = abs(fract(p.xz / panel_scale) - 0.5);
    float seam = smoothstep(0.46,0.50,max(grid.x,grid.y));
    float noise_line = step(0.985, fract(sin(dot(p.xz, vec2(12.9898,78.233))) * 43758.5453));
    ALBEDO = mix(hull_color.rgb * 0.72, hull_color.rgb * 1.25, seam);
    ROUGHNESS = 0.3;
    METALLIC = 0.9;
    EMISSION = emissive_color.rgb * emissive_strength * max(seam * edge_glow, noise_line);
}
