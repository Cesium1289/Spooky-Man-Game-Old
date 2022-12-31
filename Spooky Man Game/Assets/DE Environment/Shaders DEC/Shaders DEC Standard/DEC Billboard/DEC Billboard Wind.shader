// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DEC/Billboard/Billboard Wind"
{
	Properties
	{
		[Header(DEBUG SETTINGS)][Enum(Off,0,On,1)]_ZWriteMode("ZWrite Mode", Int) = 1
		[Enum(None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15)]_ColorMask("Color Mask Mode", Int) = 15
		[Enum(Off,0,On,1)]_AlphatoCoverage("Alpha to Coverage", Float) = 0
		[Header(GLOBAL SETTINGS)][Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Int) = 0
		[EmissionFlags]_EmissionFlags("Global Illumination Emissive", Float) = 0
		[DE_DrawerFloatEnum(Default _Flip _Mirror)]_NormalMode("Normal Mode", Float) = 0
		[DE_DrawerToggleNoKeyword]_GlancingClipMode1("Enable Clip Glancing Angle", Float) = 1
		[Header(MAP MAIN TEXTURE)]_Color("Tint", Color) = (1,1,1,1)
		[DE_DrawerTextureSingleLine]_MainTex("Albedo Map", 2D) = "white" {}
		_Brightness("Brightness", Range( 0 , 2)) = 1.5
		_AlphaCutoffBias("Alpha Cutoff Bias", Range( 0 , 1)) = 0.5
		[HideInInspector]_MaskClipValue("Mask Clip Value", Float) = 0.5
		_TilingX("Tiling X", Float) = 1
		_TilingY("Tiling Y", Float) = 1
		_OffsetX("Offset X", Float) = 0
		_OffsetY("Offset Y", Float) = 0
		[Normal][DE_DrawerTextureSingleLine]_BumpMap("Normal Map", 2D) = "bump" {}
		_NormalStrength("Normal Strength", Float) = 1
		_MetallicStrength("Metallic Strength", Range( 0 , 1)) = 0
		[DE_DrawerToggleNoKeyword]_OcclusionSource("Occlusion is Baked", Float) = 1
		_OcclusionStrengthAO("Occlusion Strength", Range( 0 , 1)) = 0
		[DE_DrawerSliderRemap(_SmoothnessMin, _SmoothnessMax,0, 1)]_Smoothness("Smoothness", Vector) = (0,0,0,0)
		[HideInInspector]_SmoothnessMin("Smoothness Min", Range( 0 , 1)) = 0
		[HideInInspector]_SmoothnessMax("Smoothness Max", Range( 0 , 1)) = 0
		[Header(WIND)][DE_DrawerFloatEnum(Off _Global _Local)]_WindMode("Enable Wind Mode", Float) = 0
		[Header(WIND MODE GLOBAL)]_GlobalWindInfluenceBillboard("Main", Float) = 1
		[Header(WIND MODE LOCAL)]_LocalWindStrength("Main", Float) = 1
		_LocalWindPulse("Pulse Frequency", Float) = 0.1
		_LocalWindDirection("Direction", Range( 0 , 360)) = 0
		_LocalRandomWindOffset("Random Offset", Float) = 0.2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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
		#include "UnityCG.cginc"
		#pragma target 3.0
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

		#pragma surface surf Standard keepalpha addshadow fullforwardshadows dithercrossfade vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			half ASEVFace : VFACE;
			float4 vertexColor : COLOR;
		};

		uniform int _CullMode;
		uniform int _ColorMask;
		uniform float _AlphatoCoverage;
		uniform int _ZWriteMode;
		uniform float4 _Smoothness;
		uniform float _SmoothnessMin;
		uniform float _SmoothnessMax;
		uniform half _EmissionFlags;
		uniform int _Global_Wind_Main_Fade_Enabled;
		uniform half _WindMode;
		uniform int _Global_Wind_Billboard_Enabled;
		uniform float _GlobalWindInfluenceBillboard;
		uniform float _Global_Wind_Billboard_Intensity;
		uniform float _Global_Wind_Main_Intensity;
		uniform float _LocalWindStrength;
		uniform float _Global_Wind_Main_RandomOffset;
		uniform float _LocalRandomWindOffset;
		uniform float _Global_Wind_Main_Pulse;
		uniform float _LocalWindPulse;
		uniform float _Global_Wind_Main_Direction;
		uniform float _LocalWindDirection;
		uniform float _Global_Wind_Main_Fade_Bias;
		uniform half _NormalMode;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
		uniform float _TilingX;
		uniform float _TilingY;
		uniform float _OffsetX;
		uniform float _OffsetY;
		SamplerState sampler_trilinear_repeat;
		uniform half _NormalStrength;
		uniform float4 _Color;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
		uniform half _Brightness;
		uniform half _MetallicStrength;
		uniform half _OcclusionStrengthAO;
		uniform float _OcclusionSource;
		uniform half _AlphaCutoffBias;
		uniform float _GlancingClipMode1;
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


		float3 float3switch2465_g3276( int m_switch, float3 m_Off, float3 m_On )
		{
			if(m_switch ==0)
				return m_Off;
			else if(m_switch ==1)
				return m_On;
			else
			return float3(0,0,0);
		}


		float3 Wind_Globalfloat3switch( int m_switch, float3 m_Off, float3 m_Global, float3 m_Local )
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


		float3 Wind_Fadefloat3switch3050_g3276( int m_switch, float3 m_Off, float3 m_ActiveFadeOut, float3 m_ActiveFadeIn )
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


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			int m_switch3050_g3276 = _Global_Wind_Main_Fade_Enabled;
			float m_switch2453_g3276 = _WindMode;
			float3 m_Off2453_g3276 = float3(0,0,0);
			float WIND_MODE2462_g3276 = _WindMode;
			int m_switch2328_g3276 = (int)WIND_MODE2462_g3276;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VERTEX_POSITION_MATRIX2352_g3276 = mul( unity_ObjectToWorld, float4( ase_vertex3Pos , 0.0 ) ).xyz;
			float3 m_Off2328_g3276 = VERTEX_POSITION_MATRIX2352_g3276;
			int m_switch2465_g3276 = _Global_Wind_Billboard_Enabled;
			float3 m_Off2465_g3276 = float3(0,0,0);
			float3 break2265_g3276 = VERTEX_POSITION_MATRIX2352_g3276;
			int m_switch2460_g3276 = (int)WIND_MODE2462_g3276;
			float m_Off2460_g3276 = 1.0;
			float m_Global2460_g3276 = ( ( _GlobalWindInfluenceBillboard * _Global_Wind_Billboard_Intensity ) * _Global_Wind_Main_Intensity );
			float m_Local2460_g3276 = _LocalWindStrength;
			float localWind_Globalfloatswitch2460_g3276 = Wind_Globalfloatswitch( m_switch2460_g3276 , m_Off2460_g3276 , m_Global2460_g3276 , m_Local2460_g3276 );
			float _WIND_STRENGHT2400_g3276 = localWind_Globalfloatswitch2460_g3276;
			int m_switch2468_g3276 = (int)WIND_MODE2462_g3276;
			float m_Off2468_g3276 = 1.0;
			float m_Global2468_g3276 = _Global_Wind_Main_RandomOffset;
			float m_Local2468_g3276 = _LocalRandomWindOffset;
			float localWind_Globalfloatswitch2468_g3276 = Wind_Globalfloatswitch( m_switch2468_g3276 , m_Off2468_g3276 , m_Global2468_g3276 , m_Local2468_g3276 );
			float4 transform3073_g3276 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float2 appendResult2307_g3276 = (float2(transform3073_g3276.x , transform3073_g3276.z));
			float dotResult2341_g3276 = dot( appendResult2307_g3276 , float2( 12.9898,78.233 ) );
			float lerpResult2238_g3276 = lerp( 0.8 , ( ( localWind_Globalfloatswitch2468_g3276 / 2.0 ) + 0.9 ) , frac( ( sin( dotResult2341_g3276 ) * 43758.55 ) ));
			float _WIND_RANDOM_OFFSET2244_g3276 = ( _Time.x * lerpResult2238_g3276 );
			float _WIND_TUBULENCE_RANDOM2274_g3276 = ( sin( ( ( _WIND_RANDOM_OFFSET2244_g3276 * 40.0 ) - ( VERTEX_POSITION_MATRIX2352_g3276.z / 15.0 ) ) ) * 0.5 );
			int m_switch2312_g3276 = (int)WIND_MODE2462_g3276;
			float m_Off2312_g3276 = 1.0;
			float m_Global2312_g3276 = _Global_Wind_Main_Pulse;
			float m_Local2312_g3276 = _LocalWindPulse;
			float localWind_Globalfloatswitch2312_g3276 = Wind_Globalfloatswitch( m_switch2312_g3276 , m_Off2312_g3276 , m_Global2312_g3276 , m_Local2312_g3276 );
			float _WIND_PULSE2421_g3276 = localWind_Globalfloatswitch2312_g3276;
			float FUNC_Angle2470_g3276 = ( _WIND_STRENGHT2400_g3276 * ( 1.0 + sin( ( ( ( ( _WIND_RANDOM_OFFSET2244_g3276 * 2.0 ) + _WIND_TUBULENCE_RANDOM2274_g3276 ) - ( VERTEX_POSITION_MATRIX2352_g3276.z / 50.0 ) ) - ( v.color.r / 20.0 ) ) ) ) * sqrt( v.color.r ) * _WIND_PULSE2421_g3276 );
			float FUNC_Angle_SinA2424_g3276 = sin( FUNC_Angle2470_g3276 );
			float FUNC_Angle_CosA2362_g3276 = cos( FUNC_Angle2470_g3276 );
			int m_switch2456_g3276 = (int)WIND_MODE2462_g3276;
			float m_Off2456_g3276 = 1.0;
			float m_Global2456_g3276 = _Global_Wind_Main_Direction;
			float m_Local2456_g3276 = _LocalWindDirection;
			float localWind_Globalfloatswitch2456_g3276 = Wind_Globalfloatswitch( m_switch2456_g3276 , m_Off2456_g3276 , m_Global2456_g3276 , m_Local2456_g3276 );
			float _WindDirection2249_g3276 = localWind_Globalfloatswitch2456_g3276;
			float2 localDirectionalEquation2249_g3276 = DirectionalEquation( _WindDirection2249_g3276 );
			float2 break2469_g3276 = localDirectionalEquation2249_g3276;
			float _WIND_DIRECTION_X2418_g3276 = break2469_g3276.x;
			float lerpResult2258_g3276 = lerp( break2265_g3276.x , ( ( break2265_g3276.y * FUNC_Angle_SinA2424_g3276 ) + ( break2265_g3276.x * FUNC_Angle_CosA2362_g3276 ) ) , _WIND_DIRECTION_X2418_g3276);
			float3 break2340_g3276 = VERTEX_POSITION_MATRIX2352_g3276;
			float3 break2233_g3276 = VERTEX_POSITION_MATRIX2352_g3276;
			float _WIND_DIRECTION_Y2416_g3276 = break2469_g3276.y;
			float lerpResult2275_g3276 = lerp( break2233_g3276.z , ( ( break2233_g3276.y * FUNC_Angle_SinA2424_g3276 ) + ( break2233_g3276.z * FUNC_Angle_CosA2362_g3276 ) ) , _WIND_DIRECTION_Y2416_g3276);
			float3 appendResult2235_g3276 = (float3(lerpResult2258_g3276 , ( ( break2340_g3276.y * FUNC_Angle_CosA2362_g3276 ) - ( break2340_g3276.z * FUNC_Angle_SinA2424_g3276 ) ) , lerpResult2275_g3276));
			float3 VERTEX_POSITION_Neg3006_g3276 = appendResult2235_g3276;
			float3 m_On2465_g3276 = ( VERTEX_POSITION_Neg3006_g3276 - VERTEX_POSITION_MATRIX2352_g3276 );
			float3 localfloat3switch2465_g3276 = float3switch2465_g3276( m_switch2465_g3276 , m_Off2465_g3276 , m_On2465_g3276 );
			float3 m_Global2328_g3276 = localfloat3switch2465_g3276;
			float3 VERTEX_POSITION2282_g3276 = ( mul( unity_WorldToObject, float4( appendResult2235_g3276 , 0.0 ) ).xyz - ase_vertex3Pos );
			float3 m_Local2328_g3276 = VERTEX_POSITION2282_g3276;
			float3 localWind_Globalfloat3switch2328_g3276 = Wind_Globalfloat3switch( m_switch2328_g3276 , m_Off2328_g3276 , m_Global2328_g3276 , m_Local2328_g3276 );
			float3 m_Global2453_g3276 = localWind_Globalfloat3switch2328_g3276;
			float3 m_Local2453_g3276 = localWind_Globalfloat3switch2328_g3276;
			float3 localWind_Globalfloat3switch2453_g3276 = Wind_Globalfloat3switch( m_switch2453_g3276 , m_Off2453_g3276 , m_Global2453_g3276 , m_Local2453_g3276 );
			float3 m_Off3050_g3276 = localWind_Globalfloat3switch2453_g3276;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float temp_output_3048_0_g3276 = saturate( pow( ( distance( _WorldSpaceCameraPos , ase_worldPos ) / _Global_Wind_Main_Fade_Bias ) , 5.0 ) );
			float3 m_ActiveFadeOut3050_g3276 = ( localWind_Globalfloat3switch2453_g3276 * ( 1.0 - temp_output_3048_0_g3276 ) );
			float3 m_ActiveFadeIn3050_g3276 = ( localWind_Globalfloat3switch2453_g3276 * temp_output_3048_0_g3276 );
			float3 localWind_Fadefloat3switch3050_g3276 = Wind_Fadefloat3switch3050_g3276( m_switch3050_g3276 , m_Off3050_g3276 , m_ActiveFadeOut3050_g3276 , m_ActiveFadeIn3050_g3276 );
			float3 temp_output_457_0_g3689 = localWind_Fadefloat3switch3050_g3276;
			v.vertex.xyz += temp_output_457_0_g3689;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float temp_output_50_0_g43281 = _NormalMode;
			float m_switch37_g43281 = temp_output_50_0_g43281;
			float2 appendResult128_g3689 = (float2(_TilingX , _TilingY));
			float2 appendResult125_g3689 = (float2(_OffsetX , _OffsetY));
			float2 uv_TexCoord2_g3689 = i.uv_texcoord * appendResult128_g3689 + appendResult125_g3689;
			float4 NORMAL_PC_RGB531_g3689 = SAMPLE_TEXTURE2D( _BumpMap, sampler_trilinear_repeat, uv_TexCoord2_g3689 );
			float4 temp_output_1_0_g43294 = NORMAL_PC_RGB531_g3689;
			float temp_output_8_0_g43294 = _NormalStrength;
			float3 temp_output_604_59_g3689 = UnpackScaleNormal( temp_output_1_0_g43294, temp_output_8_0_g43294 );
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 worldToViewDir560_g3689 = normalize( mul( UNITY_MATRIX_V, float4( ase_worldlightDir, 0 ) ).xyz );
			float dotResult307_g3689 = dot( temp_output_604_59_g3689 , worldToViewDir560_g3689 );
			float3 appendResult306_g3689 = (float3(dotResult307_g3689 , dotResult307_g3689 , dotResult307_g3689));
			float3 NORMAL_IN42_g43281 = ( temp_output_604_59_g3689 + saturate( appendResult306_g3689 ) );
			float3 m_Default37_g43281 = NORMAL_IN42_g43281;
			float3 m_Flip37_g43281 = ( NORMAL_IN42_g43281 * i.ASEVFace );
			float3 break33_g43281 = NORMAL_IN42_g43281;
			float3 appendResult41_g43281 = (float3(break33_g43281.x , break33_g43281.y , ( break33_g43281.z * i.ASEVFace )));
			float3 m_Mirror37_g43281 = appendResult41_g43281;
			float3 local_NormalModefloat3switch37_g43281 = _NormalModefloat3switch( m_switch37_g43281 , m_Default37_g43281 , m_Flip37_g43281 , m_Mirror37_g43281 );
			float3 temp_output_620_30_g3689 = local_NormalModefloat3switch37_g43281;
			o.Normal = temp_output_620_30_g3689;
			float4 tex2DNode3_g3689 = SAMPLE_TEXTURE2D( _MainTex, sampler_trilinear_repeat, uv_TexCoord2_g3689 );
			float4 ALBEDO_RGBA529_g3689 = tex2DNode3_g3689;
			float3 temp_output_28_0_g3689 = ( (_Color).rgb * (ALBEDO_RGBA529_g3689).rgb * _Brightness );
			o.Albedo = temp_output_28_0_g3689;
			float temp_output_1_0_g43287 = _MetallicStrength;
			o.Metallic = temp_output_1_0_g43287;
			float temp_output_660_0_g3689 = (_SmoothnessMin + (0.0 - 0.0) * (_SmoothnessMax - _SmoothnessMin) / (1.0 - 0.0));
			o.Smoothness = temp_output_660_0_g3689;
			float temp_output_16_0_g43296 = _OcclusionStrengthAO;
			float4 temp_cast_1 = (( 1.0 - temp_output_16_0_g43296 )).xxxx;
			float4 color77_g43296 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float4 temp_cast_2 = (i.vertexColor.a).xxxx;
			float4 lerpResult75_g43296 = lerp( color77_g43296 , temp_cast_2 , temp_output_16_0_g43296);
			float4 lerpResult83_g43296 = lerp( temp_cast_1 , lerpResult75_g43296 , _OcclusionSource);
			o.Occlusion = saturate( lerpResult83_g43296 ).r;
			float ALBEDO_A414_g3689 = tex2DNode3_g3689.a;
			float Albedo_Alpha52_g43297 = ALBEDO_A414_g3689;
			float AlphaCutoffBias33_g43297 = _AlphaCutoffBias;
			clip( Albedo_Alpha52_g43297 - ( 1.0 - AlphaCutoffBias33_g43297 ));
			float temp_output_10_0_g43297 = saturate( ( ( Albedo_Alpha52_g43297 / max( fwidth( Albedo_Alpha52_g43297 ) , 0.0001 ) ) + 0.5 ) );
			o.Alpha = temp_output_10_0_g43297;
			float3 normalizeResult38_g43297 = normalize( cross( ddx( ase_worldPos ) , ddy( ase_worldPos ) ) );
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult35_g43297 = dot( normalizeResult38_g43297 , ase_worldViewDir );
			float temp_output_32_0_g43297 = ( 1.0 - abs( dotResult35_g43297 ) );
			float lerpResult67_g43297 = lerp( 1.0 , ( 1.0 - ( temp_output_32_0_g43297 * temp_output_32_0_g43297 ) ) , _GlancingClipMode1);
			clip( lerpResult67_g43297 - _MaskClipValue );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "DE_ShaderGUI"
}
/*ASEBEGIN
Version=18934
79;54;1654;856;275.4868;216.061;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;410;141.4512,5.670602;Inherit;False;410;120;GLOBAL SETTINGS ;2;508;52;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;411;137.0287,132.8749;Inherit;False;414.5028;194.4201;DEBUG SETTINGS ;4;187;51;388;188;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;507;136.7708,758.9383;Inherit;False;295.5475;107.529;DESF Utility ASE Compile Shaders;1;506;;0,0.2605708,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;504;-607.822,340.9915;Inherit;False;DESF Module Wind;76;;3276;b135a554f7e4d0b41bba02c61b34ae74;10,938,0,2881,0,2371,2,2454,2,2433,2,2434,2,2432,2,2457,2,2878,0,2752,0;0;1;FLOAT3;2190
Node;AmplifyShaderEditor.IntNode;52;155.9169,46.00791;Inherit;False;Property;_CullMode;Cull Mode;3;2;[Header];[Enum];Create;False;1;GLOBAL SETTINGS;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;188;153.2882,172.2121;Inherit;False;Property;_ColorMask;Color Mask Mode;1;1;[Enum];Create;False;1;;0;1;None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15;True;0;False;15;15;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;388;154.1643,247.2158;Inherit;False;Property;_AlphatoCoverage;Alpha to Coverage;2;1;[Enum];Create;True;1;;1;Option1;0;1;Off,0,On,1;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;506;148.7708,796.9383;Inherit;False;DESF Utility ASE Compile Shaders;-1;;3688;b85b01c42ba8a8a448b731b68fc0dbd9;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;348.7789,245.4035;Inherit;False;Constant;_MaskClipValue;Mask Clip Value;19;1;[HideInInspector];Create;True;1;;0;0;True;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;187;349.8297,173.4964;Inherit;False;Property;_ZWriteMode;ZWrite Mode;0;2;[Header];[Enum];Create;False;1;DEBUG SETTINGS;0;1;Off,0,On,1;True;0;False;1;1;False;0;1;INT;0
Node;AmplifyShaderEditor.FunctionNode;505;-382.222,340.2915;Inherit;False;DESF Core Billboard;5;;3689;e3fce2294f3bde941a48e407ffdf732f;14,572,0,139,0,582,1,625,0,626,0,668,0,638,0,639,0,69,0,540,0,361,0,612,0,613,0,541,1;1;457;FLOAT3;0,0,0;False;9;FLOAT3;0;FLOAT3;556;FLOAT;56;FLOAT;50;COLOR;57;FLOAT;49;FLOAT;351;FLOAT;649;FLOAT3;458
Node;AmplifyShaderEditor.RangedFloatNode;508;289.0132,45.689;Half;False;Property;_EmissionFlags;Global Illumination Emissive;4;0;Create;False;0;0;0;True;1;EmissionFlags;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;39;131.55,344.4214;Float;False;True;-1;2;DE_ShaderGUI;200;0;Standard;DEC/Billboard/Billboard Wind;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;True;True;True;Back;0;True;187;3;False;283;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;-10;True;Opaque;;Geometry;All;18;all;True;True;True;True;0;True;188;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;True;True;Relative;200;;-1;-1;-1;-1;1;NatureRendererInstancing=True;False;0;0;True;52;-1;0;True;51;5;Pragma;multi_compile_instancing;False;;Custom;Pragma;instancing_options procedural:SetupNatureRenderer forwardadd;False;;Custom;Pragma;multi_compile GPU_FRUSTUM_ON __;False;8ccd508f733f5f0418220eaf14ecdf81;Custom;Include;Nature Renderer.cginc;False;5d792e02fd6741e4cb63087f97979470;Custom;Pragma;multi_compile_local _ NATURE_RENDERER;False;;Custom;0;0;False;0.1;False;-1;0;True;388;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;505;457;504;2190
WireConnection;39;0;505;0
WireConnection;39;1;505;556
WireConnection;39;3;505;56
WireConnection;39;4;505;50
WireConnection;39;5;505;57
WireConnection;39;9;505;49
WireConnection;39;10;505;351
WireConnection;39;11;505;458
ASEEND*/
//CHKSM=6D3EF477D8EE14E4761471379B20AB386768BC3E