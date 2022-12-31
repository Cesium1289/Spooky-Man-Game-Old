// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DEC/Surface Triplanar/Triplanar Spherical"
{
	Properties
	{
		[Header(DEBUG SETTINGS)][Enum(Off,0,On,1)]_ZWriteMode("ZWrite Mode", Int) = 1
		[Enum(None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15)]_ColorMask("Color Mask Mode", Int) = 15
		[Header(GLOBAL SETTINGS)][Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Int) = 0
		[EmissionFlags]_EmissionFlags("Global Illumination Emissive", Float) = 0
		[Header(BLEND)][DE_DrawerFloatEnum(World Space _Object Space)]_Blend_Space("UV Space", Float) = 1
		_Blend_CoverageAmount("Coverage Amount", Range( -1 , 1)) = 0
		_Blend_CoverageFalloff("Coverage Falloff", Range( 0.01 , 2)) = 0.5
		_Blend_CoverageFactor("Coverage Factor", Range( -1 , 1)) = 1
		[Header(TOP)]_Top_Color("Tint", Color) = (1,1,1,0)
		[DE_DrawerTextureSingleLine]_Top_MainTex("Albedo Map", 2D) = "white" {}
		_Top_Brightness("Brightness", Range( 0 , 2)) = 1
		_Top_TilingX("Tiling X", Float) = 1
		_Top_TilingY("Tiling Y", Float) = 1
		_Top_OffsetX("Offset X", Float) = 0
		_Top_OffsetY("Offset Y", Float) = 0
		[Normal][DE_DrawerTextureSingleLine]_Top_BumpMap("Normal Map", 2D) = "bump" {}
		_Top_NormalStrength("Normal Strength", Float) = 1
		[DE_DrawerTextureSingleLine]_Top_MetallicMap("Metallic Map", 2D) = "white" {}
		_Top_MetallicStrength("Metallic Strength", Range( 0 , 1)) = 0
		[DE_DrawerTextureSingleLine]_Top_OcclusionMap("Occlusion Map", 2D) = "white" {}
		[DE_DrawerToggleNoKeyword]_Top_OcclusionSource("Occlusion is Baked", Float) = 0
		_Top_OcclusionStrengthAO("Occlusion Strength", Range( 0 , 1)) = 0
		[DE_DrawerTextureSingleLine]_Top_SmoothnessMap("Smoothness Map", 2D) = "white" {}
		[DE_DrawerFloatEnum(Smoothness _Roughness _Geometric)]_Top_SmoothnessType("Smoothness Source", Float) = 0
		[DE_DrawerSliderRemap(_Top_SmoothnessMin, _Top_SmoothnessMax,0, 1)]_Top_Smoothness("Smoothness", Vector) = (0,0,0,0)
		[HideInInspector]_Top_SmoothnessMin("Smoothness Min", Range( 0 , 1)) = 0
		[HideInInspector]_Top_SmoothnessMax("Smoothness Max", Range( 0 , 1)) = 0
		[Header(BOTTOM)]_Bottom_Color("Tint", Color) = (1,1,1,0)
		[DE_DrawerTextureSingleLine]_Bottom_MainTex("Albedo Map", 2D) = "white" {}
		_Bottom_Brightness("Brightness", Range( 0 , 2)) = 1
		_Bottom_TilingX("Tiling X", Float) = 1
		_Bottom_TilingY("Tiling Y", Float) = 1
		_Bottom_OffsetX("Offset X", Float) = 0
		_Bottom_OffsetY("Offset Y", Float) = 0
		[Normal][DE_DrawerTextureSingleLine]_Bottom_BumpMap("Normal Map", 2D) = "bump" {}
		_Bottom_NormalStrength("Normal Strength", Float) = 1
		[DE_DrawerTextureSingleLine]_Bottom_MetallicMap("Metallic Map", 2D) = "white" {}
		_Bottom_MetallicStrength("Metallic Strength", Range( 0 , 1)) = 0
		[DE_DrawerToggleNoKeyword]_Bottom_OcclusionSource("Occlusion is Baked", Float) = 0
		_Bottom_OcclusionStrengthAO("Occlusion Strength", Range( 0 , 1)) = 0
		[DE_DrawerTextureSingleLine]_Bottom_SmoothnessMap("Smoothness Map", 2D) = "white" {}
		[DE_DrawerFloatEnum(Smoothness _Roughness _Geometric)]_Bottom_SmoothnessType("Smoothness Source", Float) = 0
		[DE_DrawerSliderRemap(_Bottom_SmoothnessMin,_Bottom_SmoothnessMax,0, 1)]_Bottom_Smoothness("Smoothness", Vector) = (0,0,0,0)
		[HideInInspector]_Bottom_SmoothnessMin("Smoothness Min", Range( 0 , 1)) = 0
		[HideInInspector]_Bottom_SmoothnessMax("Smoothness Max", Range( 0 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry-10" "IgnoreProjector" = "True" "NatureRendererInstancing"="True" }
		LOD 200
		Cull [_CullMode]
		ZWrite [_ZWriteMode]
		ZTest LEqual
		ColorMask [_ColorMask]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 4.6
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma multi_compile_instancing
		#pragma instancing_options procedural:SetupNatureRenderer forwardadd
		#pragma multi_compile GPU_FRUSTUM_ON __
		#include "Nature Renderer.cginc"
		#pragma multi_compile_local _ NATURE_RENDERER
		#define ASE_USING_SAMPLING_MACROS 1
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
		#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
		#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
		#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
		#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
		#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
		#endif//ASE Sampling Macros

		#pragma surface surf Standard keepalpha addshadow fullforwardshadows dithercrossfade 
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float4 vertexColor : COLOR;
		};

		uniform int _ColorMask;
		uniform int _CullMode;
		uniform int _ZWriteMode;
		uniform half _EmissionFlags;
		uniform float _Top_SmoothnessMax;
		uniform float4 _Top_Smoothness;
		uniform float4 _Bottom_Smoothness;
		uniform float _Top_SmoothnessMin;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Bottom_BumpMap);
		uniform half _Blend_Space;
		uniform float _Bottom_TilingX;
		uniform float _Bottom_TilingY;
		uniform float _Bottom_OffsetX;
		uniform float _Bottom_OffsetY;
		SamplerState sampler_trilinear_repeat;
		uniform half _Bottom_NormalStrength;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Top_BumpMap);
		uniform float _Top_TilingX;
		uniform float _Top_TilingY;
		uniform float _Top_OffsetX;
		uniform float _Top_OffsetY;
		uniform half _Top_NormalStrength;
		uniform float _Blend_CoverageAmount;
		uniform float _Blend_CoverageFactor;
		uniform float _Blend_CoverageFalloff;
		uniform float4 _Bottom_Color;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Bottom_MainTex);
		uniform half _Bottom_Brightness;
		uniform float4 _Top_Color;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Top_MainTex);
		uniform half _Top_Brightness;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Bottom_MetallicMap);
		uniform float _Bottom_MetallicStrength;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Top_MetallicMap);
		uniform float _Top_MetallicStrength;
		uniform half _Bottom_SmoothnessType;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Bottom_SmoothnessMap);
		uniform float _Bottom_SmoothnessMin;
		uniform float _Bottom_SmoothnessMax;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Top_OcclusionMap);
		uniform float _Bottom_OcclusionStrengthAO;
		uniform float _Bottom_OcclusionSource;
		uniform half _Top_SmoothnessType;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Top_SmoothnessMap);
		uniform float _Top_OcclusionStrengthAO;
		uniform float _Top_OcclusionSource;


		float4 mod289( float4 x )
		{
			return x - floor(x * (1.0 / 289.0)) * 289.0;
		}


		float4 perm( float4 x )
		{
			return mod289(((x * 34.0) + 1.0) * x);
		}


		float SimpleNoise3D( float3 p )
		{
			 float3 a = floor(p);
			    float3 d = p - a;
			    d = d * d * (3.0 - 2.0 * d);
			 float4 b = a.xxyy + float4(0.0, 1.0, 0.0, 1.0);
			    float4 k1 = perm(b.xyxy);
			 float4 k2 = perm(k1.xyxy + b.zzww);
			    float4 c = k2 + a.zzzz;
			    float4 k3 = perm(c);
			    float4 k4 = perm(c + 1.0);
			    float4 o1 = frac(k3 * (1.0 / 41.0));
			 float4 o2 = frac(k4 * (1.0 / 41.0));
			    float4 o3 = o2 * d.z + o1 * (1.0 - d.z);
			    float2 o4 = o3.yw * d.x + o3.xz * (1.0 - d.x);
			    return o4.y * d.y + o4.x * (1.0 - d.y);
		}


		float4 SmoothnessTypefloat4switch215_g43400( float m_switch, float4 m_Smoothness, float4 m_Roughness, float4 m_Geometric )
		{
			if(m_switch ==0)
				return m_Smoothness;
			else if(m_switch ==1)
				return m_Roughness;
			else if(m_switch ==2)
				return m_Geometric;
			else
			return float4(0,0,0,0);
		}


		float4 SmoothnessTypefloat4switch215_g43388( float m_switch, float4 m_Smoothness, float4 m_Roughness, float4 m_Geometric )
		{
			if(m_switch ==0)
				return m_Smoothness;
			else if(m_switch ==1)
				return m_Roughness;
			else if(m_switch ==2)
				return m_Geometric;
			else
			return float4(0,0,0,0);
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float _UV_SPACE2529_g39140 = _Blend_Space;
			float temp_output_62_0_g43411 = _UV_SPACE2529_g39140;
			float3 lerpResult99_g43414 = lerp( ase_worldPos , ase_vertex3Pos , temp_output_62_0_g43411);
			float3 break10_g43411 = lerpResult99_g43414;
			float2 appendResult13_g43411 = (float2(break10_g43411.y , break10_g43411.z));
			float2 appendResult154_g39140 = (float2(_Bottom_TilingX , _Bottom_TilingY));
			float2 BOTTOM_Tilling563_g39140 = appendResult154_g39140;
			float2 temp_output_60_0_g43411 = BOTTOM_Tilling563_g39140;
			float2 appendResult153_g39140 = (float2(_Bottom_OffsetX , _Bottom_OffsetY));
			float2 BOTTOM_Offset561_g39140 = appendResult153_g39140;
			float2 temp_output_61_0_g43411 = BOTTOM_Offset561_g39140;
			float2 UV_0121_g43411 = ( ( appendResult13_g43411 * temp_output_60_0_g43411 ) + temp_output_61_0_g43411 );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 WorldNormal83_g43412 = ase_worldNormal;
			float3 lerpResult99_g43412 = lerp( WorldNormal83_g43412 , mul( unity_WorldToObject, float4( WorldNormal83_g43412 , 0.0 ) ).xyz , temp_output_62_0_g43411);
			float3 temp_output_33_0_g43411 = abs( lerpResult99_g43412 );
			float dotResult30_g43411 = dot( temp_output_33_0_g43411 , float3(1,1,1) );
			float3 BLEND36_g43411 = ( temp_output_33_0_g43411 / dotResult30_g43411 );
			float3 break109_g43411 = BLEND36_g43411;
			float2 appendResult15_g43411 = (float2(break10_g43411.x , break10_g43411.z));
			float2 UV_0220_g43411 = ( ( appendResult15_g43411 * temp_output_60_0_g43411 ) + temp_output_61_0_g43411 );
			float2 appendResult25_g43411 = (float2(break10_g43411.x , break10_g43411.y));
			float2 UV_0327_g43411 = ( ( appendResult25_g43411 * temp_output_60_0_g43411 ) + temp_output_61_0_g43411 );
			float4 temp_output_2592_71_g39140 = ( ( ( SAMPLE_TEXTURE2D( _Bottom_BumpMap, sampler_trilinear_repeat, UV_0121_g43411 ) * break109_g43411.x ) + ( SAMPLE_TEXTURE2D( _Bottom_BumpMap, sampler_trilinear_repeat, UV_0220_g43411 ) * break109_g43411.y ) ) + ( SAMPLE_TEXTURE2D( _Bottom_BumpMap, sampler_trilinear_repeat, UV_0327_g43411 ) * break109_g43411.z ) );
			float4 BOTTOM_FINAL_NORMAL614_g39140 = temp_output_2592_71_g39140;
			float4 temp_output_1_0_g43390 = BOTTOM_FINAL_NORMAL614_g39140;
			float temp_output_8_0_g43390 = _Bottom_NormalStrength;
			float temp_output_62_0_g43405 = _UV_SPACE2529_g39140;
			float3 lerpResult99_g43408 = lerp( ase_worldPos , ase_vertex3Pos , temp_output_62_0_g43405);
			float3 break10_g43405 = lerpResult99_g43408;
			float2 appendResult13_g43405 = (float2(break10_g43405.y , break10_g43405.z));
			float2 appendResult897_g39140 = (float2(_Top_TilingX , _Top_TilingY));
			float2 TOP_Tilling892_g39140 = appendResult897_g39140;
			float2 temp_output_60_0_g43405 = TOP_Tilling892_g39140;
			float2 appendResult896_g39140 = (float2(_Top_OffsetX , _Top_OffsetY));
			float2 TOP_Offset869_g39140 = appendResult896_g39140;
			float2 temp_output_61_0_g43405 = TOP_Offset869_g39140;
			float2 UV_0121_g43405 = ( ( appendResult13_g43405 * temp_output_60_0_g43405 ) + temp_output_61_0_g43405 );
			float3 WorldNormal83_g43406 = ase_worldNormal;
			float3 lerpResult99_g43406 = lerp( WorldNormal83_g43406 , mul( unity_WorldToObject, float4( WorldNormal83_g43406 , 0.0 ) ).xyz , temp_output_62_0_g43405);
			float3 temp_output_33_0_g43405 = abs( lerpResult99_g43406 );
			float dotResult30_g43405 = dot( temp_output_33_0_g43405 , float3(1,1,1) );
			float3 BLEND36_g43405 = ( temp_output_33_0_g43405 / dotResult30_g43405 );
			float3 break109_g43405 = BLEND36_g43405;
			float2 appendResult15_g43405 = (float2(break10_g43405.x , break10_g43405.z));
			float2 UV_0220_g43405 = ( ( appendResult15_g43405 * temp_output_60_0_g43405 ) + temp_output_61_0_g43405 );
			float2 appendResult25_g43405 = (float2(break10_g43405.x , break10_g43405.y));
			float2 UV_0327_g43405 = ( ( appendResult25_g43405 * temp_output_60_0_g43405 ) + temp_output_61_0_g43405 );
			float4 temp_output_2524_71_g39140 = ( ( ( SAMPLE_TEXTURE2D( _Top_BumpMap, sampler_trilinear_repeat, UV_0121_g43405 ) * break109_g43405.x ) + ( SAMPLE_TEXTURE2D( _Top_BumpMap, sampler_trilinear_repeat, UV_0220_g43405 ) * break109_g43405.y ) ) + ( SAMPLE_TEXTURE2D( _Top_BumpMap, sampler_trilinear_repeat, UV_0327_g43405 ) * break109_g43405.z ) );
			float4 TOP_FINAL_NORMAL641_g39140 = temp_output_2524_71_g39140;
			float4 temp_output_1_0_g43392 = TOP_FINAL_NORMAL641_g39140;
			float temp_output_8_0_g43392 = _Top_NormalStrength;
			float3 WorldNormal83_g43417 = ase_worldNormal;
			float3 lerpResult99_g43417 = lerp( WorldNormal83_g43417 , mul( unity_WorldToObject, float4( WorldNormal83_g43417 , 0.0 ) ).xyz , _Blend_Space);
			float temp_output_180_0_g39140 = ( 1.0 + _Blend_CoverageFactor );
			float _Coverage_Normal2553_g39140 = saturate( pow( saturate( ( lerpResult99_g43417.y * _Blend_CoverageAmount * temp_output_180_0_g39140 ) ) , _Blend_CoverageFalloff ) );
			float3 lerpResult47_g39140 = lerp( UnpackScaleNormal( temp_output_1_0_g43390, temp_output_8_0_g43390 ) , UnpackScaleNormal( temp_output_1_0_g43392, temp_output_8_0_g43392 ) , _Coverage_Normal2553_g39140);
			o.Normal = lerpResult47_g39140;
			float3 break48_g43411 = BLEND36_g43411;
			float4 temp_output_59_0_g43411 = ( ( ( SAMPLE_TEXTURE2D( _Bottom_MainTex, sampler_trilinear_repeat, UV_0121_g43411 ) * break48_g43411.x ) + ( SAMPLE_TEXTURE2D( _Bottom_MainTex, sampler_trilinear_repeat, UV_0220_g43411 ) * break48_g43411.y ) ) + ( SAMPLE_TEXTURE2D( _Bottom_MainTex, sampler_trilinear_repeat, UV_0327_g43411 ) * break48_g43411.z ) );
			float4 temp_output_2592_78_g39140 = temp_output_59_0_g43411;
			float4 BOTTOM_FINAL_ALBEDO612_g39140 = temp_output_2592_78_g39140;
			float3 break48_g43405 = BLEND36_g43405;
			float4 temp_output_59_0_g43405 = ( ( ( SAMPLE_TEXTURE2D( _Top_MainTex, sampler_trilinear_repeat, UV_0121_g43405 ) * break48_g43405.x ) + ( SAMPLE_TEXTURE2D( _Top_MainTex, sampler_trilinear_repeat, UV_0220_g43405 ) * break48_g43405.y ) ) + ( SAMPLE_TEXTURE2D( _Top_MainTex, sampler_trilinear_repeat, UV_0327_g43405 ) * break48_g43405.z ) );
			float4 temp_output_2524_78_g39140 = temp_output_59_0_g43405;
			float4 TOP_FINAL_ALBEDO632_g39140 = temp_output_2524_78_g39140;
			float3 GLOBAL_NORMAL_OUT525_g39140 = lerpResult47_g39140;
			float3 WorldNormal83_g43397 = (WorldNormalVector( i , GLOBAL_NORMAL_OUT525_g39140 ));
			float3 lerpResult99_g43397 = lerp( WorldNormal83_g43397 , mul( unity_WorldToObject, float4( WorldNormal83_g43397 , 0.0 ) ).xyz , _Blend_Space);
			float _Coverage2552_g39140 = saturate( pow( saturate( ( lerpResult99_g43397.y * _Blend_CoverageAmount * temp_output_180_0_g39140 ) ) , _Blend_CoverageFalloff ) );
			float4 lerpResult1269_g39140 = lerp( ( float4( (_Bottom_Color).rgb , 0.0 ) * BOTTOM_FINAL_ALBEDO612_g39140 * _Bottom_Brightness ) , ( float4( (_Top_Color).rgb , 0.0 ) * TOP_FINAL_ALBEDO632_g39140 * _Top_Brightness ) , _Coverage2552_g39140);
			o.Albedo = lerpResult1269_g39140.rgb;
			float3 break169_g43411 = BLEND36_g43411;
			float4 temp_output_2592_70_g39140 = ( ( ( SAMPLE_TEXTURE2D( _Bottom_MetallicMap, sampler_trilinear_repeat, UV_0121_g43411 ) * break169_g43411.x ) + ( SAMPLE_TEXTURE2D( _Bottom_MetallicMap, sampler_trilinear_repeat, UV_0220_g43411 ) * break169_g43411.y ) ) + ( SAMPLE_TEXTURE2D( _Bottom_MetallicMap, sampler_trilinear_repeat, UV_0327_g43411 ) * break169_g43411.z ) );
			float4 BOTTOM_MASK_MAP_B357_g39140 = temp_output_2592_70_g39140;
			float temp_output_1_0_g43395 = _Bottom_MetallicStrength;
			float BOTTOM_FINAL_METALLIC483_g39140 = ( BOTTOM_MASK_MAP_B357_g39140.r * temp_output_1_0_g43395 );
			float3 break169_g43405 = BLEND36_g43405;
			float4 temp_output_2524_70_g39140 = ( ( ( SAMPLE_TEXTURE2D( _Top_MetallicMap, sampler_trilinear_repeat, UV_0121_g43405 ) * break169_g43405.x ) + ( SAMPLE_TEXTURE2D( _Top_MetallicMap, sampler_trilinear_repeat, UV_0220_g43405 ) * break169_g43405.y ) ) + ( SAMPLE_TEXTURE2D( _Top_MetallicMap, sampler_trilinear_repeat, UV_0327_g43405 ) * break169_g43405.z ) );
			float4 TOP_MASK_MAP_B372_g39140 = temp_output_2524_70_g39140;
			float temp_output_1_0_g43393 = _Top_MetallicStrength;
			float TOP_FINAL_METALLIC482_g39140 = ( TOP_MASK_MAP_B372_g39140.r * temp_output_1_0_g43393 );
			float lerpResult364_g39140 = lerp( BOTTOM_FINAL_METALLIC483_g39140 , TOP_FINAL_METALLIC482_g39140 , _Coverage2552_g39140);
			o.Metallic = lerpResult364_g39140;
			float temp_output_223_0_g43400 = _Bottom_SmoothnessType;
			float m_switch215_g43400 = temp_output_223_0_g43400;
			float3 break154_g43411 = BLEND36_g43411;
			float4 temp_output_2592_72_g39140 = ( ( ( SAMPLE_TEXTURE2D( _Bottom_SmoothnessMap, sampler_trilinear_repeat, UV_0121_g43411 ) * break154_g43411.x ) + ( SAMPLE_TEXTURE2D( _Bottom_SmoothnessMap, sampler_trilinear_repeat, UV_0220_g43411 ) * break154_g43411.y ) ) + ( SAMPLE_TEXTURE2D( _Bottom_SmoothnessMap, sampler_trilinear_repeat, UV_0327_g43411 ) * break154_g43411.z ) );
			float4 BOTTOM_MASK_MAP_G358_g39140 = temp_output_2592_72_g39140;
			float4 temp_cast_16 = (_Bottom_SmoothnessMin).xxxx;
			float4 temp_cast_17 = (_Bottom_SmoothnessMax).xxxx;
			float4 temp_output_216_0_g43400 = (temp_cast_16 + (BOTTOM_MASK_MAP_G358_g39140 - float4( 0,0,0,0 )) * (temp_cast_17 - temp_cast_16) / (float4( 1,1,1,1 ) - float4( 0,0,0,0 )));
			float4 m_Smoothness215_g43400 = temp_output_216_0_g43400;
			float4 temp_cast_18 = (_Bottom_SmoothnessMin).xxxx;
			float4 temp_cast_19 = (_Bottom_SmoothnessMax).xxxx;
			float4 temp_output_214_0_g43400 = ( 1.0 - temp_output_216_0_g43400 );
			float4 m_Roughness215_g43400 = temp_output_214_0_g43400;
			float4 temp_cast_20 = (_Bottom_SmoothnessMin).xxxx;
			float4 temp_cast_21 = (_Bottom_SmoothnessMax).xxxx;
			float3 BOTTOM_FINAL_NORMAL_WORLD329_g39140 = (WorldNormalVector( i , UnpackScaleNormal( temp_output_1_0_g43390, temp_output_8_0_g43390 ) ));
			float3 temp_output_4_0_g43400 = BOTTOM_FINAL_NORMAL_WORLD329_g39140;
			float3 temp_output_178_0_g43400 = ddx( temp_output_4_0_g43400 );
			float dotResult195_g43400 = dot( temp_output_178_0_g43400 , temp_output_178_0_g43400 );
			float3 temp_output_175_0_g43400 = ddy( temp_output_4_0_g43400 );
			float dotResult201_g43400 = dot( temp_output_175_0_g43400 , temp_output_175_0_g43400 );
			float BOTTOM_ALBEDO_R359_g39140 = temp_output_2592_78_g39140.r;
			float4 temp_cast_22 = (BOTTOM_ALBEDO_R359_g39140).xxxx;
			float4 m_Geometric215_g43400 = ( sqrt( saturate( ( temp_output_216_0_g43400 + ( ( dotResult195_g43400 + dotResult201_g43400 ) * 2.0 ) ) ) ) * ( 1.0 - temp_cast_22 ) );
			float4 localSmoothnessTypefloat4switch215_g43400 = SmoothnessTypefloat4switch215_g43400( m_switch215_g43400 , m_Smoothness215_g43400 , m_Roughness215_g43400 , m_Geometric215_g43400 );
			float3 break184_g43405 = BLEND36_g43405;
			float4 temp_output_2524_76_g39140 = ( ( ( SAMPLE_TEXTURE2D( _Top_OcclusionMap, sampler_trilinear_repeat, UV_0121_g43405 ) * break184_g43405.x ) + ( SAMPLE_TEXTURE2D( _Top_OcclusionMap, sampler_trilinear_repeat, UV_0220_g43405 ) * break184_g43405.y ) ) + ( SAMPLE_TEXTURE2D( _Top_OcclusionMap, sampler_trilinear_repeat, UV_0327_g43405 ) * break184_g43405.z ) );
			float4 TOP_PBR_Occlusion2835_g39140 = temp_output_2524_76_g39140;
			float temp_output_16_0_g43410 = _Bottom_OcclusionStrengthAO;
			float temp_output_65_0_g43410 = ( 1.0 - temp_output_16_0_g43410 );
			float3 appendResult69_g43410 = (float3(temp_output_65_0_g43410 , temp_output_65_0_g43410 , temp_output_65_0_g43410));
			float4 color77_g43410 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float4 temp_cast_25 = (i.vertexColor.a).xxxx;
			float4 lerpResult75_g43410 = lerp( color77_g43410 , temp_cast_25 , temp_output_16_0_g43410);
			float4 lerpResult83_g43410 = lerp( float4( ( ( ( (TOP_PBR_Occlusion2835_g39140).xyz - float3( 0.5,0.5,0.5 ) ) * temp_output_16_0_g43410 ) + appendResult69_g43410 ) , 0.0 ) , lerpResult75_g43410 , _Bottom_OcclusionSource);
			float4 BOTTOM_FINAL_SMOOTHNESS485_g39140 = ( localSmoothnessTypefloat4switch215_g43400 * saturate( lerpResult83_g43410 ) );
			float temp_output_223_0_g43388 = _Top_SmoothnessType;
			float m_switch215_g43388 = temp_output_223_0_g43388;
			float3 break154_g43405 = BLEND36_g43405;
			float4 temp_output_2524_72_g39140 = ( ( ( SAMPLE_TEXTURE2D( _Top_SmoothnessMap, sampler_trilinear_repeat, UV_0121_g43405 ) * break154_g43405.x ) + ( SAMPLE_TEXTURE2D( _Top_SmoothnessMap, sampler_trilinear_repeat, UV_0220_g43405 ) * break154_g43405.y ) ) + ( SAMPLE_TEXTURE2D( _Top_SmoothnessMap, sampler_trilinear_repeat, UV_0327_g43405 ) * break154_g43405.z ) );
			float4 TOP_MASK_MAP_G371_g39140 = temp_output_2524_72_g39140;
			float4 temp_cast_28 = (_Top_SmoothnessMin).xxxx;
			float4 temp_cast_29 = (_Top_SmoothnessMax).xxxx;
			float4 temp_output_216_0_g43388 = (temp_cast_28 + (TOP_MASK_MAP_G371_g39140 - float4( 0,0,0,0 )) * (temp_cast_29 - temp_cast_28) / (float4( 1,1,1,1 ) - float4( 0,0,0,0 )));
			float4 m_Smoothness215_g43388 = temp_output_216_0_g43388;
			float4 temp_cast_30 = (_Top_SmoothnessMin).xxxx;
			float4 temp_cast_31 = (_Top_SmoothnessMax).xxxx;
			float4 temp_output_214_0_g43388 = ( 1.0 - temp_output_216_0_g43388 );
			float4 m_Roughness215_g43388 = temp_output_214_0_g43388;
			float4 temp_cast_32 = (_Top_SmoothnessMin).xxxx;
			float4 temp_cast_33 = (_Top_SmoothnessMax).xxxx;
			float3 TOP_FINAL_NORMAL_WORLD377_g39140 = (WorldNormalVector( i , UnpackScaleNormal( temp_output_1_0_g43392, temp_output_8_0_g43392 ) ));
			float3 temp_output_4_0_g43388 = TOP_FINAL_NORMAL_WORLD377_g39140;
			float3 temp_output_178_0_g43388 = ddx( temp_output_4_0_g43388 );
			float dotResult195_g43388 = dot( temp_output_178_0_g43388 , temp_output_178_0_g43388 );
			float3 temp_output_175_0_g43388 = ddy( temp_output_4_0_g43388 );
			float dotResult201_g43388 = dot( temp_output_175_0_g43388 , temp_output_175_0_g43388 );
			float TOP_ALBEDO_R2629_g39140 = temp_output_2524_78_g39140.r;
			float4 temp_cast_34 = (TOP_ALBEDO_R2629_g39140).xxxx;
			float4 m_Geometric215_g43388 = ( sqrt( saturate( ( temp_output_216_0_g43388 + ( ( dotResult195_g43388 + dotResult201_g43388 ) * 2.0 ) ) ) ) * ( 1.0 - temp_cast_34 ) );
			float4 localSmoothnessTypefloat4switch215_g43388 = SmoothnessTypefloat4switch215_g43388( m_switch215_g43388 , m_Smoothness215_g43388 , m_Roughness215_g43388 , m_Geometric215_g43388 );
			float temp_output_16_0_g43404 = _Top_OcclusionStrengthAO;
			float temp_output_65_0_g43404 = ( 1.0 - temp_output_16_0_g43404 );
			float3 appendResult69_g43404 = (float3(temp_output_65_0_g43404 , temp_output_65_0_g43404 , temp_output_65_0_g43404));
			float4 color77_g43404 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float4 temp_cast_37 = (i.vertexColor.a).xxxx;
			float4 lerpResult75_g43404 = lerp( color77_g43404 , temp_cast_37 , temp_output_16_0_g43404);
			float4 lerpResult83_g43404 = lerp( float4( ( ( ( (TOP_PBR_Occlusion2835_g39140).xyz - float3( 0.5,0.5,0.5 ) ) * temp_output_16_0_g43404 ) + appendResult69_g43404 ) , 0.0 ) , lerpResult75_g43404 , _Top_OcclusionSource);
			float4 TOP_FINAL_SMOOTHNESS484_g39140 = ( localSmoothnessTypefloat4switch215_g43388 * saturate( lerpResult83_g43404 ) );
			float4 lerpResult365_g39140 = lerp( BOTTOM_FINAL_SMOOTHNESS485_g39140 , TOP_FINAL_SMOOTHNESS484_g39140 , _Coverage2552_g39140);
			o.Smoothness = lerpResult365_g39140.x;
			float4 BOTTOM_FINAL_OCCLUSION487_g39140 = saturate( lerpResult83_g43410 );
			float4 TOP_FINAL_OCCLUSION486_g39140 = saturate( lerpResult83_g43404 );
			float4 lerpResult488_g39140 = lerp( BOTTOM_FINAL_OCCLUSION487_g39140 , TOP_FINAL_OCCLUSION486_g39140 , _Coverage2552_g39140);
			o.Occlusion = lerpResult488_g39140.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "DE_ShaderGUI"
}
/*ASEBEGIN
Version=18934
79;54;1654;856;-395.834;1216.781;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;290;1377.96,-881.2607;Inherit;False;444.4987;192.4197;DEBUG SETTINGS ;3;293;353;291;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;295;1379.783,-1005.666;Inherit;False;444.9667;116.002;GLOBAL SETTINGS ;2;467;294;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;464;1380.689,-260.329;Inherit;False;329.9845;123.4943;DESF Common ASE Compile Shaders;1;465;;0,0.2605708,1,1;0;0
Node;AmplifyShaderEditor.IntNode;291;1387.189,-839.5454;Inherit;False;Property;_ColorMask;Color Mask Mode;1;1;[Enum];Create;False;1;;0;1;None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15;True;0;False;15;15;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;353;1391.431,-768.1531;Inherit;False;Constant;_MaskClipValue1;Mask Clip Value;14;0;Create;True;1;;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;294;1394.596,-970.8541;Inherit;False;Property;_CullMode;Cull Mode;2;2;[Header];[Enum];Create;True;1;GLOBAL SETTINGS;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;2;False;0;1;INT;0
Node;AmplifyShaderEditor.FunctionNode;465;1396.685,-219.331;Inherit;False;DESF Utility ASE Compile Shaders;-1;;39139;b85b01c42ba8a8a448b731b68fc0dbd9;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;293;1574.693,-836.7177;Inherit;False;Property;_ZWriteMode;ZWrite Mode;0;2;[Header];[Enum];Create;False;1;DEBUG SETTINGS;0;1;Off,0,On,1;True;0;False;1;1;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;467;1549.334,-968.2805;Half;False;Property;_EmissionFlags;Global Illumination Emissive;3;0;Create;False;0;0;0;True;1;EmissionFlags;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;466;995.8124,-685.7231;Inherit;False;DESF Core Surface Triplanar Spherical;4;;39140;790fb642c24decb4ebda2614061db534;30,524,0,513,0,518,1,2055,1,2614,1,2056,1,2603,1,2609,1,2057,1,1416,0,2604,0,2605,0,2617,0,2615,0,2616,0,2610,0,2543,0,2611,0,2547,0,2549,0,2545,0,1418,0,1417,0,2832,0,2807,0,2804,0,2511,0,2512,0,2510,0,2516,0;0;7;COLOR;0;FLOAT3;122;FLOAT;489;FLOAT4;351;COLOR;352;FLOAT;2818;FLOAT3;2446
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;194;1374.904,-680.6909;Float;False;True;-1;6;DE_ShaderGUI;200;0;Standard;DEC/Surface Triplanar/Triplanar Spherical;False;False;False;False;False;False;False;False;False;False;False;False;True;False;True;False;False;False;True;True;True;Back;0;True;293;3;False;292;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;-10;True;Opaque;;Geometry;All;18;all;True;True;True;True;0;True;291;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;1;0;5;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;200;;-1;-1;-1;-1;1;NatureRendererInstancing=True;False;0;0;True;294;-1;0;True;353;5;Pragma;multi_compile_instancing;False;;Custom;Pragma;instancing_options procedural:SetupNatureRenderer forwardadd;False;;Custom;Pragma;multi_compile GPU_FRUSTUM_ON __;False;;Custom;Include;Nature Renderer.cginc;False;5d792e02fd6741e4cb63087f97979470;Custom;Pragma;multi_compile_local _ NATURE_RENDERER;False;;Custom;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;194;0;466;0
WireConnection;194;1;466;122
WireConnection;194;3;466;489
WireConnection;194;4;466;351
WireConnection;194;5;466;352
ASEEND*/
//CHKSM=854F480F3BB4B50AC4E8C798D8D667A331FEFEB1