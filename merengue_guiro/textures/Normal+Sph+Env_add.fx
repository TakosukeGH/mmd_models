////////////////////////////////////////////////////////////////////////////////////////////////
//  �m�[�}���}�b�v�{�X�t�B�A�G�t�F�N�g v0.60
//	�쐬�F�ނ�����
//  ���͉��P full.fx ver1.4 + �r�[���}��P SimpleSoftShadow + Tilt���� + �ގ����[�t�Ή�
//  + Furia���m�[�}���}�b�v���� + �m�[�}���}�b�v���W��ʑΉ�
//  + �m�[�}���}�b�v�Ɗ��}�b�v�D�荞�݃X�t�B�A�}�b�v
//	+ ���}�b�v
//
//
////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////// �\�t�g�V���h�E�֘A ///////////////////
//�\�t�g�V���h�E�p�ڂ����� ����//��t����ƃ\�t�g�V���h�E����
#define SOFT_SHADOW_PARAM 0.5
//�\�t�g�V���h�E�ł̃T���v�����OUV���W���X���邱�ƂŁA�ߋ����ł̃W���M�[���y������
//����//��t����ƃe�B���g����
#define TILT_SOFTSHADOW 1
//�V���h�E�}�b�v�T�C�Y
//�ʏ�F1024 CTRL+G�ŉ𑜓x���グ���ꍇ 4096
#define SHADOWMAP_SIZE 1024


//////////////////////// �m�[�}���}�b�v�֘A ///////////////////
// �m�[�}���}�b�v�e�N�X�`���t�@�C���� �g��Ȃ��Ƃ��͍s����//������
#define NORMALMAP_FILE "normal.png"

// �g�p����m�[�}���}�b�v�̍��W��ʁF�Y������s�̂ݍs����//���폜����
// ����/���F�̌����ォ��A��/�s���N�̌����E���獷������ł���悤�Ɍ�����
// �m�[�}���}�b�v(Blender bake�Ȃ�)
#define NORMALMAP_COORDINATE float3(-2,2,2)
// ����/���F�̌����ォ��A��/�s���N�̌��������獷������ł���悤�Ɍ�����
// �m�[�}���}�b�v(Photoshop�v���O�C���Ȃ�)
//#define NORMALMAP_COORDINATE float3(2,2,2)
// ����/���F�̌���������A��/�s���N�̌����E���獷������ł���悤�Ɍ�����
// �m�[�}���}�b�v(nvDXT�Ȃ�)
//#define NORMALMAP_COORDINATE float3(-2,-2,2)

//�e�N�X�`���㉺���E�[�̏������@�B�^�C���p�^�[���̏ꍇWRAP�A����ȊO�͒ʏ�CLAMP�̂ق����悢�B
#define TEXADDRESS_U WRAP
#define TEXADDRESS_V WRAP

//////////////////////// �ގ��ݒ�֘A ///////////////////
// ���ːF�B�A�N�Z�T���Ŕ��ːF�ݒ���g�������Ƃ��w�肵�܂��B
// ���f���ގ��l���g�p����(PMD,PMX)�ꍇ�͍s����//������
#define MATERIAL_SPECULAR_COLOR float3(0.8,0.8,0.8)

// �u���Z�X�t�B�A�̃������Z �v���ʁB�����x�̍����ގ��ŕs�����Ȍ�����o���̂Ɏg�p����B
// �A���t�@�l(�s�����x)�̐ݒ肳�ꂽ�X�t�B�A�}�b�v���K�v�ŁA����ɍ��킹�Ē�������B
// ���Z�X�t�B�A�̃A���t�@(�s�����x)�𑫂����ދ������w�肷��B�g��Ȃ��Ƃ��͍s����//������
#define SPHERE_ADD_ALPHA 2

//////////////////////// ���}�b�v�֘A ///////////////////
// ���}�b�v�e�N�X�`���t�@�C���� ���}�b�v���g��Ȃ��Ƃ��͍s����//������
#define ENVMAP_FILE "metal_real019.bmp"

// ���ːF�ɐD�荞�ފ��}�b�v�̋���(0��0%�A1.0��100%) ���˂Ȃ̂ŁA���ʂ̏o����������͌�����B
// �����ɂ���ɂ�0�ɂ���̂ł͂Ȃ��s����//������
//#define SPECULAR_ENVMAP_RATE 0.25

// �X�t�B�A�ɐD�荞�ފ��}�b�v�̋���((0��0%�A1.0��100%) �X�t�B�A���ʂɊ��}�b�v�̌��ʂ��ǉ�����Ƃ��g�p����B
// ���Ԃ���Z�X�t�B�A�ł������ɗ����Ȃ��B�����ɂ���ɂ�0�ɂ���̂ł͂Ȃ��s����//������
#define SPHERE_ENVMAP_RATE 0.5


//�\���i���ݒ�////////////////////////////////////////////////////////////////////
// �~�b�v�}�b�v�F��ɉ������ł̃e�N�X�`���̃��A����W���M�[��}������B
// �~�b�v���x���F�����t��(0)�Œ�ł悢�B
#define MIPLEVELS 0

// �t�B���^�ݒ� �ȉ��R����I��
//�ٕ������t�B���^�i���ב�j
//#define TEXFILTER_SETTING ANISOTROPIC
//�o�C���j�A�i�ȈՂȂ߂炩�\���F�W���j
#define TEXFILTER_SETTING LINEAR
//�j�A���X�g�l�C�o�[�i��������\���F�e�N�X�`���̃h�b�g���Y��ɏo��j
//#define TEXFILTER_SETTING POINT

//�ٕ������t�B���^���g���Ƃ��̔{��
//1:Off or 2�̔{���Ŏw��(�傫���قǂȂ߂炩���ʁE���ב�)
//�Ή����Ă��邩�ǂ����́A�n�[�h�E�F�A����iRadeonHD�@��Ȃ�16�܂ł͑Ή����Ă���͂�
#define TEXFILTER_MAXANISOTROPY 4


//////////////////////// ���̑� ///////////////////
//�{�G�t�F�N�g��K�p����ގ��ԍ��iMME���t�@�����X Subset���Q�Ɓj
#define TARGET_MATERIALS "0-"

//////////// ���������̓G�t�F�N�g�̒m��������l�ȊO�͐G��Ȃ��ق����ǂ�
// �p�����[�^�錾

// ���@�ϊ��s��
float4x4 WorldViewProjMatrix      : WORLDVIEWPROJECTION;
float4x4 WorldMatrix              : WORLD;
float4x4 ViewMatrix               : VIEW;
float4x4 LightWorldViewProjMatrix : WORLDVIEWPROJECTION < string Object = "Light"; >;

float3   LightDirection    : DIRECTION < string Object = "Light"; >;
float3   CameraPosition    : POSITION  < string Object = "Camera"; >;

// �}�e���A���F
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
// ���C�g�F
float3   LightDiffuse      : DIFFUSE   < string Object = "Light"; >;
float3   LightAmbient      : AMBIENT   < string Object = "Light"; >;
float3   LightSpecular     : SPECULAR  < string Object = "Light"; >;
//�ގ����[�t�̎擾
float4 EgColor;
float4 SpcColor;
bool use_toon;
// �K�p�F
static float4 DiffuseColor  = MaterialDiffuse  * float4(LightDiffuse, 1.0f);
static const float3 AmbientColorOriginal
 = saturate(MaterialAmbient * LightAmbient + MaterialEmmisive);
static const float3 AmbientColor = use_toon ? EgColor.rgb : AmbientColorOriginal;
static const float3 SpecularColorOriginal
 = MaterialSpecular * LightSpecular;
static const float3 SpecularColor = use_toon ? SpcColor.rgb : SpecularColorOriginal;


bool     parthf;   // �p�[�X�y�N�e�B�u�t���O
bool     transp;   // �������t���O
bool	 spadd;    // �X�t�B�A�}�b�v���Z�����t���O
#define SKII1    1500
#define SKII2    8000
#define Toon     3

// �I�u�W�F�N�g�̃e�N�X�`��
texture ObjectTexture: MATERIALTEXTURE;
sampler ObjTexSampler = sampler_state {
    texture = <ObjectTexture>;
    MINFILTER = LINEAR;
    MAGFILTER = LINEAR;
};

// �X�t�B�A�}�b�v�̃e�N�X�`��
texture ObjectSphereMap: MATERIALSPHEREMAP;
sampler ObjSphareSampler = sampler_state {
    texture = <ObjectSphereMap>;
    MINFILTER = LINEAR;
    MAGFILTER = LINEAR;
};

// MMD�{����sampler���㏑�����Ȃ����߂̋L�q�ł��B�폜�s�B
sampler MMDSamp0 : register(s0);
sampler MMDSamp1 : register(s1);
sampler MMDSamp2 : register(s2);


//////////////�e�N�X�`����`/////////////////////////////////////////
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
//�ڋ�Ԏ擾
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

//���}�b�v�擾
#if defined(ENVMAP_FILE)
float4 samplingEnvMap(float3 RefDir)
{
    return tex2D(EnvMapTexSampler1,(1-pow(RefDir.y,2))*float2(0.9*0.25,0.9*-0.5)*RefDir.xz+float2(RefDir.y>0?0.25:0.75,0.5));
    //Specular += tex2D(EnvMapTexSampler1,float2(0.9*0.25*0.25,0.9*-0.5*0.25)*normal.xz+float2(0.5,normal.y>0?0.25/2:1-0.25/2));
}
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
// �֊s�`��

// ���_�V�F�[�_
float4 ColorRender_VS(float4 Pos : POSITION) : POSITION
{
    // �J�������_�̃��[���h�r���[�ˉe�ϊ�
    return mul( Pos, WorldViewProjMatrix );
}

// �s�N�Z���V�F�[�_
float4 ColorRender_PS() : COLOR
{
    // �֊s�F�œh��Ԃ�
    return EdgeColor;
}

// �֊s�`��p�e�N�j�b�N
technique EdgeTec < string MMDPass = "edge"; > {
    pass DrawEdge {
        AlphaBlendEnable = FALSE;
        AlphaTestEnable  = FALSE;

        VertexShader = compile vs_2_0 ColorRender_VS();
        PixelShader  = compile ps_2_0 ColorRender_PS();
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////
// �e�i��Z���t�V���h�E�j�`��

// ���_�V�F�[�_
float4 Shadow_VS(float4 Pos : POSITION) : POSITION
{
    // �J�������_�̃��[���h�r���[�ˉe�ϊ�
    return mul( Pos, WorldViewProjMatrix );
}

// �s�N�Z���V�F�[�_
float4 Shadow_PS() : COLOR
{
    // �A���r�G���g�F�œh��Ԃ�
    return float4(AmbientColor.rgb, 0.65f);
}

// �e�`��p�e�N�j�b�N
technique ShadowTec < string MMDPass = "shadow"; > {
    pass DrawShadow {
        VertexShader = compile vs_2_0 Shadow_VS();
        PixelShader  = compile ps_2_0 Shadow_PS();
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////
// �I�u�W�F�N�g�`��i�Z���t�V���h�EOFF�j

struct VS_OUTPUT {
    float4 Pos        : POSITION;    // �ˉe�ϊ����W
    float2 Tex        : TEXCOORD1;   // �e�N�X�`��
    float3 Normal     : TEXCOORD2;   // �@��
    float3 Eye        : TEXCOORD3;   // �J�����Ƃ̑��Έʒu
//    float2 SpTex      : TEXCOORD4;	 // �X�t�B�A�}�b�v�e�N�X�`�����W
    float4 Color      : COLOR0;      // �f�B�t���[�Y�F
};

// ���_�V�F�[�_
VS_OUTPUT Basic_VS(float4 Pos : POSITION, float3 Normal : NORMAL, float2 Tex : TEXCOORD0, uniform bool useTexture, uniform bool useSphereMap, uniform bool useToon)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

    // �J�������_�̃��[���h�r���[�ˉe�ϊ�
    Out.Pos = mul( Pos, WorldViewProjMatrix );

    // �J�����Ƃ̑��Έʒu
    Out.Eye = CameraPosition - mul( Pos, WorldMatrix );
    // ���_�@��
    Out.Normal = normalize( mul( Normal, (float3x3)WorldMatrix ) );

    // �f�B�t���[�Y�F�{�A���r�G���g�F �v�Z
    Out.Color.rgb = AmbientColor;
    if ( !useToon ) {
        Out.Color.rgb += max(0,dot( Out.Normal, -LightDirection )) * DiffuseColor.rgb;
    }
    Out.Color.a = DiffuseColor.a;
    Out.Color = saturate( Out.Color );

    // �e�N�X�`�����W
    Out.Tex = Tex;

/* �m�[�}���}�b�v�܍��̂��߁A�s�N�Z���V�F�[�_�Ɉړ�
    if ( useSphereMap ) {
        // �X�t�B�A�}�b�v�e�N�X�`�����W
        float2 NormalWV = mul( Out.Normal, (float3x3)ViewMatrix );
        Out.SpTex.x = NormalWV.x * 0.5f + 0.5f;
        Out.SpTex.y = NormalWV.y * -0.5f + 0.5f;
    }
*/
    return Out;
}

// �s�N�Z���V�F�[�_
float4 Basic_PS(VS_OUTPUT IN, uniform bool useTexture, uniform bool useSphereMap, uniform bool useToon) : COLOR0
{

#ifdef NORMALMAP_FILE
	float3x3 tangentFrame = compute_tangent_frame(IN.Normal, IN.Eye, IN.Tex);
	float3 normal = normalize(mul(NORMALMAP_COORDINATE * (tex2D(NormalMapTexSampler1, IN.Tex) - 0.5f), tangentFrame));
#else
	float3 normal = normalize(IN.Normal);
#endif
    // �X�y�L�����F�v�Z
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
        // �e�N�X�`���K�p
        Color *= tex2D( ObjTexSampler, IN.Tex );
    }
    if ( useSphereMap ) {
        // �X�t�B�A�}�b�v�e�N�X�`�����W
        float2 NormalWV = mul( normal, (float3x3)ViewMatrix );
        float2 SpTex;
        SpTex.x = NormalWV.x * 0.5f + 0.5f;
        SpTex.y = NormalWV.y * -0.5f + 0.5f;
        // �X�t�B�A�}�b�v�K�p
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
        // �g�D�[���K�p
        float LightNormal = dot( normal, -LightDirection );
        //Color.rgb *= lerp(MaterialToon, float3(1,1,1), saturate(LightNormal * 16 + 0.5));
        // toon�̃O���f�[�V�����𔽉f�B full_v1.4.1.fx�Q�l
        Color.rgb *= tex2D(MMDSamp0, float2(0, 0.5 - LightNormal * 0.5) ).rgb;
    }

    // �X�y�L�����K�p
    Color.rgb += Specular;

    return Color;
}

/*
// �I�u�W�F�N�g�`��p�e�N�j�b�N�i�A�N�Z�T���p�j
// �s�v�Ȃ��͍̂폜��
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

// �I�u�W�F�N�g�`��p�e�N�j�b�N�iPMD���f���p�j
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

// �I�u�W�F�N�g�`��p�e�N�j�b�N
#define MACRO_TEC(num, tex, sphere, toon) \
technique NormalMap_MainTec##num < \
 string Subset = TARGET_MATERIALS; string MMDPass = "object"; \
 bool UseTexture = tex; bool UseSphereMap = sphere; bool UseToon = toon; > { \
    pass DrawObject { \
        VertexShader = compile vs_3_0 Basic_VS( tex, sphere, toon); \
        PixelShader  = compile ps_3_0 Basic_PS( tex, sphere, toon); \
    } \
}

// �I�u�W�F�N�g�`��p�e�N�j�b�N�i�A�N�Z�T���p�j
MACRO_TEC(0, false, false, false)
MACRO_TEC(1, true,  false, false)
MACRO_TEC(2, false, true,  false)
MACRO_TEC(3, true,  true,  false)
// �I�u�W�F�N�g�`��p�e�N�j�b�N�iPMD/PMX���f���p�j
MACRO_TEC(4, false, false, true)
MACRO_TEC(5, true,  false, true)
MACRO_TEC(6, false, true,  true)
MACRO_TEC(7, true,  true,  true)

///////////////////////////////////////////////////////////////////////////////////////////////
// �Z���t�V���h�E�pZ�l�v���b�g

struct VS_ZValuePlot_OUTPUT {
    float4 Pos : POSITION;              // �ˉe�ϊ����W
    float4 ShadowMapTex : TEXCOORD0;    // Z�o�b�t�@�e�N�X�`��
};

// ���_�V�F�[�_
VS_ZValuePlot_OUTPUT ZValuePlot_VS( float4 Pos : POSITION )
{
    VS_ZValuePlot_OUTPUT Out = (VS_ZValuePlot_OUTPUT)0;

    // ���C�g�̖ڐ��ɂ�郏�[���h�r���[�ˉe�ϊ�������
    Out.Pos = mul( Pos, LightWorldViewProjMatrix );

    // �e�N�X�`�����W�𒸓_�ɍ��킹��
    Out.ShadowMapTex = Out.Pos;

    return Out;
}

// �s�N�Z���V�F�[�_
float4 ZValuePlot_PS( float4 ShadowMapTex : TEXCOORD0 ) : COLOR
{
    // R�F������Z�l���L�^����
    return float4(ShadowMapTex.z/ShadowMapTex.w,0,0,1);
}

// Z�l�v���b�g�p�e�N�j�b�N
technique ZplotTec < string MMDPass = "zplot"; > {
    pass ZValuePlot {
        AlphaBlendEnable = FALSE;
        VertexShader = compile vs_2_0 ZValuePlot_VS();
        PixelShader  = compile ps_2_0 ZValuePlot_PS();
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////
// �I�u�W�F�N�g�`��i�Z���t�V���h�EON�j

// �V���h�E�o�b�t�@�̃T���v���B"register(s0)"�Ȃ̂�MMD��s0���g���Ă��邩��
sampler DefSampler : register(s0);

struct BufferShadow_OUTPUT {
    float4 Pos      : POSITION;     // �ˉe�ϊ����W
    float4 ZCalcTex : TEXCOORD0;    // Z�l
    float2 Tex      : TEXCOORD1;    // �e�N�X�`��
    float3 Normal   : TEXCOORD2;    // �@��
    float3 Eye      : TEXCOORD3;    // �J�����Ƃ̑��Έʒu
//    float2 SpTex    : TEXCOORD4;	 // �X�t�B�A�}�b�v�e�N�X�`�����W
    float4 Color    : COLOR0;       // �f�B�t���[�Y�F
};

// ���_�V�F�[�_
BufferShadow_OUTPUT BufferShadow_VS(float4 Pos : POSITION, float3 Normal : NORMAL, float2 Tex : TEXCOORD0, uniform bool useTexture, uniform bool useSphereMap, uniform bool useToon)
{
    BufferShadow_OUTPUT Out = (BufferShadow_OUTPUT)0;

    // �J�������_�̃��[���h�r���[�ˉe�ϊ�
    Out.Pos = mul( Pos, WorldViewProjMatrix );

    // �J�����Ƃ̑��Έʒu
    Out.Eye = CameraPosition - mul( Pos, WorldMatrix );
    // ���_�@��
    Out.Normal = normalize( mul( Normal, (float3x3)WorldMatrix ) );
	// ���C�g���_�ɂ�郏�[���h�r���[�ˉe�ϊ�
    Out.ZCalcTex = mul( Pos, LightWorldViewProjMatrix );

    // �f�B�t���[�Y�F�{�A���r�G���g�F �v�Z
    Out.Color.rgb = AmbientColor;
    if ( !useToon ) {
        Out.Color.rgb += max(0,dot( Out.Normal, -LightDirection )) * DiffuseColor.rgb;
    }
    Out.Color.a = DiffuseColor.a;
    Out.Color = saturate( Out.Color );

    // �e�N�X�`�����W
    Out.Tex = Tex;

/* �m�[�}���}�b�v�܍��̂��߁A�s�N�Z���V�F�[�_�Ɉړ�
    if ( useSphereMap ) {
        // �X�t�B�A�}�b�v�e�N�X�`�����W
        float2 NormalWV = mul( Out.Normal, (float3x3)ViewMatrix );
        Out.SpTex.x = NormalWV.x * 0.5f + 0.5f;
        Out.SpTex.y = NormalWV.y * -0.5f + 0.5f;
    }
*/

    return Out;
}




// �s�N�Z���V�F�[�_
float4 BufferShadow_PS(BufferShadow_OUTPUT IN, uniform bool useTexture, uniform bool useSphereMap, uniform bool useToon) : COLOR
{

#ifdef NORMALMAP_FILE
	float3x3 tangentFrame = compute_tangent_frame(IN.Normal, IN.Eye, IN.Tex);
	float3 normal = normalize(mul(NORMALMAP_COORDINATE * (tex2D(NormalMapTexSampler1, IN.Tex) - 0.5f), tangentFrame));
#else
	float3 normal = normalize(IN.Normal);
#endif
    // �X�y�L�����F�v�Z
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
    float4 ShadowColor = float4(AmbientColor, Color.a);  // �e�̐F
    if ( useTexture ) {
        // �e�N�X�`���K�p
        float4 TexColor = tex2D( ObjTexSampler, IN.Tex );
        Color *= TexColor;
        ShadowColor *= TexColor;
    }
    if ( useSphereMap ) {
        // �X�t�B�A�}�b�v�e�N�X�`�����W
        float2 NormalWV = mul( normal, (float3x3)ViewMatrix );
        float2 SpTex;
        SpTex.x = NormalWV.x * 0.5f + 0.5f;
        SpTex.y = NormalWV.y * -0.5f + 0.5f;
        // �X�t�B�A�}�b�v�K�p
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
    // �X�y�L�����K�p
    Color.rgb += Specular;

    // �e�N�X�`�����W�ɕϊ�
    IN.ZCalcTex /= IN.ZCalcTex.w;
    float2 TransTexCoord;
    TransTexCoord.x = (1.0f + IN.ZCalcTex.x)*0.5f;
    TransTexCoord.y = (1.0f - IN.ZCalcTex.y)*0.5f;

    if( any( saturate(TransTexCoord) != TransTexCoord ) ) {
        // �V���h�E�o�b�t�@�O
        return Color;
    } else {
        float comp = 0;
#if defined(SOFT_SHADOW_PARAM) && defined(TILT_SOFTSHADOW)
        float uvstep = SOFT_SHADOW_PARAM / SHADOWMAP_SIZE;
		float2 U = float2(uvstep,uvstep/3);
		float2 V = float2(-uvstep/3,uvstep);
        if(parthf) {
            // �Z���t�V���h�E mode2
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
            // �Z���t�V���h�E mode1
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
            // �Z���t�V���h�E mode2
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
            // �Z���t�V���h�E mode1
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
            // �g�D�[���K�p
            comp = min(saturate(dot(normal,-LightDirection)*Toon),comp);
            ShadowColor.rgb *= MaterialToon;
        }

        float4 ans = lerp(ShadowColor, Color, comp);
        if( transp ) ans.a = 0.5f;
        return ans;
    }
}

/*
// �I�u�W�F�N�g�`��p�e�N�j�b�N�i�A�N�Z�T���p�j
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

// �I�u�W�F�N�g�`��p�e�N�j�b�N�iPMD���f���p�j
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

// �I�u�W�F�N�g�`��p�e�N�j�b�N
#define SS_MACRO_TEC(num, tex, sphere, toon) \
technique NormalMap_MainTecSS##num < \
 string Subset = TARGET_MATERIALS; string MMDPass = "object_ss"; \
 bool UseTexture = tex; bool UseSphereMap = sphere; bool UseToon = toon; > { \
    pass DrawObject { \
        VertexShader = compile vs_3_0 BufferShadow_VS(tex, sphere, toon); \
        PixelShader  = compile ps_3_0 BufferShadow_PS(tex, sphere, toon); \
    } \
}

// �I�u�W�F�N�g�`��p�e�N�j�b�N�i�A�N�Z�T���p�j
SS_MACRO_TEC(0, false, false, false)
SS_MACRO_TEC(1, true,  false, false)
SS_MACRO_TEC(2, false, true,  false)
SS_MACRO_TEC(3, true,  true,  false)
// �I�u�W�F�N�g�`��p�e�N�j�b�N�iPMD/PMX���f���p�j
SS_MACRO_TEC(4, false, false, true)
SS_MACRO_TEC(5, true,  false, true)
SS_MACRO_TEC(6, false, true,  true)
SS_MACRO_TEC(7, true,  true,  true)


///////////////////////////////////////////////////////////////////////////////////////////////
