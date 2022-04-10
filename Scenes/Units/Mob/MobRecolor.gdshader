shader_type canvas_item;
render_mode unshaded;

uniform vec4 color : hint_color;
const vec3 LUTin[4] = { vec3(0.702,0.,0.631),vec3(0.8,0.078,0.706),vec3(0.89,0.141,0.89),vec3(0.961,0.286,0.871) };

void fragment(){
	
	COLOR = texture(TEXTURE,UV);
	for (int i = 0; i < 4; i++) {
		if(COLOR.rgb==LUTin[i])
			COLOR.rgb = color.rgb;
	}
}