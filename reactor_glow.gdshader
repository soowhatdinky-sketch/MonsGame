shader_type spatial;
render_mode unshaded, blend_add;
uniform vec4 color : source_color = vec4(0.1,0.65,1.0,1.0);
void fragment() {
    float pulse = 0.55 + 0.45 * sin(TIME * 3.0);
    ALBEDO = color.rgb;
    EMISSION = color.rgb * (4.0 + pulse * 5.0);
    ALPHA = 0.65;
}
