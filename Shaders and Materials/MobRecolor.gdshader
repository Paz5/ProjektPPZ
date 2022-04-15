shader_type canvas_item;
render_mode unshaded;

uniform sampler2D baseLUT;
uniform sampler2D targetLUT;

void fragment(){
	COLOR = texture(TEXTURE,UV);
	for(float i = 0.0; i<4.0;i++){
		vec2 uv = vec2(0.0,i/4.0);
		if(COLOR == texture(baseLUT, uv)){
			COLOR = texture(targetLUT,uv);
		}
	}
}