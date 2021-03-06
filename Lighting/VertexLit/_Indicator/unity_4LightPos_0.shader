// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Tut/Lighting/VertexLit/Indicator/unity_4LightPos_0" {
	Properties {
		_Color ("Base Color", Color) =(1,1,1,1)
	}
	SubShader {
		pass{
		Tags{ "LightMode"="Vertex"}
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#include "UnityCG.cginc"
		#include "Lighting.cginc"

		uniform float4 _Color;

		struct vertOut{
			float4 pos:SV_POSITION;
			float4 color:COLOR;
		};
		vertOut vert(appdata_base v)
		{
			vertOut o;
			o.pos=UnityObjectToClipPos(v.vertex);
			float3 lightColor = UNITY_LIGHTMODEL_AMBIENT.xyz;
			float4 lightPos =float4(unity_4LightPosX0[0],unity_4LightPosY0[0],unity_4LightPosZ0[0],1.0);
			float3 toLight=(lightPos-o.pos).xyz;
			float lengthSq = dot(toLight, toLight);
			float atten = 1.0 / (1.0 + lengthSq * unity_4LightAtten0[0]);
			float3 worldN =( mul(float4(v.normal,1.0),unity_WorldToObject)).xyz;
			float diff = max (0, dot (worldN, normalize(toLight)));
			lightColor += unity_LightColor[0].rgb* (diff * atten);
		
			o.color=float4(lightColor,1)*_Color;
			return o;
		}
		float4 frag(vertOut i):COLOR
		{
			return i.color;
		}
		ENDCG
		}//end pass
	}
}
