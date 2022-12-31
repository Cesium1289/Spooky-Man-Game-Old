using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(AudioSource))]
public class ObjectSounds : MonoBehaviour
{
    public bool mCanPlaySound;
    [SerializeField] AudioSource mAudio;
    // Start is called before the first frame update
    void Start()
    {
        mAudio = GetComponent<AudioSource>();
        mCanPlaySound = true;
    }

    public void PlayAudio()
    {
        Debug.Log("play audio");
        if (mCanPlaySound && !mAudio.isPlaying)
        {
            mAudio.Play();
            mCanPlaySound = false;
        }
    }
   
}
