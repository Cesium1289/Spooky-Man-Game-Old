using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.XR.Interaction.Toolkit;

[RequireComponent(typeof(Animator))]

public class Hand : MonoBehaviour
{
    List<GameObject> mHeldObjects;
    Animator animator;
    public XRRayInteractor interactor;
    private float gripTarget;
    private float triggerTarget;
    private float gripCurrent;
    private float triggerCurrent;
    public float speed;
    PageCountDisplay mPageCountDisplay;

    // Start is called before the first frame update
    void Start()
    {
        Application.targetFrameRate = 300;
        mHeldObjects = new List<GameObject>();
        animator = GetComponent<Animator>();     
        mPageCountDisplay = FindObjectOfType<PageCountDisplay>();
    }

    // Update is called once per frame
    [Obsolete]
    void Update()
    {
        AnimateHand();
        Grabbing();
    }

    internal void SetGrip(float v)
    {
        gripTarget = v;
    }

    internal void SetTrigger(float v)
    {
        triggerTarget = v;
    }

    void AnimateHand()
    {
        if(gripCurrent != gripTarget)
        {
            gripCurrent = Mathf.MoveTowards(gripCurrent, gripTarget, Time.deltaTime * speed);
            animator.SetFloat("Grip", gripCurrent);
        }
        if (triggerCurrent != triggerTarget)
        {
            if (triggerCurrent > 0.1f)
                mPageCountDisplay.ToggleUi();
            else
                mPageCountDisplay.DisableUi();

                triggerCurrent = Mathf.MoveTowards(triggerCurrent, triggerTarget, Time.deltaTime * speed);
            animator.SetFloat("Trigger", triggerCurrent);
        }
    }
    //checks whether or not a vr hand is holding an object
    [Obsolete]
    void Grabbing()
    {
        //check if vr interact has a target
        if (interactor.selectTarget)
        {
            if (mHeldObjects == null || !mHeldObjects.Contains(interactor.selectTarget.gameObject))
            {
                mHeldObjects.Add(interactor.selectTarget.gameObject);
                Debug.Log("Added " + interactor.selectTarget.gameObject.tag + " to the list");
                interactor.selectTarget?.GetComponent<InteractableObject>().OnPickUp();             
            }
        }
        else //interactor does not have a target
        {
            if (mHeldObjects != null)
            {
                if (mHeldObjects.Count > 0)
                {
                    if(mHeldObjects[0].GetComponent<InteractableObject>())
                        mHeldObjects[0].GetComponent<InteractableObject>().shouldPlayPickUpSound = true;
                    Debug.Log("removed " + mHeldObjects[0].tag + " from the list");
                    mHeldObjects.Clear();
                }
            }
        }
    }
}
