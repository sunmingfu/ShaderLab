// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Tut/Shadow/PlanarShadow_2" {
	SubShader {
	pass {      
		Tags { "LightMode" = "ForwardBase" }
		Material{Diffuse(1,1,1,1)}
		Lighting On
		}//
	pass {   
		Tags { "LightMode" = "ForwardBase" } 
		Blend DstColor SrcColor
		Offset -1,-1
		CGPROGRAM
		#pragma vertex vert 
		#pragma fragment frag
		#include "UnityCG.cginc"
		float4x4 _World2Ground;
		float4x4 _Ground2World;
		float4 vert(float4 vertex: POSITION) : SV_POSITION
		{
		float3 litDir;
			litDir=normalize(WorldSpaceLightDir(vertex));  
			litDir=mul(_World2Ground,float4(litDir,0)).xyz;
		float4 vt;
			vt= mul(unity_ObjectToWorld, vertex);
			vt=mul(_World2Ground,vt);
		vt.xz=vt.xz-(vt.y/litDir.y)*litDir.xz;
		vt.y=0;
		vt=mul(_Ground2World,vt);//back to world
		vt=mul(unity_WorldToObject,vt);
		return UnityObjectToClipPos(vt);
		}
 		float4 frag(void) : COLOR 
		{
			return float4(0.6,0,0,1);
		}
 		ENDCG 
		}//
		pass {   
		Tags { "LightMode" = "ForwardAdd" } 
		Blend DstColor SrcColor
		Offset -2,-1
		CGPROGRAM
		#pragma vertex vert 
		#pragma fragment frag
		#include "UnityCG.cginc"
		float4x4 _World2Ground;
		float4x4 _Ground2World;
		float4 vert(float4 vertex: POSITION) : SV_POSITION
		{
		float3 litDir;
			litDir=normalize(WorldSpaceLightDir(vertex)); 
			litDir=mul(_World2Ground,float4(litDir,0)).xyz;
		float4 vt;
			vt= mul(unity_ObjectToWorld, vertex);
			vt=mul(_World2Ground,vt);
		vt.xz=vt.xz-(vt.y/litDir.y)*litDir.xz;
		vt.y=0;
		vt=mul(_Ground2World,vt);//back to world
		vt=mul(unity_WorldToObject,vt);
		return UnityObjectToClipPos(vt);
		}
 		float4 frag(void) : COLOR 
		{
			return float4(0,0.6,0,1);
		}
 		ENDCG 
		}
   }
}
