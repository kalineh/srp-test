Shader "CustomRender/Unlit"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo", 2D) = "white" {}

        _EmissionColor("Color", Color) = (0,0,0)
        _EmissionMap("Emission", 2D) = "white" {}
    }

    SubShader
    {
        Tags{"RenderType" = "Opaque" "RenderPipeline" = "CustomRenderPipeline"}

        Pass
        {
            Tags {"LightMode" = "CustomRenderForward"}

            //Blend SrcAlpha OneMinusSrcAlpha
            //ZWrite Off
			//ZTest Always

            CGPROGRAM

			#include "UnityCG.cginc"

            #pragma target 3.0
			#pragma vertex ForwardVert
			#pragma fragment ForwardFrag
			
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0; 
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                UNITY_VERTEX_OUTPUT_STEREO
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            half4 _MainColor;

            v2f ForwardVert(appdata v)
            {
                v2f o;

                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 ForwardFrag(v2f i) : SV_Target
            {
                fixed4 texColor = tex2D(_MainTex, i.uv);
                fixed alpha = texColor.a * _MainColor.a;
                fixed3 color = texColor.rgb * _MainColor.rgb;

                UNITY_APPLY_FOG(i.fogCoord, color);

                return fixed4(color, alpha);

                return fixed4(1,1,1,1);
            }
            ENDCG
        }

        Pass
        {
            Tags {"LightMode" = "ShadowCaster"}

            ZWrite On ZTest LEqual

            CGPROGRAM
            #pragma target 2.0
            #pragma vertex ShadowVert
            #pragma fragment ShadowFrag

            #include "UnityCG.cginc"

            float4 ShadowVert(float4 pos : POSITION) : SV_POSITION
            {
                return UnityObjectToClipPos(pos);
            }

            half4 ShadowFrag() : SV_TARGET
            {
                return 0.0;
            }
            ENDCG
        }

        Pass
        {
            Tags {"LightMode" = "CustomRenderDepth"}

            ZWrite On
            ColorMask 0

            CGPROGRAM
            #pragma target 2.0
            #pragma vertex DepthVert
            #pragma fragment DepthFrag

            #include "UnityCG.cginc"

            float4 DepthVert(float4 pos : POSITION) : SV_POSITION
            {
                return UnityObjectToClipPos(pos);
            }

            half4 DepthFrag() : SV_TARGET
            {
                return 0;
            }
            ENDCG
        }
    }
    FallBack "Standard"
}

