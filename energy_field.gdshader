shader_type spatial;
render_mode unshaded, blend_add, cull_disabled;
uniform vec4 color : source_color = vec4(0.05,0.5,1.0,1.0);
uniform float speed = 1.5;
uniform float density = 22.0;

void fragment() {
    float bands = sin((UV.x + UV.y) * density + TIME * speed);
    float a = smoothstep(0.25,0.9,abs(bands)) * 0.35;
    ALBEDO = color.rgb;
    EMISSION = color.rgb * 3.0;
    ALPHA = a;
}
