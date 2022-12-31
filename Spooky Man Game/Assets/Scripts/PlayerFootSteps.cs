using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerFootSteps : MonoBehaviour
{

    private CharacterController cc;
    [SerializeField] private new AudioSource audio;
    // Start is called before the first frame update
    void Start()
    {
        cc = GetComponent<CharacterController>();
    }

    // Update is called once per frame
    void Update()
    {
        if(cc.isGrounded && cc.velocity.magnitude > 2f && !audio.isPlaying)
        {
            audio.volume = Random.Range(0.3f, 0.6f);
            audio.pitch = Random.Range(0.8f, 1.1f);
            audio.Play();
        }
    }
}
