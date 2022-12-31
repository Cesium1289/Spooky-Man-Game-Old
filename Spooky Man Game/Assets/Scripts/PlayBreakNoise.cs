using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayBreakNoise : MonoBehaviour
{
    Rigidbody rb;
    new AudioSource audio;
    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody>();
        audio = GetComponent<AudioSource>();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnCollisionEnter(Collision collision)
    {
        if(collision.gameObject.tag == "Slender" && !rb.IsSleeping())
        {
          //  if (!audio.isPlaying)
              //  audio.PlayOneShot(audio.clip);
        }
    }

    public void PlaySound()
    {
        if (!audio.isPlaying)
            audio.PlayOneShot(audio.clip);
    }
}
