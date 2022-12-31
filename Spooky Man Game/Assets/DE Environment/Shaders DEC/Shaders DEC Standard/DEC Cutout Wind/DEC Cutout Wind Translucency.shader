// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DEC/Cutout Wind/Cutout Wind Translucency"
{
	Properties
	{
		[Header(DEBUG SETTINGS)][Enum(Off,0,On,1)]_ZWriteMode("ZWrite Mode", Int) = 1
		[Enum(None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15)]_ColorMask("Color Mask Mode", Int) = 15
		[Enum(Off,0,On,1)]_AlphatoCoverage("Alpha to Coverage", Float) = 0
		[Header(GLOBAL SETTINGS)][Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Int) = 0
		[EmissionFlags]_EmissionFlags("Global Illumination Emissive", Float) = 0
		[DE_DrawerFloatEnum(Default _Flip _Mirror)]_NormalMode("Normal Mode", Float) = 0
		[DE_DrawerToggleNoKeyword]_GlancingClipMode("Enable Clip Glancing Angle", Float) = 1
		[Header(MAIN MAPS)]_Color("Tint", Color) = (1,1,1,0)
		[DE_DrawerTextureSingleLine]_MainTex("Albedo Map", 2D) = "white" {}
		_Brightness("Brightness", Range( 0 , 2)) = 1
		_AlphaCutoffBias("Alpha Cutoff Bias", Range( 0 , 1)) = 0.5
		_TilingX("Tiling X", Float) = 1
		_TilingY("Tiling Y", Float) = 1
		_OffsetX("Offset X", Float) = 0
		_OffsetY("Offset Y", Float) = 0
		[Normal][DE_DrawerTextureSingleLine]_BumpMap("Normal Map", 2D) = "bump" {}
		_NormalStrength("Normal Strength", Float) = 1
		[DE_DrawerTextureSingleLine]_MetallicGlossMap("Metallic Map", 2D) = "white" {}
		_MetallicStrength("Metallic Strength", Range( 0 , 1)) = 0
		[DE_DrawerTextureSingleLine]_OcclusionMap("Occlusion Map", 2D) = "white" {}
		[DE_DrawerToggleNoKeyword]_OcclusionSource("Occlusion is Baked", Float) = 0
		_OcclusionStrengthAO("Occlusion Strength", Range( 0 , 1)) = 0
		[DE_DrawerTextureSingleLine]_SmoothnessMap("Smoothness Map", 2D) = "white" {}
		[DE_DrawerFloatEnum(Smoothness _Roughness _Geometric)]_SmoothnessSource("Smoothness Source", Float) = 0
		[DE_DrawerSliderRemap(_SmoothnessMin, _SmoothnessMax,0, 1)]_Smoothness("Smoothness", Vector) = (0,0,0,0)
		[HideInInspector]_SmoothnessMin("Smoothness Min", Range( 0 , 1)) = 0
		[HideInInspector]_SmoothnessMax("Smoothness Max", Range( 0 , 1)) = 0
		[HideInInspector]_MaskClipValue("Mask Clip Value", Float) = 0.5
		[Header(COLOR SHIFT)][DE_DrawerFloatEnum(Off _Object Space _World Space _Vertex Color _Vertex Normal)]_ColorShift_Mode("Mode", Float) = 0
		_ColorShift_ShiftVariation("Shift Variation", Range( 0 , 1)) = 0.2
		_ColorShift_ShiftVariationRGB("Shift Variation RGB", Range( -0.5 , 0.5)) = 0.2
		_ColorShift_ShiftInfluence("Shift Influence ", Range( 0 , 1)) = 0.75
		_ColorShift_ShiftSaturation("Shift Saturation", Range( 0 , 1)) = 0.85
		_ColorShift_NoiseScale("Noise Scale", Range( 0 , 2)) = 1
		[Header(COLOR SHIFT (World Space Mode))]_ColorShift_WorldSpaceDistance("Distance", Range( 0.01 , 5)) = 5
		_ColorShift_WorldSpaceOffset("Offset", Range( -1 , 1)) = 1
		_ColorShift_WorldSpaceNoiseShift("Noise Shift", Range( 1 , 5)) = 5
		[Header(COLOR SHIFT (Mask))][DE_DrawerFloatEnum(Off _Active _Active Inverted)]_ColorShift_MaskMode("Mode", Float) = 0
		[DE_DrawerTextureSingleLine]_ColorShift_MaskMap("Mask Map", 2D) = "black" {}
		_ColorShift_MaskFuzziness("Mask Fuzziness", Range( 0 , 1)) = 0.25
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord4( "", 2D ) = "white" {}
		[Header(TRANSLUCENCY)][DE_DrawerToggleNoKeyword]_EnableTranslucency("Enable Translucency", Float) = 0
		[DE_DrawerFloatEnum(Texture _Texture Inverted _Baked)]_TranslucencySourceFoward("Translucency Source", Float) = 0
		[HDR]_TranslucencyTint("Translucency Tint", Color) = (0.575,0.75,0,1)
		[HDR]_TransmissionTint("Transmission Tint", Color) = (0.3833333,0.5,0,1)
		[NoScaleOffset][DE_DrawerTextureSingleLine]_TranslucencyMap("Translucency Map", 2D) = "white" {}
		_TranslucencyThickness("Thickness", Range( 0 , 1.5)) = 1.466198
		_TranslucencyThicknessFeather("Thickness Feather", Range( 0 , 1)) = 1
		[Header(Translucency)]
		_Translucency("Strength", Range( 0 , 50)) = 1
		_TransNormalDistortion("Normal Distortion", Range( 0 , 1)) = 0.1
		_TransScattering("Scaterring Falloff", Range( 1 , 50)) = 2
		_TransDirect("Direct", Range( 0 , 1)) = 1
		_TransAmbient("Ambient", Range( 0 , 1)) = 0.2
		_TransShadow("Shadow", Range( 0 , 1)) = 0.9
		[Header(WIND)][DE_DrawerFloatEnum(Off _Global _Local)]_WindMode("Enable Wind Mode", Float) = 0
		[DE_DrawerFloatEnum(Leaf _Palm _Grass _Simple _Ivy)]_WindType("Wind Type", Float) = 0
		[Header(WIND MODE GLOBAL)]_GlobalWindInfluenceOther("Main", Float) = 1
		_GlobalTurbulenceInfluence("Turbulence", Float) = 0.35
		[Header(WIND MODE LOCAL)]_LocalWindStrength("Main", Float) = 1
		_LocalWindTurbulence("Turbulence", Float) = 0.35
		_LocalWindPulse("Pulse Frequency", Float) = 0.1
		_LocalWindDirection("Direction", Range( 0 , 360)) = 0
		_LocalRandomWindOffset("Random Offset", Float) = 0.2
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry-10" "NatureRendererInstancing"="True" }
		LOD 200
		Cull [_CullMode]
		ZWrite [_ZWriteMode]
		ZTest LEqual
		AlphaToMask [_AlphatoCoverage]
		ColorMask [_ColorMask]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#pragma target 3.5
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

		#pragma surface surf StandardCustom keepalpha addshadow fullforwardshadows exclude_path:deferred dithercrossfade vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			half ASEVFace : VFACE;
			float4 vertexColor : COLOR;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv4_texcoord4;
		};

		struct SurfaceOutputStandardCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			half3 Transmission;
			half3 Translucency;
		};

		uniform float _AlphatoCoverage;
		uniform int _CullMode;
		uniform int _ZWriteMode;
		uniform int _ColorMask;
		uniform half _EmissionFlags;
		uniform float4 _Smoothness;
		uniform float _SmoothnessMin;
		uniform float _SmoothnessMax;
		uniform int _Global_Wind_Main_Fade_Enabled;
		uniform half _WindMode;
		uniform half _WindType;
		uniform float _GlobalWindInfluenceOther;
		uniform float _Global_Wind_Main_Intensity;
		uniform float _LocalWindStrength;
		uniform float _Global_Wind_Main_RandomOffset;
		uniform float _LocalRandomWindOffset;
		uniform float _Global_Wind_Main_Pulse;
		uniform float _LocalWindPulse;
		uniform float _Global_Wind_Main_Direction;
		uniform float _LocalWindDirection;
		uniform float _GlobalTurbulenceInfluence;
		uniform float _Global_Wind_Main_Turbulence;
		uniform float _LocalWindTurbulence;
		uniform float _Global_Wind_Main_Fade_Bias;
		uniform half _NormalMode;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
		uniform float _TilingX;
		uniform float _TilingY;
		uniform float _OffsetX;
		uniform float _OffsetY;
		SamplerState sampler_trilinear_repeat;
		uniform half _NormalStrength;
		uniform half _ColorShift_Mode;
		uniform float4 _Color;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
		uniform half _Brightness;
		uniform half _ColorShift_MaskMode;
		uniform float _ColorShift_NoiseScale;
		uniform float _ColorShift_WorldSpaceNoiseShift;
		uniform float _ColorShift_WorldSpaceOffset;
		uniform float _ColorShift_WorldSpaceDistance;
		uniform float _ColorShift_ShiftVariation;
		uniform float _ColorShift_ShiftVariationRGB;
		uniform float _ColorShift_ShiftSaturation;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_ColorShift_MaskMap);
		uniform float4 _ColorShift_MaskMap_ST;
		uniform float _ColorShift_MaskFuzziness;
		uniform float _ColorShift_ShiftInfluence;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MetallicGlossMap);
		uniform float _MetallicStrength;
		uniform half _SmoothnessSource;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_SmoothnessMap);
		UNITY_DECLARE_TEX2D_NOSAMPLER(_OcclusionMap);
		uniform float _OcclusionStrengthAO;
		uniform float _OcclusionSource;
		uniform half4 _TransmissionTint;
		uniform half _TranslucencySourceFoward;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_TranslucencyMap);
		uniform float _TranslucencyThicknessFeather;
		uniform float _TranslucencyThickness;
		uniform float _EnableTranslucency;
		uniform half _Translucency;
		uniform half _TransNormalDistortion;
		uniform half _TransScattering;
		uniform half _TransDirect;
		uniform half _TransAmbient;
		uniform half _TransShadow;
		uniform float4 _TranslucencyTint;
		uniform half _AlphaCutoffBias;
		uniform float _GlancingClipMode;
		uniform float _MaskClipValue;


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


		float Wind_Globalfloatswitch( int m_switch, float m_Off, float m_Global, float m_Local )
		{
			if(m_switch ==0)
				return m_Off;
			else if(m_switch ==1)
				return m_Global;
			else if(m_switch ==2)
				return m_Local;
			else
			return float(0);
		}


		float2 DirectionalEquation( float _WindDirection )
		{
			float d = _WindDirection * 0.0174532924;
			float xL = cos(d) + 1 / 2;
			float zL = sin(d) + 1 / 2;
			return float2(zL,xL);
		}


		float3 Wind_Typefloat3switch2439_g40230( float m_switch, float3 m_Leaf, float3 m_Palm, float3 m_Grass, float3 m_Simple, float3 m_Ivy )
		{
			if(m_switch ==0)
				return m_Leaf;
			else if(m_switch ==1)
				return m_Palm;
			else if(m_switch ==2)
				return m_Grass;
			else if(m_switch ==3)
				return m_Simple;
			else if(m_switch ==4)
				return m_Ivy;
			else
			return float3(0,0,0);
		}


		float3 Wind_Globalfloat3switch( float m_switch, float3 m_Off, float3 m_Global, float3 m_Local )
		{
			if(m_switch ==0)
				return m_Off;
			else if(m_switch ==1)
				return m_Global;
			else if(m_switch ==2)
				return m_Local;
			else
			return float3(0,0,0);
		}


		float3 Wind_Fadefloat3switch3050_g40230( int m_switch, float3 m_Off, float3 m_ActiveFadeOut, float3 m_ActiveFadeIn )
		{
			if(m_switch ==0)
				return m_Off;
			else if(m_switch ==1)
				return m_ActiveFadeOut;
			else if(m_switch ==2)
				return m_ActiveFadeIn;
			else
			return float3(0,0,0);
		}


		float3 _NormalModefloat3switch( float m_switch, float3 m_Default, float3 m_Flip, float3 m_Mirror )
		{
			if(m_switch ==0)
				return m_Default;
			else if(m_switch ==1)
				return m_Flip;
			else if(m_switch ==2)
				return m_Mirror;
			else
			return float3(0,0,0);
		}


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		float ColorShift_Modefloatswitch168_g45130( float m_switch, float m_Off, float m_ObjectSpace, float m_WorldSpace, float m_VertexColor, float m_VertexNormal )
		{
			if(m_switch ==0)
				return m_Off;
			else if(m_switch ==1)
				return m_ObjectSpace;
			else if(m_switch ==2)
				return m_WorldSpace;
			else if(m_switch ==3)
				return m_VertexColor;
			else if(m_switch ==4)
				return m_VertexNormal;
			else
			return float(0);
		}


		float3 RGBToHSV(float3 c)
		{
			float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
			float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
			float d = q.x - min( q.w, q.y );
			float e = 1.0e-10;
			return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		float4 ColorShift_Maskfloat4switch313_g45130( float m_switch, float4 m_Off, float4 m_Active, float4 m_ActiveInverted )
		{
			if(m_switch ==0)
				return m_Off;
			else if(m_switch ==1)
				return m_Active;
			else if(m_switch ==2)
				return m_ActiveInverted;
			else
			return float4(0,0,0,0);
		}


		float4 ColorShift_Modefloat4switch364_g45130( float m_switch, float4 m_Off, float4 m_ObjectSpace, float4 m_WorldSpace, float4 m_VertexColor, float4 m_VertexNormal )
		{
			if(m_switch ==0)
				return m_Off;
			else if(m_switch ==1)
				return m_ObjectSpace;
			else if(m_switch ==2)
				return m_WorldSpace;
			else if(m_switch ==3)
				return m_VertexColor;
			else if(m_switch ==4)
				return m_VertexNormal;
			else
			return float4(0,0,0,0);
		}


		float4 SmoothnessTypefloat4switch215_g45121( float m_switch, float4 m_Smoothness, float4 m_Roughness, float4 m_Geometric )
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


		float4 float4switch103_g45113( float m_switch, float4 m_Texture, float4 m_TextureInverted, float4 m_Baked )
		{
			if(m_switch ==0)
				return m_Texture;
			else if(m_switch ==1)
				return m_TextureInverted;
			else if(m_switch ==2)
				return m_Baked;
			else
			return float4(0,0,0,0);
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			int m_switch3050_g40230 = _Global_Wind_Main_Fade_Enabled;
			float m_switch2453_g40230 = _WindMode;
			float3 m_Off2453_g40230 = float3(0,0,0);
			float m_switch2439_g40230 = _WindType;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VERTEX_POSITION_MATRIX2352_g40230 = mul( unity_ObjectToWorld, float4( ase_vertex3Pos , 0.0 ) ).xyz;
			float3 break2265_g40230 = VERTEX_POSITION_MATRIX2352_g40230;
			float WIND_MODE2462_g40230 = _WindMode;
			int m_switch2458_g40230 = (int)WIND_MODE2462_g40230;
			float m_Off2458_g40230 = 1.0;
			float m_Global2458_g40230 = ( _GlobalWindInfluenceOther * _Global_Wind_Main_Intensity );
			float m_Local2458_g40230 = _LocalWindStrength;
			float localWind_Globalfloatswitch2458_g40230 = Wind_Globalfloatswitch( m_switch2458_g40230 , m_Off2458_g40230 , m_Global2458_g40230 , m_Local2458_g40230 );
			float _WIND_STRENGHT2400_g40230 = localWind_Globalfloatswitch2458_g40230;
			int m_switch2468_g40230 = (int)WIND_MODE2462_g40230;
			float m_Off2468_g40230 = 1.0;
			float m_Global2468_g40230 = _Global_Wind_Main_RandomOffset;
			float m_Local2468_g40230 = _LocalRandomWindOffset;
			float localWind_Globalfloatswitch2468_g40230 = Wind_Globalfloatswitch( m_switch2468_g40230 , m_Off2468_g40230 , m_Global2468_g40230 , m_Local2468_g40230 );
			float4 transform3073_g40230 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float2 appendResult2307_g40230 = (float2(transform3073_g40230.x , transform3073_g40230.z));
			float dotResult2341_g40230 = dot( appendResult2307_g40230 , float2( 12.9898,78.233 ) );
			float lerpResult2238_g40230 = lerp( 0.8 , ( ( localWind_Globalfloatswitch2468_g40230 / 2.0 ) + 0.9 ) , frac( ( sin( dotResult2341_g40230 ) * 43758.55 ) ));
			float _WIND_RANDOM_OFFSET2244_g40230 = ( _Time.x * lerpResult2238_g40230 );
			float _WIND_TUBULENCE_RANDOM2274_g40230 = ( sin( ( ( _WIND_RANDOM_OFFSET2244_g40230 * 40.0 ) - ( VERTEX_POSITION_MATRIX2352_g40230.z / 15.0 ) ) ) * 0.5 );
			int m_switch2312_g40230 = (int)WIND_MODE2462_g40230;
			float m_Off2312_g40230 = 1.0;
			float m_Global2312_g40230 = _Global_Wind_Main_Pulse;
			float m_Local2312_g40230 = _LocalWindPulse;
			float localWind_Globalfloatswitch2312_g40230 = Wind_Globalfloatswitch( m_switch2312_g40230 , m_Off2312_g40230 , m_Global2312_g40230 , m_Local2312_g40230 );
			float _WIND_PULSE2421_g40230 = localWind_Globalfloatswitch2312_g40230;
			float FUNC_Angle2470_g40230 = ( _WIND_STRENGHT2400_g40230 * ( 1.0 + sin( ( ( ( ( _WIND_RANDOM_OFFSET2244_g40230 * 2.0 ) + _WIND_TUBULENCE_RANDOM2274_g40230 ) - ( VERTEX_POSITION_MATRIX2352_g40230.z / 50.0 ) ) - ( v.color.r / 20.0 ) ) ) ) * sqrt( v.color.r ) * _WIND_PULSE2421_g40230 );
			float FUNC_Angle_SinA2424_g40230 = sin( FUNC_Angle2470_g40230 );
			float FUNC_Angle_CosA2362_g40230 = cos( FUNC_Angle2470_g40230 );
			int m_switch2456_g40230 = (int)WIND_MODE2462_g40230;
			float m_Off2456_g40230 = 1.0;
			float m_Global2456_g40230 = _Global_Wind_Main_Direction;
			float m_Local2456_g40230 = _LocalWindDirection;
			float localWind_Globalfloatswitch2456_g40230 = Wind_Globalfloatswitch( m_switch2456_g40230 , m_Off2456_g40230 , m_Global2456_g40230 , m_Local2456_g40230 );
			float _WindDirection2249_g40230 = localWind_Globalfloatswitch2456_g40230;
			float2 localDirectionalEquation2249_g40230 = DirectionalEquation( _WindDirection2249_g40230 );
			float2 break2469_g40230 = localDirectionalEquation2249_g40230;
			float _WIND_DIRECTION_X2418_g40230 = break2469_g40230.x;
			float lerpResult2258_g40230 = lerp( break2265_g40230.x , ( ( break2265_g40230.y * FUNC_Angle_SinA2424_g40230 ) + ( break2265_g40230.x * FUNC_Angle_CosA2362_g40230 ) ) , _WIND_DIRECTION_X2418_g40230);
			float3 break2340_g40230 = VERTEX_POSITION_MATRIX2352_g40230;
			float3 break2233_g40230 = VERTEX_POSITION_MATRIX2352_g40230;
			float _WIND_DIRECTION_Y2416_g40230 = break2469_g40230.y;
			float lerpResult2275_g40230 = lerp( break2233_g40230.z , ( ( break2233_g40230.y * FUNC_Angle_SinA2424_g40230 ) + ( break2233_g40230.z * FUNC_Angle_CosA2362_g40230 ) ) , _WIND_DIRECTION_Y2416_g40230);
			float3 appendResult2235_g40230 = (float3(lerpResult2258_g40230 , ( ( break2340_g40230.y * FUNC_Angle_CosA2362_g40230 ) - ( break2340_g40230.z * FUNC_Angle_SinA2424_g40230 ) ) , lerpResult2275_g40230));
			float3 VERTEX_POSITION2282_g40230 = ( mul( unity_WorldToObject, float4( appendResult2235_g40230 , 0.0 ) ).xyz - ase_vertex3Pos );
			float3 break2518_g40230 = VERTEX_POSITION2282_g40230;
			half FUNC_SinFunction2336_g40230 = sin( ( ( _WIND_RANDOM_OFFSET2244_g40230 * 200.0 * ( 0.2 + v.color.g ) ) + ( v.color.g * 10.0 ) + _WIND_TUBULENCE_RANDOM2274_g40230 + ( VERTEX_POSITION_MATRIX2352_g40230.z / 2.0 ) ) );
			int m_switch2326_g40230 = (int)WIND_MODE2462_g40230;
			float m_Off2326_g40230 = 1.0;
			float m_Global2326_g40230 = ( _GlobalTurbulenceInfluence * _Global_Wind_Main_Turbulence );
			float m_Local2326_g40230 = _LocalWindTurbulence;
			float localWind_Globalfloatswitch2326_g40230 = Wind_Globalfloatswitch( m_switch2326_g40230 , m_Off2326_g40230 , m_Global2326_g40230 , m_Local2326_g40230 );
			float _WIND_TUBULENCE2442_g40230 = localWind_Globalfloatswitch2326_g40230;
			float3 appendResult2480_g40230 = (float3(break2518_g40230.x , ( break2518_g40230.y + ( FUNC_SinFunction2336_g40230 * v.color.b * ( FUNC_Angle2470_g40230 + ( _WIND_STRENGHT2400_g40230 / 200.0 ) ) * _WIND_TUBULENCE2442_g40230 ) ) , break2518_g40230.z));
			float3 VERTEX_LEAF2396_g40230 = appendResult2480_g40230;
			float3 m_Leaf2439_g40230 = VERTEX_LEAF2396_g40230;
			float3 VERTEX_PALM2310_g40230 = ( ( FUNC_SinFunction2336_g40230 * v.color.b * ( FUNC_Angle2470_g40230 + ( _WIND_STRENGHT2400_g40230 / 200.0 ) ) * _WIND_TUBULENCE2442_g40230 ) + VERTEX_POSITION2282_g40230 );
			float3 m_Palm2439_g40230 = VERTEX_PALM2310_g40230;
			float3 break2486_g40230 = VERTEX_POSITION2282_g40230;
			float temp_output_2514_0_g40230 = ( FUNC_SinFunction2336_g40230 * v.color.b * ( FUNC_Angle2470_g40230 + ( _WIND_STRENGHT2400_g40230 / 200.0 ) ) );
			float lerpResult2482_g40230 = lerp( 0.0 , temp_output_2514_0_g40230 , _WIND_DIRECTION_X2418_g40230);
			float lerpResult2484_g40230 = lerp( 0.0 , temp_output_2514_0_g40230 , _WIND_DIRECTION_Y2416_g40230);
			float3 appendResult2489_g40230 = (float3(( break2486_g40230.x + lerpResult2482_g40230 ) , break2486_g40230.y , ( break2486_g40230.z + lerpResult2484_g40230 )));
			float3 VERTEX_GRASS2242_g40230 = appendResult2489_g40230;
			float3 m_Grass2439_g40230 = VERTEX_GRASS2242_g40230;
			float3 m_Simple2439_g40230 = VERTEX_POSITION2282_g40230;
			float clampResult2884_g40230 = clamp( ( _WIND_STRENGHT2400_g40230 - 0.95 ) , 0.0 , 1.0 );
			float3 break2708_g40230 = VERTEX_POSITION2282_g40230;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 break2718_g40230 = ase_worldPos;
			float temp_output_2690_0_g40230 = ( _WIND_RANDOM_OFFSET2244_g40230 * 25.0 );
			float clampResult2691_g40230 = clamp( 25.0 , 0.2 , 0.25 );
			float2 appendResult2694_g40230 = (float2(temp_output_2690_0_g40230 , ( temp_output_2690_0_g40230 / clampResult2691_g40230 )));
			float3 appendResult2706_g40230 = (float3(break2708_g40230.x , ( break2708_g40230.y + cos( ( ( ( break2718_g40230.x + break2718_g40230.y + break2718_g40230.z ) * 2.0 ) + appendResult2694_g40230 + FUNC_Angle2470_g40230 + _WIND_TUBULENCE2442_g40230 ) ) ).x , break2708_g40230.z));
			float3 temp_output_2613_0_g40230 = ( clampResult2884_g40230 * appendResult2706_g40230 );
			float3 ase_vertexNormal = v.normal.xyz;
			float4 ase_vertexTangent = v.tangent;
			float3 VERTEX_IVY997_g40230 = ( ( ( cos( temp_output_2613_0_g40230 ) + ( -0.3193 * UNITY_PI ) ) * ase_vertexNormal * 0.2 * ( FUNC_SinFunction2336_g40230 * v.color.b ) ) + ( sin( temp_output_2613_0_g40230 ) * cross( ase_vertexNormal , ase_vertexTangent.xyz ) * 0.2 ) );
			float3 m_Ivy2439_g40230 = VERTEX_IVY997_g40230;
			float3 localWind_Typefloat3switch2439_g40230 = Wind_Typefloat3switch2439_g40230( m_switch2439_g40230 , m_Leaf2439_g40230 , m_Palm2439_g40230 , m_Grass2439_g40230 , m_Simple2439_g40230 , m_Ivy2439_g40230 );
			float3 m_Global2453_g40230 = localWind_Typefloat3switch2439_g40230;
			float3 m_Local2453_g40230 = localWind_Typefloat3switch2439_g40230;
			float3 localWind_Globalfloat3switch2453_g40230 = Wind_Globalfloat3switch( m_switch2453_g40230 , m_Off2453_g40230 , m_Global2453_g40230 , m_Local2453_g40230 );
			float3 m_Off3050_g40230 = localWind_Globalfloat3switch2453_g40230;
			float temp_output_3048_0_g40230 = saturate( pow( ( distance( _WorldSpaceCameraPos , ase_worldPos ) / _Global_Wind_Main_Fade_Bias ) , 5.0 ) );
			float3 m_ActiveFadeOut3050_g40230 = ( localWind_Globalfloat3switch2453_g40230 * ( 1.0 - temp_output_3048_0_g40230 ) );
			float3 m_ActiveFadeIn3050_g40230 = ( localWind_Globalfloat3switch2453_g40230 * temp_output_3048_0_g40230 );
			float3 localWind_Fadefloat3switch3050_g40230 = Wind_Fadefloat3switch3050_g40230( m_switch3050_g40230 , m_Off3050_g40230 , m_ActiveFadeOut3050_g40230 , m_ActiveFadeIn3050_g40230 );
			float3 temp_output_1234_0_g45103 = localWind_Fadefloat3switch3050_g40230;
			v.vertex.xyz += temp_output_1234_0_g45103;
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustom(SurfaceOutputStandardCustom s, half3 viewDir, UnityGI gi )
		{
			#if !defined(DIRECTIONAL)
			float3 lightAtten = gi.light.color;
			#else
			float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, _TransShadow );
			#endif
			half3 lightDir = gi.light.dir + s.Normal * _TransNormalDistortion;
			half transVdotL = pow( saturate( dot( viewDir, -lightDir ) ), _TransScattering );
			half3 translucency = lightAtten * (transVdotL * _TransDirect + gi.indirect.diffuse * _TransAmbient) * s.Translucency;
			half4 c = half4( s.Albedo * translucency * _Translucency, 0 );

			half3 transmission = max(0 , -dot(s.Normal, gi.light.dir)) * gi.light.color * s.Transmission;
			half4 d = half4(s.Albedo * transmission , 0);

			SurfaceOutputStandard r;
			r.Albedo = s.Albedo;
			r.Normal = s.Normal;
			r.Emission = s.Emission;
			r.Metallic = s.Metallic;
			r.Smoothness = s.Smoothness;
			r.Occlusion = s.Occlusion;
			r.Alpha = s.Alpha;
			return LightingStandard (r, viewDir, gi) + c + d;
		}

		inline void LightingStandardCustom_GI(SurfaceOutputStandardCustom s, UnityGIInput data, inout UnityGI gi )
		{
			#if defined(UNITY_PASS_DEFERRED) && UNITY_ENABLE_REFLECTION_BUFFERS
				gi = UnityGlobalIllumination(data, s.Occlusion, s.Normal);
			#else
				UNITY_GLOSSY_ENV_FROM_SURFACE( g, s, data );
				gi = UnityGlobalIllumination( data, s.Occlusion, s.Normal, g );
			#endif
		}

		void surf( Input i , inout SurfaceOutputStandardCustom o )
		{
			float temp_output_50_0_g45109 = _NormalMode;
			float m_switch37_g45109 = temp_output_50_0_g45109;
			float2 appendResult168_g45103 = (float2(_TilingX , _TilingY));
			float2 appendResult167_g45103 = (float2(_OffsetX , _OffsetY));
			float2 uv_TexCoord2_g45129 = i.uv_texcoord * appendResult168_g45103 + appendResult167_g45103;
			float2 OUT_UV213_g45103 = uv_TexCoord2_g45129;
			float2 UV40_g45115 = OUT_UV213_g45103;
			float4 NORMAL_RGB1382_g45103 = SAMPLE_TEXTURE2D( _BumpMap, sampler_trilinear_repeat, UV40_g45115 );
			float4 temp_output_1_0_g45123 = NORMAL_RGB1382_g45103;
			float temp_output_8_0_g45123 = _NormalStrength;
			float3 temp_output_1519_59_g45103 = UnpackScaleNormal( temp_output_1_0_g45123, temp_output_8_0_g45123 );
			float3 NORMAL_IN42_g45109 = temp_output_1519_59_g45103;
			float3 m_Default37_g45109 = NORMAL_IN42_g45109;
			float3 m_Flip37_g45109 = ( NORMAL_IN42_g45109 * i.ASEVFace );
			float3 break33_g45109 = NORMAL_IN42_g45109;
			float3 appendResult41_g45109 = (float3(break33_g45109.x , break33_g45109.y , ( break33_g45109.z * i.ASEVFace )));
			float3 m_Mirror37_g45109 = appendResult41_g45109;
			float3 local_NormalModefloat3switch37_g45109 = _NormalModefloat3switch( m_switch37_g45109 , m_Default37_g45109 , m_Flip37_g45109 , m_Mirror37_g45109 );
			float3 temp_output_1610_30_g45103 = local_NormalModefloat3switch37_g45109;
			o.Normal = temp_output_1610_30_g45103;
			float m_switch364_g45130 = _ColorShift_Mode;
			float4 tex2DNode63_g45115 = SAMPLE_TEXTURE2D( _MainTex, sampler_trilinear_repeat, UV40_g45115 );
			float4 ALBEDO_RGBA1381_g45103 = tex2DNode63_g45115;
			float3 temp_output_3_0_g45103 = ( (_Color).rgb * (ALBEDO_RGBA1381_g45103).rgb * _Brightness );
			float3 temp_output_134_0_g45130 = temp_output_3_0_g45103;
			float4 m_Off364_g45130 = float4( temp_output_134_0_g45130 , 0.0 );
			float m_switch313_g45130 = _ColorShift_MaskMode;
			float MODE176_g45130 = _ColorShift_Mode;
			float m_switch168_g45130 = MODE176_g45130;
			float m_Off168_g45130 = 0.0;
			float m_ObjectSpace168_g45130 = ( _ColorShift_NoiseScale / 3 );
			float3 ase_worldPos = i.worldPos;
			float3 p1_g45131 = ( ase_worldPos * _ColorShift_WorldSpaceNoiseShift );
			float localSimpleNoise3D1_g45131 = SimpleNoise3D( p1_g45131 );
			float4 ase_vertex4Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 transform374_g45130 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float m_WorldSpace168_g45130 = ( ( localSimpleNoise3D1_g45131 / _ColorShift_NoiseScale ) - ( ( (transform374_g45130).w - _ColorShift_WorldSpaceOffset ) / _ColorShift_WorldSpaceDistance ) );
			float m_VertexColor168_g45130 = ( i.vertexColor.g - 0.5 );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			ase_vertexNormal = normalize( ase_vertexNormal );
			float m_VertexNormal168_g45130 = ( ase_vertexNormal.y - 0.5 );
			float localColorShift_Modefloatswitch168_g45130 = ColorShift_Modefloatswitch168_g45130( m_switch168_g45130 , m_Off168_g45130 , m_ObjectSpace168_g45130 , m_WorldSpace168_g45130 , m_VertexColor168_g45130 , m_VertexNormal168_g45130 );
			float temp_output_112_0_g45130 = sin( ( _ColorShift_NoiseScale * UNITY_PI ) );
			float3 ALBEDO_IN136_g45130 = temp_output_134_0_g45130;
			float2 appendResult120_g45130 = (float2(( (0.3 + (( 1.0 - temp_output_112_0_g45130 ) - 0.0) * (1.0 - 0.3) / (1.0 - 0.0)) * float4( ALBEDO_IN136_g45130 , 0.0 ).x ) , 0.0));
			float2 RGB146_g45130 = appendResult120_g45130;
			float3 hsvTorgb122_g45130 = RGBToHSV( float3( RGB146_g45130 ,  0.0 ) );
			float VALUE219_g45130 = temp_output_112_0_g45130;
			float3 hsvTorgb126_g45130 = HSVToRGB( float3(( ( saturate( localColorShift_Modefloatswitch168_g45130 ) * _ColorShift_ShiftVariation ) + _ColorShift_ShiftVariationRGB + hsvTorgb122_g45130 ).x,( _ColorShift_ShiftSaturation * hsvTorgb122_g45130.y ),( hsvTorgb122_g45130.z + ( VALUE219_g45130 / 40 ) )) );
			float4 m_Off313_g45130 = float4( hsvTorgb126_g45130 , 0.0 );
			float2 uv_ColorShift_MaskMap = i.uv_texcoord * _ColorShift_MaskMap_ST.xy + _ColorShift_MaskMap_ST.zw;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 transform376_g45130 = mul(unity_ObjectToWorld,float4( ase_vertex3Pos , 0.0 ));
			float4 temp_output_337_0_g45130 = saturate( ( 1.0 - ( ( SAMPLE_TEXTURE2D( _ColorShift_MaskMap, sampler_trilinear_repeat, uv_ColorShift_MaskMap ) * transform376_g45130 ) / max( _ColorShift_MaskFuzziness , 1E-05 ) ) ) );
			float3 lerpResult314_g45130 = lerp( hsvTorgb126_g45130 , ALBEDO_IN136_g45130 , temp_output_337_0_g45130.rgb);
			float4 m_Active313_g45130 = float4( lerpResult314_g45130 , 0.0 );
			float3 lerpResult311_g45130 = lerp( ALBEDO_IN136_g45130 , hsvTorgb126_g45130 , temp_output_337_0_g45130.rgb);
			float4 m_ActiveInverted313_g45130 = float4( lerpResult311_g45130 , 0.0 );
			float4 localColorShift_Maskfloat4switch313_g45130 = ColorShift_Maskfloat4switch313_g45130( m_switch313_g45130 , m_Off313_g45130 , m_Active313_g45130 , m_ActiveInverted313_g45130 );
			float4 lerpResult297_g45130 = lerp( float4( temp_output_134_0_g45130 , 0.0 ) , localColorShift_Maskfloat4switch313_g45130 , _ColorShift_ShiftInfluence);
			float4 m_ObjectSpace364_g45130 = lerpResult297_g45130;
			float4 m_WorldSpace364_g45130 = lerpResult297_g45130;
			float4 m_VertexColor364_g45130 = lerpResult297_g45130;
			float4 m_VertexNormal364_g45130 = lerpResult297_g45130;
			float4 localColorShift_Modefloat4switch364_g45130 = ColorShift_Modefloat4switch364_g45130( m_switch364_g45130 , m_Off364_g45130 , m_ObjectSpace364_g45130 , m_WorldSpace364_g45130 , m_VertexColor364_g45130 , m_VertexNormal364_g45130 );
			o.Albedo = localColorShift_Modefloat4switch364_g45130.xyz;
			float4 MASK_B1377_g45103 = SAMPLE_TEXTURE2D( _MetallicGlossMap, sampler_trilinear_repeat, UV40_g45115 );
			float temp_output_1_0_g45125 = _MetallicStrength;
			o.Metallic = ( MASK_B1377_g45103.r * temp_output_1_0_g45125 );
			float temp_output_223_0_g45121 = _SmoothnessSource;
			float m_switch215_g45121 = temp_output_223_0_g45121;
			float4 MASK_G158_g45103 = SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_trilinear_repeat, UV40_g45115 );
			float4 temp_cast_16 = (_SmoothnessMin).xxxx;
			float4 temp_cast_17 = (_SmoothnessMax).xxxx;
			float4 temp_output_216_0_g45121 = (temp_cast_16 + (MASK_G158_g45103 - float4( 0,0,0,0 )) * (temp_cast_17 - temp_cast_16) / (float4( 1,1,1,1 ) - float4( 0,0,0,0 )));
			float4 m_Smoothness215_g45121 = temp_output_216_0_g45121;
			float4 temp_cast_18 = (_SmoothnessMin).xxxx;
			float4 temp_cast_19 = (_SmoothnessMax).xxxx;
			float4 temp_output_214_0_g45121 = ( 1.0 - temp_output_216_0_g45121 );
			float4 m_Roughness215_g45121 = temp_output_214_0_g45121;
			float4 temp_cast_20 = (_SmoothnessMin).xxxx;
			float4 temp_cast_21 = (_SmoothnessMax).xxxx;
			float3 NORMAL_OUT1491_g45103 = temp_output_1610_30_g45103;
			float3 temp_output_4_0_g45121 = normalize( (WorldNormalVector( i , NORMAL_OUT1491_g45103 )) );
			float3 temp_output_178_0_g45121 = ddx( temp_output_4_0_g45121 );
			float dotResult195_g45121 = dot( temp_output_178_0_g45121 , temp_output_178_0_g45121 );
			float3 temp_output_175_0_g45121 = ddy( temp_output_4_0_g45121 );
			float dotResult201_g45121 = dot( temp_output_175_0_g45121 , temp_output_175_0_g45121 );
			float ALBEDO_R172_g45103 = tex2DNode63_g45115.r;
			float4 temp_cast_22 = (ALBEDO_R172_g45103).xxxx;
			float4 m_Geometric215_g45121 = ( sqrt( saturate( ( temp_output_216_0_g45121 + ( ( dotResult195_g45121 + dotResult201_g45121 ) * 2.0 ) ) ) ) * ( 1.0 - temp_cast_22 ) );
			float4 localSmoothnessTypefloat4switch215_g45121 = SmoothnessTypefloat4switch215_g45121( m_switch215_g45121 , m_Smoothness215_g45121 , m_Roughness215_g45121 , m_Geometric215_g45121 );
			float4 temp_output_1635_33_g45103 = localSmoothnessTypefloat4switch215_g45121;
			float4 PBR_Occlusion1712_g45103 = SAMPLE_TEXTURE2D( _OcclusionMap, sampler_trilinear_repeat, UV40_g45115 );
			float temp_output_16_0_g45107 = _OcclusionStrengthAO;
			float temp_output_65_0_g45107 = ( 1.0 - temp_output_16_0_g45107 );
			float3 appendResult69_g45107 = (float3(temp_output_65_0_g45107 , temp_output_65_0_g45107 , temp_output_65_0_g45107));
			float4 color77_g45107 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float4 temp_cast_25 = (i.vertexColor.a).xxxx;
			float4 lerpResult75_g45107 = lerp( color77_g45107 , temp_cast_25 , temp_output_16_0_g45107);
			float4 lerpResult83_g45107 = lerp( float4( ( ( ( (PBR_Occlusion1712_g45103).xyz - float3( 0.5,0.5,0.5 ) ) * temp_output_16_0_g45107 ) + appendResult69_g45107 ) , 0.0 ) , lerpResult75_g45107 , _OcclusionSource);
			float4 Occlusion1628_g45103 = saturate( lerpResult83_g45107 );
			o.Smoothness = ( temp_output_1635_33_g45103 * Occlusion1628_g45103 ).x;
			o.Occlusion = saturate( lerpResult83_g45107 ).r;
			float m_switch103_g45113 = _TranslucencySourceFoward;
			float4 color71_g45113 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float4 temp_output_113_0_g45113 = saturate( ( SAMPLE_TEXTURE2D( _TranslucencyMap, sampler_trilinear_repeat, OUT_UV213_g45103 ) / max( _TranslucencyThicknessFeather , 1E-05 ) ) );
			float4 lerpResult34_g45113 = lerp( color71_g45113 , temp_output_113_0_g45113 , _TranslucencyThickness);
			float4 m_Texture103_g45113 = lerpResult34_g45113;
			float temp_output_69_0_g45113 = ( 0.0 - 1.0 );
			float temp_output_22_0_g45113 = ( temp_output_113_0_g45113.r - 1.0 );
			float lerpResult66_g45113 = lerp( ( temp_output_69_0_g45113 / temp_output_22_0_g45113 ) , ( temp_output_22_0_g45113 / temp_output_69_0_g45113 ) , ( 0.7 + _TranslucencyThickness ));
			float4 temp_cast_30 = (saturate( lerpResult66_g45113 )).xxxx;
			float4 m_TextureInverted103_g45113 = temp_cast_30;
			float lerpResult30_g45113 = lerp( 0.0 , ( 5.0 - i.uv4_texcoord4.x ) , _TranslucencyThickness);
			float4 temp_cast_31 = (lerpResult30_g45113).xxxx;
			float4 m_Baked103_g45113 = temp_cast_31;
			float4 localfloat4switch103_g45113 = float4switch103_g45113( m_switch103_g45113 , m_Texture103_g45113 , m_TextureInverted103_g45113 , m_Baked103_g45113 );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 temp_output_90_0_g45113 = saturate( ( ase_lightColor.rgb * ase_lightColor.a ) );
			float4 lerpResult122_g45113 = lerp( float4( 0,0,0,0 ) , ( ( _TransmissionTint * _TransmissionTint.a * localfloat4switch103_g45113 ) * float4( temp_output_90_0_g45113 , 0.0 ) ) , _EnableTranslucency);
			o.Transmission = lerpResult122_g45113.rgb;
			float4 lerpResult123_g45113 = lerp( float4( 0,0,0,0 ) , ( ( _TranslucencyTint * _TranslucencyTint.a * localfloat4switch103_g45113 ) * float4( temp_output_90_0_g45113 , 0.0 ) ) , _EnableTranslucency);
			o.Translucency = lerpResult123_g45113.rgb;
			float ALBEDO_A926_g45103 = tex2DNode63_g45115.a;
			float Albedo_Alpha52_g45110 = ALBEDO_A926_g45103;
			float AlphaCutoffBias33_g45110 = _AlphaCutoffBias;
			clip( Albedo_Alpha52_g45110 - ( 1.0 - AlphaCutoffBias33_g45110 ));
			float temp_output_10_0_g45110 = saturate( ( ( Albedo_Alpha52_g45110 / max( fwidth( Albedo_Alpha52_g45110 ) , 0.0001 ) ) + 0.5 ) );
			o.Alpha = temp_output_10_0_g45110;
			float3 normalizeResult38_g45110 = normalize( cross( ddx( ase_worldPos ) , ddy( ase_worldPos ) ) );
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult35_g45110 = dot( normalizeResult38_g45110 , ase_worldViewDir );
			float temp_output_32_0_g45110 = ( 1.0 - abs( dotResult35_g45110 ) );
			float lerpResult67_g45110 = lerp( 1.0 , ( 1.0 - ( temp_output_32_0_g45110 * temp_output_32_0_g45110 ) ) , _GlancingClipMode);
			clip( lerpResult67_g45110 - _MaskClipValue );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "DE_ShaderGUI"
}
/*ASEBEGIN
Version=18934
79;54;1654;856;6204.654;4736.413;2.428112;True;True
Node;AmplifyShaderEditor.CommentaryNode;2820;-3963.522,-3836.988;Inherit;False;440.5028;195.4201;DEBUG SETTINGS ;4;2758;2760;2786;202;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2819;-3959.899,-3965.561;Inherit;False;440;119;GLOBAL SETTINGS ;2;3058;203;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;3052;-3966.216,-3212.057;Inherit;False;311.6074;112.9272;DESF Common ASE Compile Shaders;1;3053;;0,0.2605708,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;3057;-4693.905,-3631.444;Inherit;False;DESF Module Wind;127;;40230;b135a554f7e4d0b41bba02c61b34ae74;10,938,0,2881,0,2371,1,2454,1,2433,1,2434,1,2432,1,2457,1,2878,0,2752,0;0;1;FLOAT3;2190
Node;AmplifyShaderEditor.FunctionNode;3053;-3959.265,-3172.442;Inherit;False;DESF Utility ASE Compile Shaders;-1;;40307;b85b01c42ba8a8a448b731b68fc0dbd9;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;202;-3944.843,-3795.885;Inherit;False;Constant;_MaskClipValue;Mask Clip Value;64;1;[HideInInspector];Create;True;1;;0;0;True;0;False;0.5;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2786;-3944.761,-3720.807;Inherit;False;Property;_AlphatoCoverage;Alpha to Coverage;2;1;[Enum];Create;True;1;;1;Option1;0;1;Off,0,On,1;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;203;-3940.866,-3924.171;Inherit;False;Property;_CullMode;Cull Mode;3;2;[Header];[Enum];Create;True;1;GLOBAL SETTINGS;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;2760;-3745.084,-3795.491;Inherit;False;Property;_ZWriteMode;ZWrite Mode;0;2;[Header];[Enum];Create;False;1;DEBUG SETTINGS;0;1;Off,0,On,1;True;0;False;1;1;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;2758;-3747.148,-3722.434;Inherit;False;Property;_ColorMask;Color Mask Mode;1;1;[Enum];Create;False;1;;0;1;None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15;True;0;False;15;15;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;3058;-3775.491,-3929.418;Half;False;Property;_EmissionFlags;Global Illumination Emissive;4;0;Create;False;0;0;0;True;1;EmissionFlags;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;3129;-4462.972,-3630.823;Inherit;False;DESF Core Cutout;5;;45103;e0cdd7758f4404849b063afff4596424;20,1217,0,442,0,1509,1,1749,1,1556,1,1557,1,1333,0,1618,0,1806,0,1663,0,1650,0,1647,0,96,2,1569,0,1368,0,1415,0,830,0,1564,0,1565,0,1399,0;1;1234;FLOAT3;0,0,0;False;12;FLOAT4;38;FLOAT3;35;FLOAT;37;FLOAT4;33;COLOR;34;FLOAT;46;FLOAT;814;FLOAT;1660;COLOR;656;COLOR;657;FLOAT4;655;FLOAT3;1235
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;1319;-3966.423,-3627.329;Float;False;True;-1;3;DE_ShaderGUI;200;0;Standard;DEC/Cutout Wind/Cutout Wind Translucency;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;True;True;True;Back;0;True;2760;3;False;2757;False;0;False;-1;0;False;-1;False;3;Custom;0;True;True;-10;True;Opaque;;Geometry;ForwardOnly;18;all;True;True;True;True;0;True;2758;False;0;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;200;;-1;120;-1;-1;1;NatureRendererInstancing=True;False;0;0;True;203;-1;0;True;202;5;Pragma;multi_compile_instancing;False;;Custom;Pragma;instancing_options procedural:SetupNatureRenderer forwardadd;False;;Custom;Pragma;multi_compile GPU_FRUSTUM_ON __;False;8ccd508f733f5f0418220eaf14ecdf81;Custom;Include;Nature Renderer.cginc;False;5d792e02fd6741e4cb63087f97979470;Custom;Pragma;multi_compile_local _ NATURE_RENDERER;False;;Custom;0;0;False;0.1;False;-1;0;True;2786;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3129;1234;3057;2190
WireConnection;1319;0;3129;38
WireConnection;1319;1;3129;35
WireConnection;1319;3;3129;37
WireConnection;1319;4;3129;33
WireConnection;1319;5;3129;34
WireConnection;1319;6;3129;656
WireConnection;1319;7;3129;657
WireConnection;1319;9;3129;46
WireConnection;1319;10;3129;814
WireConnection;1319;11;3129;1235
ASEEND*/
//CHKSM=619216C39197BA9CCF9C2949D5BF01DD2D87FCC8