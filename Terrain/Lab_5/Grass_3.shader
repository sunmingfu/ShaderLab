Shader "Hidden/TerrainEngine/Details/Vertexlit" {
Properties {
	_MainTex ("Main Texture", 2D) = "white" {  }
}
SubShader {
	Tags { "RenderType"="Opaque" }
	LOD 200
	CGPROGRAM
	#pragma surface surf Lambert vertex:vert
	#pragma debug
	sampler2D _MainTex;
	struct Input {
		float2 uv_MainTex;
		fixed4 color : COLOR;//vertex color
	};
	void vert(inout appdata_full v)
	{
		v.vertex.xyz*=(1+_SinTime.w/50);
	}
	void surf (Input IN, inout SurfaceOutput o) {
		fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * IN.color;
		o.Albedo = c.rgb*2;
		o.Alpha = c.a;
	}

	ENDCG
}
Fallback "VertexLit"
}
