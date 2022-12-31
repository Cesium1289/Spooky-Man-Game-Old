using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.Interaction.Toolkit;

[RequireComponent(typeof(XRGrabInteractable))]
[RequireComponent(typeof(Rigidbody))]
[RequireComponent(typeof(AudioSource))]
public class InteractableObject : MonoBehaviour
{
    protected AudioSource mAudioSource;
    [SerializeField] AudioClip pickUpNoise;
    [SerializeField] AudioClip breakNoise;
    [SerializeField] public bool hasDestroyNoise;
    public bool shouldPlayPickUpSound;
    protected Rigidbody mRigidBody;
    // Start is called before the first frame update
    void Awake()
    {
        mAudioSource = GetComponent<AudioSource>();
        mRigidBody = GetComponent<Rigidbody>();
        shouldPlayPickUpSound = true;
    }

    virtual public void HandlePickUp()
    {
        Debug.Log("Virtual Handlepick up!");
    }
    public void PlayPickUpAudio()
    {
        // mAudioSource.Play();
        Debug.Log("f in the chat");
        if (pickUpNoise && shouldPlayPickUpSound)
        {
            Debug.Log("we should play some pick up audio!");
            if (mAudioSource.isPlaying)
                mAudioSource.Stop();
            mAudioSource.PlayOneShot(pickUpNoise);
            shouldPlayPickUpSound = false;
        }
       
    }
}
