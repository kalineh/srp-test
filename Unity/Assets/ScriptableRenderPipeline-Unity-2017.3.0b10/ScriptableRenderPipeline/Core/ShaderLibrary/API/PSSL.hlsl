// This file assume SHADER_API_D3D11 is defined

#define INTRINSIC_BITFIELD_EXTRACT
#define INTRINSIC_WAVEREADFIRSTLANE
#define WaveReadFirstLane ReadFirstLane
#define INTRINSIC_MAD24
#define Mad24 mad24
#define INTRINSIC_MINMAX3
#define Min3 min3
#define Max3 max3
//#define INTRINSIC_CUBEMAP_FACE_ID // Must investigate why AMD reference implementation is different than ours

#define UNITY_UV_STARTS_AT_TOP 1
#define UNITY_REVERSED_Z 1
#define UNITY_NEAR_CLIP_VALUE (1.0)
// This value will not go through any matrix projection convertion
#define UNITY_RAW_FAR_CLIP_VALUE (0.0)
#define FRONT_FACE_SEMATIC SV_IsFrontFace
#define FRONT_FACE_TYPE bool
#define IS_FRONT_VFACE(VAL, FRONT, BACK) ((VAL) ? (FRONT) : (BACK))

#define CBUFFER_START(name) cbuffer name {
#define CBUFFER_END };

// Initialize arbitrary structure with zero values.
// Do not exist on some platform, in this case we need to have a standard name that call a function that will initialize all parameters to 0
#define ZERO_INITIALIZE(type, name) name = (type)0;
#define ZERO_INITIALIZE_ARRAY(type, name, arraySize) { for (int arrayIndex = 0; arrayIndex < arraySize; arrayIndex++) { name[arrayIndex] = (type)0; } }

// Texture util abstraction

#define CALCULATE_TEXTURE2D_LOD(textureName, samplerName, coord2) textureName.GetLOD(samplerName, coord2)

// Texture abstraction

#define TEXTURE2D(textureName) Texture2D textureName
#define TEXTURE2D_ARRAY(textureName) Texture2DArray textureName
#define TEXTURECUBE(textureName) TextureCube textureName
#define TEXTURECUBE_ARRAY(textureName) TextureCubeArray textureName
#define TEXTURE3D(textureName) Texture3D textureName
#define RW_TEXTURE2D(type, textureName) RW_Texture2D<type> textureName

#define SAMPLER2D(samplerName) SamplerState samplerName
#define SAMPLERCUBE(samplerName) SamplerState samplerName
#define SAMPLER3D(samplerName) SamplerState samplerName
#define SAMPLER2D_SHADOW(samplerName) SamplerComparisonState samplerName
#define SAMPLERCUBE_SHADOW(samplerName) SamplerComparisonState samplerName

#define TEXTURE2D_ARGS(textureName, samplerName) Texture2D textureName, SamplerState samplerName
#define TEXTURE2D_ARRAY_ARGS(textureName, samplerName) Texture2DArray textureName, SamplerState samplerName
#define TEXTURECUBE_ARGS(textureName, samplerName) TextureCube textureName, SamplerState samplerName
#define TEXTURECUBE_ARRAY_ARGS(textureName, samplerName) TextureCubeArray textureName, SamplerState samplerName
#define TEXTURE3D_ARGS(textureName, samplerName) Texture3D textureName, SamplerState samplerName
#define TEXTURE2D_SHADOW_ARGS(textureName, samplerName) Texture2D textureName, SamplerComparisonState samplerName
#define TEXTURE2D_ARRAY_SHADOW_ARGS(textureName, samplerName) Texture2DArray textureName, SamplerComparisonState samplerName
#define TEXTURECUBE_SHADOW_ARGS(textureName, samplerName) TextureCube textureName, SamplerComparisonState samplerName

#define TEXTURE2D_PARAM(textureName, samplerName) textureName, samplerName
#define TEXTURE2D_ARRAY_PARAM(textureName, samplerName) textureName, samplerName
#define TEXTURECUBE_PARAM(textureName, samplerName) textureName, samplerName
#define TEXTURECUBE_ARRAY_PARAM(textureName, samplerName) textureName, samplerName
#define TEXTURE3D_PARAM(textureName, samplerName) textureName, samplerName
#define TEXTURE2D_SHADOW_PARAM(textureName, samplerName) textureName, samplerName
#define TEXTURE2D_ARRAY_SHADOW_PARAM(textureName, samplerName) textureName, samplerName
#define TEXTURECUBE_SHADOW_PARAM(textureName, samplerName) textureName, samplerName

#define SAMPLE_TEXTURE2D(textureName, samplerName, coord2) textureName.Sample(samplerName, coord2)
#define SAMPLE_TEXTURE2D_LOD(textureName, samplerName, coord2, lod) textureName.SampleLevel(samplerName, coord2, lod)
#define SAMPLE_TEXTURE2D_BIAS(textureName, samplerName, coord2, bias) textureName.SampleBias(samplerName, coord2, bias)
#define SAMPLE_TEXTURE2D_GRAD(textureName, samplerName, coord2, ddx, ddy) textureName.SampleGrad(samplerName, coord2, ddx, ddy)
#define SAMPLE_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index) textureName.Sample(samplerName, float3(coord2, index))
#define SAMPLE_TEXTURE2D_ARRAY_LOD(textureName, samplerName, coord2, index, lod) textureName.SampleLevel(samplerName, float3(coord2, index), lod)
#define SAMPLE_TEXTURE2D_ARRAY_BIAS(textureName, samplerName, coord2, index, bias) textureName.SampleBias(samplerName, float3(coord2, index), bias)
#define SAMPLE_TEXTURECUBE(textureName, samplerName, coord3) textureName.Sample(samplerName, coord3)
#define SAMPLE_TEXTURECUBE_LOD(textureName, samplerName, coord3, lod) textureName.SampleLevel(samplerName, coord3, lod)
#define SAMPLE_TEXTURECUBE_BIAS(textureName, samplerName, coord3, bias) textureName.SampleBias(samplerName, coord3, bias)
#define SAMPLE_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index) textureName.Sample(samplerName, float4(coord3, index))
#define SAMPLE_TEXTURECUBE_ARRAY_LOD(textureName, samplerName, coord3, index, lod) textureName.SampleLevel(samplerName, float4(coord3, index), lod)
#define SAMPLE_TEXTURECUBE_ARRAY_BIAS(textureName, samplerName, coord3, index, bias) textureName.SampleBias(samplerName, float4(coord3, index), bias)
#define SAMPLE_TEXTURE3D(textureName, samplerName, coord3) textureName.Sample(samplerName, coord3)
#define SAMPLE_TEXTURE2D_SHADOW(textureName, samplerName, coord3) textureName.SampleCmpLevelZero(samplerName, (coord3).xy, (coord3).z)
#define SAMPLE_TEXTURE2D_ARRAY_SHADOW(textureName, samplerName, coord3, index) textureName.SampleCmpLevelZero(samplerName, float3((coord3).xy, index), (coord3).z)
#define SAMPLE_TEXTURECUBE_SHADOW(textureName, samplerName, coord4) textureName.SampleCmpLevelZero(samplerName, (coord3).xyz, (coord3).w)
#define SAMPLE_TEXTURECUBE_ARRAY_SHADOW(textureName, samplerName, coord4, index) textureName.SampleCmpLevelZero(samplerName, float4((coord4).xyz, index), (coord4).w)

#define TEXTURE2D_HALF TEXTURE2D
#define TEXTURE2D_FLOAT TEXTURE2D
#define TEXTURE3D_HALF TEXTURE3D
#define TEXTURE3D_FLOAT TEXTURE3D
#define SAMPLER2D_HALF SAMPLER2D
#define SAMPLER2D_FLOAT SAMPLER2D

#define LOAD_TEXTURE2D(textureName, unCoord2) textureName.Load(int3(unCoord2, 0))
#define LOAD_TEXTURE2D_LOD(textureName, unCoord2, lod) textureName.Load(int3(unCoord2, lod))
#define LOAD_TEXTURE2D_MSAA(textureName, unCoord2, sampleIndex) textureName.Load(unCoord2, sampleIndex)
#define LOAD_TEXTURE2D_ARRAY(textureName, unCoord2, index) textureName.Load(int4(unCoord2, index, 0))
#define LOAD_TEXTURE2D_ARRAY_LOD(textureName, unCoord2, index, lod) textureName.Load(int4(unCoord2, index, lod))

#define GATHER_TEXTURE2D(textureName, samplerName, coord2) textureName.Gather(samplerName, coord2)
#define GATHER_TEXTURE2D_ARRAY(textureName, samplerName, coord2, index) textureName.Gather(samplerName, float3(coord2, index))
#define GATHER_TEXTURECUBE(textureName, samplerName, coord3) textureName.Gather(samplerName, coord3)
#define GATHER_TEXTURECUBE_ARRAY(textureName, samplerName, coord3, index) textureName.Gather(samplerName, float4(coord3, index))
