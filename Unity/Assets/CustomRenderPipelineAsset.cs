using System;
using UnityEngine;
using UnityEngine.Experimental.Rendering;

public enum ShadowCascades
{
    NO_CASCADES = 1,
    TWO_CASCADES = 2,
    FOUR_CASCADES = 4,
}

public enum ShadowType
{
    NO_SHADOW = 0,
    HARD_SHADOWS,
    SOFT_SHADOWS,
}

public enum ShadowResolution
{
    _512 = 512,
    _1024 = 1024,
    _2048 = 2048
}

public enum MSAAQuality
{
    Disabled = 1,
    _2x = 2,
    _4x = 4,
    _8x = 8
}

public class CustomRenderPipelineAsset : UnityEngine.Experimental.Rendering.RenderPipelineAsset
{
#if UNITY_EDITOR
        [UnityEditor.MenuItem("RenderPipeline/CustomRender Pipeline/Create Pipeline Asset", false, 15)]
        static void CreateCustomRenderPipeline()
        {
            var instance = CreateInstance<CustomRenderPipelineAsset>();
            instance.m_DefaultShader = Shader.Find(m_StandardShaderPath);
            instance.m_BlitShader = Shader.Find("CustomRender/CustomRenderPipeline/Blit");
            instance.m_CopyDepthShader = Shader.Find("CustomRender/CustomRenderPipeline/CopyDepth");

            string path = UnityEditor.EditorUtility.SaveFilePanelInProject("Save CustomRenderPipeline Asset", "CustomRenderPipelineAsset", "asset",
                "Please enter a file name to save the asset to");

            if (path.Length > 0)
                UnityEditor.AssetDatabase.CreateAsset(instance, path);
        }
#endif

    public static readonly string m_SimpleLightShaderPath = "CustomRenderPipeline/CustomRenderPipelineToon";
    public static readonly string m_StandardShaderPath = "CustomRenderPipeline/CustomRenderPipelineToon";

    // Default values set when a new LightweightPipeline asset is created
    [SerializeField] private int m_MaxPixelLights = 4;
    [SerializeField] private bool m_SupportsVertexLight = false;
    [SerializeField] private bool m_SupportSoftParticles = false;
    [SerializeField] private MSAAQuality m_MSAA = MSAAQuality._4x;
    [SerializeField] private float m_RenderScale = 1.0f;
    [SerializeField] private ShadowType m_ShadowType = ShadowType.HARD_SHADOWS;
    [SerializeField] private ShadowResolution m_ShadowAtlasResolution = ShadowResolution._1024;
    [SerializeField] private float m_ShadowNearPlaneOffset = 2.0f;
    [SerializeField] private float m_ShadowDistance = 50.0f;
    [SerializeField] private ShadowCascades m_ShadowCascades = ShadowCascades.NO_CASCADES;
    [SerializeField] private float m_Cascade2Split = 0.25f;
    [SerializeField] private Vector3 m_Cascade4Split = new Vector3(0.067f, 0.2f, 0.467f);

    [SerializeField] private Material m_DefaultMaterial;
    [SerializeField] private Material m_DefaultParticleMaterial;
    [SerializeField] private Material m_DefaultTerrainMaterial;

    // Resources
    [SerializeField] private Shader m_DefaultShader;
    [SerializeField] private Shader m_BlitShader;
    [SerializeField] private Shader m_CopyDepthShader;

    protected override IRenderPipeline InternalCreatePipeline()
    {
        return new CustomRenderPipeline(this);
    }

    void OnValidate()
    {
        DestroyCreatedInstances();
    }

    public bool AreShadowsEnabled()
    {
        return ShadowSetting != ShadowType.NO_SHADOW;
    }

    public int MaxPixelLights
    {
        get { return m_MaxPixelLights; }
    }

    public bool SupportsVertexLight
    {
        get { return m_SupportsVertexLight; }
    }

    public bool SupportsSoftParticles
    {
        get { return m_SupportSoftParticles; }
    }

    public int MSAASampleCount
    {
        get { return (int)m_MSAA; }
        set { m_MSAA = (MSAAQuality)value; }
    }

    public float RenderScale
    {
        get { return m_RenderScale; }
        set { m_RenderScale = value; }
    }

    public ShadowType ShadowSetting
    {
        get { return m_ShadowType; }
        private set { m_ShadowType = value; }
    }

    public int ShadowAtlasResolution
    {
        get { return (int)m_ShadowAtlasResolution; }
        private set { m_ShadowAtlasResolution = (ShadowResolution)value; }
    }

    public float ShadowNearOffset
    {
        get { return m_ShadowNearPlaneOffset; }
        private set { m_ShadowNearPlaneOffset = value; }
    }

    public float ShadowDistance
    {
        get { return m_ShadowDistance; }
        private set { m_ShadowDistance = value; }
    }

    public int CascadeCount
    {
        get { return (int)m_ShadowCascades; }
        private set { m_ShadowCascades = (ShadowCascades)value; }
    }

    public float Cascade2Split
    {
        get { return m_Cascade2Split; }
        private set { m_Cascade2Split = value; }
    }

    public Vector3 Cascade4Split
    {
        get { return m_Cascade4Split; }
        private set { m_Cascade4Split = value; }
    }

    public override Material GetDefaultMaterial()
    {
        return m_DefaultMaterial;
    }

    public override Material GetDefaultParticleMaterial()
    {
        return m_DefaultParticleMaterial;
    }

    public override Material GetDefaultLineMaterial()
    {
        return null;
    }

    public override Material GetDefaultTerrainMaterial()
    {
        return m_DefaultTerrainMaterial;
    }

    public override Material GetDefaultUIMaterial()
    {
        return null;
    }

    public override Material GetDefaultUIOverdrawMaterial()
    {
        return null;
    }

    public override Material GetDefaultUIETC1SupportedMaterial()
    {
        return null;
    }

    public override Material GetDefault2DMaterial()
    {
        return null;
    }
    public override Shader GetDefaultShader()
    {
        return m_DefaultShader;
    }

    public Shader BlitShader
    {
        get { return m_BlitShader; }
    }

    public Shader CopyDepthShader
    {
        get { return m_CopyDepthShader; }
    }
}
