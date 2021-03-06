// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Tut/Lighting/FirstLight/Lab_2/Deferred_Always.2" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		Blend One One
		pass{
		Tags{ "LightMode"="Always"}
		Blend One Zero
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#include "UnityCG.cginc"
		#include "Lighting.cginc"

		struct vertOut{
			float4 pos:SV_POSITION;
			float4 color:COLOR;
		};
		vertOut vert(appdata_base v)
		{
			vertOut o;
			o.pos=UnityObjectToClipPos(v.vertex);
			o.color=float4(0,1,0,1);
			return o;
		}
		float4 frag(vertOut i):COLOR
		{
			return i.color;
		}
		ENDCG
		}//end pass
		Blend One One
		CGPROGRAM
		#pragma surface surf MyDeferred 
		half4 LightingMyDeferred_PrePass (SurfaceOutput s, half4 light) {
			 half4 c;
            c.rgb = s.Albedo;
            c.a = s.Alpha;
            return c;
		}

		struct Input {
			float2 uv_MainTex;
		};
		sampler2D _MainTex;
		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo=float3(1,0,0);
		}
		ENDCG

		
	}
}
