shader_type canvas_item;
uniform sampler2D tex: filter_nearest;
uniform float width;
uniform float height;

void make_kernel(inout vec4 n[9], sampler2D _tex, vec2 coord){
	float w = 1.0 / 800.0;
	float h = 1.0 / 600.0;
	
	n[0] = texture(_tex, coord + vec2( -w, -h));
	n[1] = texture(_tex, coord + vec2(0.0, -h));
	n[2] = texture(_tex, coord + vec2(  w, -h));
	n[3] = texture(_tex, coord + vec2( -w, 0.0));
	n[4] = texture(_tex, coord);
	n[5] = texture(_tex, coord + vec2(  w, 0.0));
	n[6] = texture(_tex, coord + vec2( -w, h));
	n[7] = texture(_tex, coord + vec2(0.0, h));
	n[8] = texture(_tex, coord + vec2(  w, h));
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	vec4 n[9];
	make_kernel(n,tex,UV);	
	
	vec4 sh = n[2] + (2.0*n[5]) + n[8] - (n[0] 	+(2.0*n[3]) + n[6])	;	
	vec4 sv = n[0] + (2.0*n[1]) + n[2] - (n[6] 	+(2.0*n[7]) + n[8])	;
	
	float res  = sqrt(dot(sh,sh) + dot(sv,sv));
	vec4 pre = res*  texture(tex,UV);
	if (pre.x > 0.60 && pre.y > 0.60 && pre.z > 0.60){
		pre = vec4(0.0,0.0,0.0,1.0);
	}
	COLOR = pre;
	
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
