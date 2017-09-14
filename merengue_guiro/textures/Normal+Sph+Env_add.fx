////////////////////////////////////////////////////////////////////////////////////////////////
//  ノーマルマップ＋スフィアエフェクト v0.60
//	作成：むきえび
//  舞力介入P full.fx ver1.4 + ビームマンP SimpleSoftShadow + Tilt改変 + 材質モーフ対応
//  + Furia氏ノーマルマップ実装 + ノーマルマップ座標種別対応
//  + ノーマルマップと環境マップ織り込みスフィアマップ
//	+ 環境マップ
//
//
////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////// ソフトシャドウ関連 ///////////////////
//ソフトシャドウ用ぼかし率 頭に//を付けるとソフトシャドウ無効
#define SOFT_SHADOW_PARAM 0.5
//ソフトシャドウでのサンプリングUV座標を傾けることで、近距離でのジャギーを軽減する
//頭に//を付けるとティルト無効
#define TILT_SOFTSHADOW 1
//シャドウマップサイズ
//通常：1024 CTRL+Gで解像度を上げた場合 4096
#define SHADOWMAP_SIZE 1024


//////////////////////// ノーマルマップ関連 ///////////////////
// ノーマルマップテクスチャファイル名 使わないときは行頭に//をつける
#define NORMALMAP_FILE "normal.png"

// 使用するノーマルマップの座標種別：該当する行のみ行頭の//を削除する
// ●緑/水色の光が上から、赤/ピンクの光が右から差し込んでいるように見える
// ノーマルマップ(Blender bakeなど)
#define NORMALMAP_COORDINATE float3(-2,2,2)
// ●緑/水色の光が上から、赤/ピンクの光が左から差し込んでいるように見える
// ノーマルマップ(Photoshopプラグインなど)
//#define NORMALMAP_COORDINATE float3(2,2,2)
// ●緑/水色の光が下から、赤/ピンクの光が右から差し込んでいるように見える
// ノーマルマップ(nvDXTなど)
//#define NORMALMAP_COORDINATE float3(-2,-2,2)

//テクスチャ上下左右端の処理方法。タイルパターンの場合WRAP、それ以外は通常CLAMPのほうがよい。
#define TEXADDRESS_U WRAP
#define TEXADDRESS_V WRAP

//////////////////////// 材質設定関連 ///////////////////
// 反射色。アクセサリで反射色設定を使いたいとき指定します。
// モデル材質値を使用する(PMD,PMX)場合は行頭に//をつける
#define MATERIAL_SPECULAR_COLOR float3(0.8,0.8,0.8)

// 「加算スフィアのαも加算 」効果。透明度の高い材質で不透明な光沢を出すのに使用する。
// アルファ値(不透明度)の設定されたスフィアマップが必要で、それに合わせて調整する。
// 加算スフィアのアルファ(不透明度)を足しこむ強さを指定する。使わないときは行頭に//をつける
#define SPHERE_ADD_ALPHA 2

//////////////////////// 環境マップ関連 ///////////////////
// 環境マップテクスチャファイル名 環境マップを使わないときは行頭に//をつける
#define ENVMAP_FILE "metal_real019.bmp"

// 反射色に織り込む環境マップの強さ(0で0%、1.0で100%) 反射なので、効果の出る光源方向は限られる。
// 無効にするには0にするのではなく行頭に//をつける
//#define SPECULAR_ENVMAP_RATE 0.25

// スフィアに織り込む環境マップの強さ((0で0%、1.0で100%) スフィア効果に環境マップの効果も追加するとき使用する。
// たぶん加算スフィアでしか役に立たない。無効にするには0にするのではなく行頭に//をつける
#define SPHERE_ENVMAP_RATE 0.5


//表示品質設定////////////////////////////////////////////////////////////////////
// ミップマップ：主に遠距離でのテクスチャのモアレやジャギーを抑制する。
// ミップレベル：多分フル(0)固定でよい。
#define MIPLEVELS 0

// フィルタ設定 以下３つから選択
//異方向性フィルタ（負荷大）
//#define TEXFILTER_SETTING ANISOTROPIC
//バイリニア（簡易なめらか表示：標準）
#define TEXFILTER_SETTING LINEAR
//ニアレストネイバー（くっきり表示：テクスチャのドットが綺麗に出る）
//#define TEXFILTER_SETTING POINT

//異方向性フィルタを使うときの倍率
//1:Off or 2の倍数で指定(大きいほどなめらか効果・負荷大)
//対応しているかどうかは、ハードウェア次第（RadeonHD機種なら16までは対応しているはず
#define TEXFILTER_MAXANISOTROPY 4


//////////////////////// その他 ///////////////////
//本エフェクトを適用する材質番号（MMEリファレンス Subset項参照）
#define TARGET_MATERIALS "0-"

//////////// ここから先はエフェクトの知識がある人以外は触らないほうが良い
// パラメータ宣言

// 座法変換行列
float4x4 WorldViewProjMatrix      : WORLDVIEWPROJECTION;
float4x4 WorldMatrix              : WORLD;
float4x4 ViewMatrix               : VIEW;
float4x4 LightWorldViewProjMatrix : WORLDVIEWPROJECTION < string Object = "Light"; >;

float3   LightDirection    : DIRECTION < string Object = "Light"; >;
float3   CameraPosition    : POSITION  < string Object = "Camera"; >;

// マテリアル色
float4   MaterialDiffuse   : DIFFUSE  < string Object = "Geometry"; >;
float3   MaterialAmbient   : AMBIENT  < string Object = "Geometry"; >;
float3   MaterialEmmisive  : EMISSIVE < string Object = "Geometry"; >;
#if defined(MATERIAL_SPECULAR_COLOR)
float3   MaterialSpecular  = MATERIAL_SPECULAR_COLOR;
#else
float3   MaterialSpecular  : SPECULAR < string Object = "Geometry"; >;
#endif
float    SpecularPower     : SPECULARPOWER < string Object = "Geometry"; >;
float3   MaterialToon      : TOONCOLOR;
float4   EdgeColor         : EDGECOLOR;
// ライト色
float3   LightDiffuse      : DIFFUSE   < string Object = "Light"; >;
float3   LightAmbient      : AMBIENT   < string Object = "Light"; >;
float3   LightSpecular     : SPECULAR  < string Object = "Light"; >;
//材質モーフの取得
float4 EgColor;
float4 SpcColor;
bool use_toon;
// 適用色
static float4 DiffuseColor  = MaterialDiffuse  * float4(LightDiffuse, 1.0f);
static const float3 AmbientColorOriginal
 = saturate(MaterialAmbient * LightAmbient + MaterialEmmisive);
static const float3 AmbientColor = use_toon ? EgColor.rgb : AmbientColorOriginal;
static const float3 SpecularColorOriginal
 = MaterialSpecular * LightSpecular;
static const float3 SpecularColor = use_toon ? SpcColor.rgb : SpecularColorOriginal;


bool     parthf;   // パースペクティブフラグ
bool     transp;   // 半透明フラグ
bool	 spadd;    // スフィアマップ加算合成フラグ
#define SKII1    1500
#define SKII2    8000
#define Toon     3

// オブジェクトのテクスチャ
texture ObjectTexture: MATERIALTEXTURE;
sampler ObjTexSampler = sampler_state {
    texture = <ObjectTexture>;
    MINFILTER = LINEAR;
    MAGFILTER = LINEAR;
};

// スフィアマップのテクスチャ
texture ObjectSphereMap: MATERIALSPHEREMAP;
sampler ObjSphareSampler = sampler_state {
    texture = <ObjectSphereMap>;
    MINFILTER = LINEAR;
    MAGFILTER = LINEAR;
};

// MMD本来のsamplerを上書きしないための記述です。削除不可。
sampler MMDSamp0 : register(s0);
sampler MMDSamp1 : register(s1);
sampler MMDSamp2 : register(s2);


//////////////テクスチャ定義/////////////////////////////////////////
#ifdef NORMALMAP_FILE
texture NormalMapTex1 <
	string ResourceName = NORMALMAP_FILE;
	int Miplevels = MIPLEVELS;
>;
sampler NormalMapTexSampler1 = sampler_state {
	texture = <NormalMapTex1>;
    MINFILTER = TEXFILTER_SETTING;
    MAGFILTER = TEXFILTER_SETTING;
	MIPFILTER = TEXFILTER_SETTING;
	AddressU = TEXADDRESS_U;
	AddressV = TEXADDRESS_V;
	MAXANISOTROPY = TEXFILTER_MAXANISOTROPY;
};
#endif

#ifdef ENVMAP_FILE
texture EnvMapTex1 <
	string ResourceName = ENVMAP_FILE;
	int Miplevels = MIPLEVELS;
>;
sampler EnvMapTexSampler1 = sampler_state {
	texture = <EnvMapTex1>;
    MINFILTER = TEXFILTER_SETTING;
    MAGFILTER = TEXFILTER_SETTING;
	MIPFILTER = TEXFILTER_SETTING;
	AddressU = TEXADDRESS_U;
	AddressV = TEXADDRESS_V;
	MAXANISOTROPY = TEXFILTER_MAXANISOTROPY;
};
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
//接空間取得
#ifdef NORMALMAP_FILE
float3x3 compute_tangent_frame(float3 Normal, float3 View, float2 UV)
{
  float3 dp1 = ddx(View);
  float3 dp2 = ddy(View);
  float2 duv1 = ddx(UV);
  float2 duv2 = ddy(UV);

  float3x3 M = float3x3(dp1, dp2, cross(dp1, dp2));
  float2x3 inverseM = float2x3(cross(M[1], M[2]), cross(M[2], M[0]));
  float3 Tangent = mul(float2(duv1.x, duv2.x), inverseM);
  float3 Binormal = mul(float2(duv1.y, duv2.y), inverseM);

  return float3x3(normalize(Tangent), normalize(Binormal), Normal);
}
#endif

//環境マップ取得
#if defined(ENVMAP_FILE)
float4 samplingEnvMap(float3 RefDir)
{
    return tex2D(EnvMapTexSampler1,(1-pow(RefDir.y,2))*float2(0.9*0.25,0.9*-0.5)*RefDir.xz+float2(RefDir.y>0?0.25:0.75,0.5));
    //Specular += tex2D(EnvMapTexSampler1,float2(0.9*0.25*0.25,0.9*-0.5*0.25)*normal.xz+float2(0.5,normal.y>0?0.25/2:1-0.25/2));
}
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
// 輪郭描画

// 頂点シェーダ
float4 ColorRender_VS(float4 Pos : POSITION) : POSITION
{
    // カメラ視点のワールドビュー射影変換
    return mul( Pos, WorldViewProjMatrix );
}

// ピクセルシェーダ
float4 ColorRender_PS() : COLOR
{
    // 輪郭色で塗りつぶし
    return EdgeColor;
}

// 輪郭描画用テクニック
technique EdgeTec < string MMDPass = "edge"; > {
    pass DrawEdge {
        AlphaBlendEnable = FALSE;
        AlphaTestEnable  = FALSE;

        VertexShader = compile vs_2_0 ColorRender_VS();
        PixelShader  = compile ps_2_0 ColorRender_PS();
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////
// 影（非セルフシャドウ）描画

// 頂点シェーダ
float4 Shadow_VS(float4 Pos : POSITION) : POSITION
{
    // カメラ視点のワールドビュー射影変換
    return mul( Pos, WorldViewProjMatrix );
}

// ピクセルシェーダ
float4 Shadow_PS() : COLOR
{
    // アンビエント色で塗りつぶし
    return float4(AmbientColor.rgb, 0.65f);
}

// 影描画用テクニック
technique ShadowTec < string MMDPass = "shadow"; > {
    pass DrawShadow {
        VertexShader = compile vs_2_0 Shadow_VS();
        PixelShader  = compile ps_2_0 Shadow_PS();
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////
// オブジェクト描画（セルフシャドウOFF）

struct VS_OUTPUT {
    float4 Pos        : POSITION;    // 射影変換座標
    float2 Tex        : TEXCOORD1;   // テクスチャ
    float3 Normal     : TEXCOORD2;   // 法線
    float3 Eye        : TEXCOORD3;   // カメラとの相対位置
//    float2 SpTex      : TEXCOORD4;	 // スフィアマップテクスチャ座標
    float4 Color      : COLOR0;      // ディフューズ色
};

// 頂点シェーダ
VS_OUTPUT Basic_VS(float4 Pos : POSITION, float3 Normal : NORMAL, float2 Tex : TEXCOORD0, uniform bool useTexture, uniform bool useSphereMap, uniform bool useToon)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

    // カメラ視点のワールドビュー射影変換
    Out.Pos = mul( Pos, WorldViewProjMatrix );

    // カメラとの相対位置
    Out.Eye = CameraPosition - mul( Pos, WorldMatrix );
    // 頂点法線
    Out.Normal = normalize( mul( Normal, (float3x3)WorldMatrix ) );

    // ディフューズ色＋アンビエント色 計算
    Out.Color.rgb = AmbientColor;
    if ( !useToon ) {
        Out.Color.rgb += max(0,dot( Out.Normal, -LightDirection )) * DiffuseColor.rgb;
    }
    Out.Color.a = DiffuseColor.a;
    Out.Color = saturate( Out.Color );

    // テクスチャ座標
    Out.Tex = Tex;

/* ノーマルマップ折込のため、ピクセルシェーダに移動
    if ( useSphereMap ) {
        // スフィアマップテクスチャ座標
        float2 NormalWV = mul( Out.Normal, (float3x3)ViewMatrix );
        Out.SpTex.x = NormalWV.x * 0.5f + 0.5f;
        Out.SpTex.y = NormalWV.y * -0.5f + 0.5f;
    }
*/
    return Out;
}

// ピクセルシェーダ
float4 Basic_PS(VS_OUTPUT IN, uniform bool useTexture, uniform bool useSphereMap, uniform bool useToon) : COLOR0
{

#ifdef NORMALMAP_FILE
	float3x3 tangentFrame = compute_tangent_frame(IN.Normal, IN.Eye, IN.Tex);
	float3 normal = normalize(mul(NORMALMAP_COORDINATE * (tex2D(NormalMapTexSampler1, IN.Tex) - 0.5f), tangentFrame));
#else
	float3 normal = normalize(IN.Normal);
#endif
    // スペキュラ色計算
#if defined(ENVMAP_FILE)
    float3 RefDir = normalize(reflect(-IN.Eye,normal));
    float4 EnvColor = samplingEnvMap(RefDir);
#endif
#if defined(ENVMAP_FILE) && defined(SPECULAR_ENVMAP_RATE)
    float3 Specular = pow( max(0,dot( RefDir, -LightDirection )), SpecularPower )* SpecularColor
     + EnvColor * SPECULAR_ENVMAP_RATE;
#else
    float3 HalfVector = normalize( normalize(IN.Eye) + -LightDirection );
    float3 Specular = pow( max(0,dot( HalfVector, normal )), SpecularPower ) * SpecularColor;
#endif

    float4 Color = IN.Color;
    if ( useTexture ) {
        // テクスチャ適用
        Color *= tex2D( ObjTexSampler, IN.Tex );
    }
    if ( useSphereMap ) {
        // スフィアマップテクスチャ座標
        float2 NormalWV = mul( normal, (float3x3)ViewMatrix );
        float2 SpTex;
        SpTex.x = NormalWV.x * 0.5f + 0.5f;
        SpTex.y = NormalWV.y * -0.5f + 0.5f;
        // スフィアマップ適用
        float4 TexColor = tex2D(ObjSphareSampler,SpTex);
        if(spadd) {
#if defined(ENVMAP_FILE) && defined(SPHERE_ENVMAP_RATE)
            TexColor *= EnvColor*SPHERE_ENVMAP_RATE
             + float4(1-SPHERE_ENVMAP_RATE,1-SPHERE_ENVMAP_RATE,1-SPHERE_ENVMAP_RATE,0);
#endif
#if defined(SPHERE_ADD_ALPHA)
            TexColor.a *= SPHERE_ADD_ALPHA;
            Color += TexColor;
            Color.a = saturate(Color.a);
#else
            Color.rgb += TexColor.rgb;
#endif
        } else {
#if defined(ENVMAP_FILE) && defined(SPHERE_ENVMAP_RATE)
            TexColor *= EnvColor*SPHERE_ENVMAP_RATE + (1-SPHERE_ENVMAP_RATE);
#endif
            Color.rgb *= TexColor.rgb;
        }
    }

    if ( useToon ) {
        // トゥーン適用
        float LightNormal = dot( normal, -LightDirection );
        //Color.rgb *= lerp(MaterialToon, float3(1,1,1), saturate(LightNormal * 16 + 0.5));
        // toonのグラデーションを反映。 full_v1.4.1.fx参考
        Color.rgb *= tex2D(MMDSamp0, float2(0, 0.5 - LightNormal * 0.5) ).rgb;
    }

    // スペキュラ適用
    Color.rgb += Specular;

    return Color;
}

/*
// オブジェクト描画用テクニック（アクセサリ用）
// 不要なものは削除可
technique MainTec0 < string MMDPass = "object"; bool UseTexture = false; bool UseSphereMap = false; bool UseToon = false; > {
    pass DrawObject {
        VertexShader = compile vs_2_0 Basic_VS(false, false, false);
        PixelShader  = compile ps_2_0 Basic_PS(false, false, false);
    }
}

technique MainTec1 < string MMDPass = "object"; bool UseTexture = true; bool UseSphereMap = false; bool UseToon = false; > {
    pass DrawObject {
        VertexShader = compile vs_2_0 Basic_VS(true, false, false);
        PixelShader  = compile ps_2_0 Basic_PS(true, false, false);
    }
}

technique MainTec2 < string MMDPass = "object"; bool UseTexture = false; bool UseSphereMap = true; bool UseToon = false; > {
    pass DrawObject {
        VertexShader = compile vs_2_0 Basic_VS(false, true, false);
        PixelShader  = compile ps_2_0 Basic_PS(false, true, false);
    }
}

technique MainTec3 < string MMDPass = "object"; bool UseTexture = true; bool UseSphereMap = true; bool UseToon = false; > {
    pass DrawObject {
        VertexShader = compile vs_2_0 Basic_VS(true, true, false);
        PixelShader  = compile ps_2_0 Basic_PS(true, true, false);
    }
}

// オブジェクト描画用テクニック（PMDモデル用）
technique MainTec4 < string MMDPass = "object"; bool UseTexture = false; bool UseSphereMap = false; bool UseToon = true; > {
    pass DrawObject {
        VertexShader = compile vs_2_0 Basic_VS(false, false, true);
        PixelShader  = compile ps_2_0 Basic_PS(false, false, true);
    }
}

technique MainTec5 < string MMDPass = "object"; bool UseTexture = true; bool UseSphereMap = false; bool UseToon = true; > {
    pass DrawObject {
        VertexShader = compile vs_2_0 Basic_VS(true, false, true);
        PixelShader  = compile ps_2_0 Basic_PS(true, false, true);
    }
}

technique MainTec6 < string MMDPass = "object"; bool UseTexture = false; bool UseSphereMap = true; bool UseToon = true; > {
    pass DrawObject {
        VertexShader = compile vs_2_0 Basic_VS(false, true, true);
        PixelShader  = compile ps_2_0 Basic_PS(false, true, true);
    }
}

technique MainTec7 < string MMDPass = "object"; bool UseTexture = true; bool UseSphereMap = true; bool UseToon = true; > {
    pass DrawObject {
        VertexShader = compile vs_2_0 Basic_VS(true, true, true);
        PixelShader  = compile ps_2_0 Basic_PS(true, true, true);
    }
}
*/

// オブジェクト描画用テクニック
#define MACRO_TEC(num, tex, sphere, toon) \
technique NormalMap_MainTec##num < \
 string Subset = TARGET_MATERIALS; string MMDPass = "object"; \
 bool UseTexture = tex; bool UseSphereMap = sphere; bool UseToon = toon; > { \
    pass DrawObject { \
        VertexShader = compile vs_3_0 Basic_VS( tex, sphere, toon); \
        PixelShader  = compile ps_3_0 Basic_PS( tex, sphere, toon); \
    } \
}

// オブジェクト描画用テクニック（アクセサリ用）
MACRO_TEC(0, false, false, false)
MACRO_TEC(1, true,  false, false)
MACRO_TEC(2, false, true,  false)
MACRO_TEC(3, true,  true,  false)
// オブジェクト描画用テクニック（PMD/PMXモデル用）
MACRO_TEC(4, false, false, true)
MACRO_TEC(5, true,  false, true)
MACRO_TEC(6, false, true,  true)
MACRO_TEC(7, true,  true,  true)

///////////////////////////////////////////////////////////////////////////////////////////////
// セルフシャドウ用Z値プロット

struct VS_ZValuePlot_OUTPUT {
    float4 Pos : POSITION;              // 射影変換座標
    float4 ShadowMapTex : TEXCOORD0;    // Zバッファテクスチャ
};

// 頂点シェーダ
VS_ZValuePlot_OUTPUT ZValuePlot_VS( float4 Pos : POSITION )
{
    VS_ZValuePlot_OUTPUT Out = (VS_ZValuePlot_OUTPUT)0;

    // ライトの目線によるワールドビュー射影変換をする
    Out.Pos = mul( Pos, LightWorldViewProjMatrix );

    // テクスチャ座標を頂点に合わせる
    Out.ShadowMapTex = Out.Pos;

    return Out;
}

// ピクセルシェーダ
float4 ZValuePlot_PS( float4 ShadowMapTex : TEXCOORD0 ) : COLOR
{
    // R色成分にZ値を記録する
    return float4(ShadowMapTex.z/ShadowMapTex.w,0,0,1);
}

// Z値プロット用テクニック
technique ZplotTec < string MMDPass = "zplot"; > {
    pass ZValuePlot {
        AlphaBlendEnable = FALSE;
        VertexShader = compile vs_2_0 ZValuePlot_VS();
        PixelShader  = compile ps_2_0 ZValuePlot_PS();
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////
// オブジェクト描画（セルフシャドウON）

// シャドウバッファのサンプラ。"register(s0)"なのはMMDがs0を使っているから
sampler DefSampler : register(s0);

struct BufferShadow_OUTPUT {
    float4 Pos      : POSITION;     // 射影変換座標
    float4 ZCalcTex : TEXCOORD0;    // Z値
    float2 Tex      : TEXCOORD1;    // テクスチャ
    float3 Normal   : TEXCOORD2;    // 法線
    float3 Eye      : TEXCOORD3;    // カメラとの相対位置
//    float2 SpTex    : TEXCOORD4;	 // スフィアマップテクスチャ座標
    float4 Color    : COLOR0;       // ディフューズ色
};

// 頂点シェーダ
BufferShadow_OUTPUT BufferShadow_VS(float4 Pos : POSITION, float3 Normal : NORMAL, float2 Tex : TEXCOORD0, uniform bool useTexture, uniform bool useSphereMap, uniform bool useToon)
{
    BufferShadow_OUTPUT Out = (BufferShadow_OUTPUT)0;

    // カメラ視点のワールドビュー射影変換
    Out.Pos = mul( Pos, WorldViewProjMatrix );

    // カメラとの相対位置
    Out.Eye = CameraPosition - mul( Pos, WorldMatrix );
    // 頂点法線
    Out.Normal = normalize( mul( Normal, (float3x3)WorldMatrix ) );
	// ライト視点によるワールドビュー射影変換
    Out.ZCalcTex = mul( Pos, LightWorldViewProjMatrix );

    // ディフューズ色＋アンビエント色 計算
    Out.Color.rgb = AmbientColor;
    if ( !useToon ) {
        Out.Color.rgb += max(0,dot( Out.Normal, -LightDirection )) * DiffuseColor.rgb;
    }
    Out.Color.a = DiffuseColor.a;
    Out.Color = saturate( Out.Color );

    // テクスチャ座標
    Out.Tex = Tex;

/* ノーマルマップ折込のため、ピクセルシェーダに移動
    if ( useSphereMap ) {
        // スフィアマップテクスチャ座標
        float2 NormalWV = mul( Out.Normal, (float3x3)ViewMatrix );
        Out.SpTex.x = NormalWV.x * 0.5f + 0.5f;
        Out.SpTex.y = NormalWV.y * -0.5f + 0.5f;
    }
*/

    return Out;
}




// ピクセルシェーダ
float4 BufferShadow_PS(BufferShadow_OUTPUT IN, uniform bool useTexture, uniform bool useSphereMap, uniform bool useToon) : COLOR
{

#ifdef NORMALMAP_FILE
	float3x3 tangentFrame = compute_tangent_frame(IN.Normal, IN.Eye, IN.Tex);
	float3 normal = normalize(mul(NORMALMAP_COORDINATE * (tex2D(NormalMapTexSampler1, IN.Tex) - 0.5f), tangentFrame));
#else
	float3 normal = normalize(IN.Normal);
#endif
    // スペキュラ色計算
#if defined(ENVMAP_FILE)
    float3 RefDir = normalize(reflect(-IN.Eye,normal));
    float4 EnvColor = samplingEnvMap(RefDir);
#endif
#if defined(ENVMAP_FILE) && defined(SPECULAR_ENVMAP_RATE)
    float3 Specular = pow( max(0,dot( RefDir, -LightDirection )), SpecularPower )* SpecularColor
     + EnvColor* SPECULAR_ENVMAP_RATE;
#else
    float3 HalfVector = normalize( normalize(IN.Eye) + -LightDirection );
    float3 Specular = pow( max(0,dot( HalfVector, normal )), SpecularPower ) * SpecularColor;
#endif

    float4 Color = IN.Color;
    float4 ShadowColor = float4(AmbientColor, Color.a);  // 影の色
    if ( useTexture ) {
        // テクスチャ適用
        float4 TexColor = tex2D( ObjTexSampler, IN.Tex );
        Color *= TexColor;
        ShadowColor *= TexColor;
    }
    if ( useSphereMap ) {
        // スフィアマップテクスチャ座標
        float2 NormalWV = mul( normal, (float3x3)ViewMatrix );
        float2 SpTex;
        SpTex.x = NormalWV.x * 0.5f + 0.5f;
        SpTex.y = NormalWV.y * -0.5f + 0.5f;
        // スフィアマップ適用
        float4 TexColor = tex2D(ObjSphareSampler,SpTex);
        if(spadd) {
#if defined(ENVMAP_FILE) && defined(SPHERE_ENVMAP_RATE)
            TexColor *= EnvColor*SPHERE_ENVMAP_RATE
             + float4(1-SPHERE_ENVMAP_RATE,1-SPHERE_ENVMAP_RATE,1-SPHERE_ENVMAP_RATE,0);
#endif
#if defined(SPHERE_ADD_ALPHA)
            TexColor.a *= SPHERE_ADD_ALPHA;
            Color += TexColor;
            Color.a = saturate(Color.a);
            ShadowColor += TexColor;
            ShadowColor.a = saturate(ShadowColor.a);
#else
            Color.rgb += TexColor.rgb;
            ShadowColor.rgb += TexColor.rgb;
#endif
        } else {
#if defined(ENVMAP_FILE) && defined(SPHERE_ENVMAP_RATE)
            TexColor *= EnvColor*SPHERE_ENVMAP_RATE + (1-SPHERE_ENVMAP_RATE);
#endif
            Color.rgb *= TexColor.rgb;
            ShadowColor.rgb *= TexColor.rgb;
        }
    }
    // スペキュラ適用
    Color.rgb += Specular;

    // テクスチャ座標に変換
    IN.ZCalcTex /= IN.ZCalcTex.w;
    float2 TransTexCoord;
    TransTexCoord.x = (1.0f + IN.ZCalcTex.x)*0.5f;
    TransTexCoord.y = (1.0f - IN.ZCalcTex.y)*0.5f;

    if( any( saturate(TransTexCoord) != TransTexCoord ) ) {
        // シャドウバッファ外
        return Color;
    } else {
        float comp = 0;
#if defined(SOFT_SHADOW_PARAM) && defined(TILT_SOFTSHADOW)
        float uvstep = SOFT_SHADOW_PARAM / SHADOWMAP_SIZE;
		float2 U = float2(uvstep,uvstep/3);
		float2 V = float2(-uvstep/3,uvstep);
        if(parthf) {
            // セルフシャドウ mode2
#define sampleSelfShadowMode2(texuv) saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+(texuv)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f)
	        comp += sampleSelfShadowMode2(float2(0,0));
	        comp += sampleSelfShadowMode2(U);
	        comp += sampleSelfShadowMode2(-U);
	        comp += sampleSelfShadowMode2(V);
	        comp += sampleSelfShadowMode2(-V);
	        comp += sampleSelfShadowMode2(U+V);
	        comp += sampleSelfShadowMode2(-U+V);
	        comp += sampleSelfShadowMode2(-U-V);
	        comp += sampleSelfShadowMode2(U-V);
            comp = 1-saturate(comp/9);
        } else {
            // セルフシャドウ mode1
#define sampleSelfShadowMode1(texuv) saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+(texuv)).r , 0.0f)*SKII1-0.3f)
	        comp += sampleSelfShadowMode1(float2(0,0));
	        comp += sampleSelfShadowMode1(U);
	        comp += sampleSelfShadowMode1(-U);
	        comp += sampleSelfShadowMode1(V);
	        comp += sampleSelfShadowMode1(-V);
	        comp += sampleSelfShadowMode1(U+V);
	        comp += sampleSelfShadowMode1(-U+V);
	        comp += sampleSelfShadowMode1(-U-V);
	        comp += sampleSelfShadowMode1(U-V);
            comp = 1-saturate(comp/9);
#else
#ifdef SOFT_SHADOW_PARAM
		float U = SOFT_SHADOW_PARAM / SHADOWMAP_SIZE;
		float V = SOFT_SHADOW_PARAM / SHADOWMAP_SIZE;
#endif
        if(parthf) {
            // セルフシャドウ mode2
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,0)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
#ifdef SOFT_SHADOW_PARAM
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,0)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,0)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,-V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,-V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,-V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
            comp = 1-saturate(comp/9);
#else
            comp = 1-saturate(comp);
#endif
        } else {
            // セルフシャドウ mode1
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,0)).r , 0.0f)*SKII1-0.3f);
#ifdef SOFT_SHADOW_PARAM
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,0)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,0)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,V)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,-V)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,V)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,V)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,-V)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,-V)).r , 0.0f)*SKII1-0.3f);
            comp = 1-saturate(comp/9);
#else
            comp = 1-saturate(comp);
#endif
#endif
        }
        if ( useToon ) {
            // トゥーン適用
            comp = min(saturate(dot(normal,-LightDirection)*Toon),comp);
            ShadowColor.rgb *= MaterialToon;
        }

        float4 ans = lerp(ShadowColor, Color, comp);
        if( transp ) ans.a = 0.5f;
        return ans;
    }
}

/*
// オブジェクト描画用テクニック（アクセサリ用）
technique MainTecBS0  < string MMDPass = "object_ss"; bool UseTexture = false; bool UseSphereMap = false; bool UseToon = false; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(false, false, false);
        PixelShader  = compile ps_3_0 BufferShadow_PS(false, false, false);
    }
}

technique MainTecBS1  < string MMDPass = "object_ss"; bool UseTexture = true; bool UseSphereMap = false; bool UseToon = false; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(true, false, false);
        PixelShader  = compile ps_3_0 BufferShadow_PS(true, false, false);
    }
}

technique MainTecBS2  < string MMDPass = "object_ss"; bool UseTexture = false; bool UseSphereMap = true; bool UseToon = false; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(false, true, false);
        PixelShader  = compile ps_3_0 BufferShadow_PS(false, true, false);
    }
}

technique MainTecBS3  < string MMDPass = "object_ss"; bool UseTexture = true; bool UseSphereMap = true; bool UseToon = false; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(true, true, false);
        PixelShader  = compile ps_3_0 BufferShadow_PS(true, true, false);
    }
}

// オブジェクト描画用テクニック（PMDモデル用）
technique MainTecBS4  < string MMDPass = "object_ss"; bool UseTexture = false; bool UseSphereMap = false; bool UseToon = true; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(false, false, true);
        PixelShader  = compile ps_3_0 BufferShadow_PS(false, false, true);
    }
}

technique MainTecBS5  < string MMDPass = "object_ss"; bool UseTexture = true; bool UseSphereMap = false; bool UseToon = true; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(true, false, true);
        PixelShader  = compile ps_3_0 BufferShadow_PS(true, false, true);
    }
}

technique MainTecBS6  < string MMDPass = "object_ss"; bool UseTexture = false; bool UseSphereMap = true; bool UseToon = true; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(false, true, true);
        PixelShader  = compile ps_3_0 BufferShadow_PS(false, true, true);
    }
}

technique MainTecBS7  < string MMDPass = "object_ss"; bool UseTexture = true; bool UseSphereMap = true; bool UseToon = true; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(true, true, true);
        PixelShader  = compile ps_3_0 BufferShadow_PS(true, true, true);
    }
}
*/

// オブジェクト描画用テクニック
#define SS_MACRO_TEC(num, tex, sphere, toon) \
technique NormalMap_MainTecSS##num < \
 string Subset = TARGET_MATERIALS; string MMDPass = "object_ss"; \
 bool UseTexture = tex; bool UseSphereMap = sphere; bool UseToon = toon; > { \
    pass DrawObject { \
        VertexShader = compile vs_3_0 BufferShadow_VS(tex, sphere, toon); \
        PixelShader  = compile ps_3_0 BufferShadow_PS(tex, sphere, toon); \
    } \
}

// オブジェクト描画用テクニック（アクセサリ用）
SS_MACRO_TEC(0, false, false, false)
SS_MACRO_TEC(1, true,  false, false)
SS_MACRO_TEC(2, false, true,  false)
SS_MACRO_TEC(3, true,  true,  false)
// オブジェクト描画用テクニック（PMD/PMXモデル用）
SS_MACRO_TEC(4, false, false, true)
SS_MACRO_TEC(5, true,  false, true)
SS_MACRO_TEC(6, false, true,  true)
SS_MACRO_TEC(7, true,  true,  true)


///////////////////////////////////////////////////////////////////////////////////////////////
