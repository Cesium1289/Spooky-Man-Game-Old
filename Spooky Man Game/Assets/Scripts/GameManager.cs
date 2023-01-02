using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    // Start is called before the first frame update
    GameObject mDirectionalLight;
    AudioSource mAudioSource;

    private void Start()
    {
        PageManager manager = FindObjectOfType<PageManager>();
        manager.OnCollectedAllPagesEvent += PlayVictorySound;
        mAudioSource = GetComponent<AudioSource>();
    }
    void Awake()
    {
        //SetupDirectionalLight();
    }

    private void PlayVictorySound()
    {
        mAudioSource.Play();
    }

    private void SetupDirectionalLight()
    {
        // mDirectionalLight = new GameObject("Directional light");
        // Light light = mDirectionalLight.AddComponent<Light>();
        mDirectionalLight = GameObject.Find("Directional Light");
        if (mDirectionalLight)
            Debug.Log("found");
        else
            Debug.Log("not found");
      //  mDirectionalLight.SetActive(false);
    }


    public void SpawnSlenderMan()
    {
        GameObject slender = new GameObject("Slender");
        Slender sl = slender.AddComponent<Slender>();
    }
}
