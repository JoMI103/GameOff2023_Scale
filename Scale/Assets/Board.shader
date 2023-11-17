Shader "Unlit/Board" {
    Properties {
        _Noise ("Noise texture", 2D) = "white" {}
        _Color1 ("First Color", COLOR) = (1,1,1,1)
        _Color2 ("Second Color", COLOR) = (1,1,1,1)
    }
    SubShader  {
        Tags { "RenderType"="Opaque" }


        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag


            #include "UnityCG.cginc"

            struct MeshData {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Interpolators {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                
            };

            sampler2D _Noise;
            float4 _Noise_ST;
            float4 _Color1, _Color2;

            Interpolators vert (MeshData v) {
                Interpolators o;               
                o.vertex = UnityObjectToClipPos(v.vertex);
                //o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (Interpolators i) : SV_Target
            {
                // sample the texture
                fixed4 col = lerp(_Color1,_Color2,tex2D(_Noise, i.uv));
            
                return col;
            }
            ENDCG
        }
    }
}
