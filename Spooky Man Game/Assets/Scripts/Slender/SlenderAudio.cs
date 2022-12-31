using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SlenderAudio : MonoBehaviour
{
    [SerializeField] private AudioSource audioScream;
    [SerializeField] private AudioSource audioLookAt;
    [SerializeField] private AudioSource audioAttack;
    [SerializeField] private AudioSource audioSpawn;

   
    public void PlaySlenderLookAtSound()
    {
        audioLookAt.PlayOneShot(audioLookAt.clip);
    }

    public void StopSlenderLookAtSound()
    {
        audioLookAt.Stop();
    }

    public void PlaySlenderScream()
    {
        audioScream.PlayOneShot(audioScream.clip);
    }

    public void StopSlenderScream()
    {
        audioScream.Stop();
    }

    public void PlaySlenderAttackSound()
    {
        if(!audioAttack.isPlaying)
            audioAttack.PlayOneShot(audioAttack.clip);
    }

    public void StopSlenderAttackSound()
    {
        audioAttack.Stop();
    }
}
