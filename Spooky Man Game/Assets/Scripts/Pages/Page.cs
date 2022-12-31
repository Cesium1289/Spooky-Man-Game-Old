using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class Page : InteractableObject
{
    public bool mHasBeenCollected = false;
    public void Update()
    {
        if (mHasBeenCollected)
            mRigidBody.useGravity = true;
    }

    public void CollectPage()
    {
        mRigidBody.isKinematic = false;
        mRigidBody.useGravity = true;
        mHasBeenCollected = true;    
    }
    
    public override void HandlePickUp()
    {
        Debug.Log("Page Handlepick up!");
    }
  
    private void OnTriggerEnter(Collider other)
    {
        Debug.Log(other.gameObject.tag + " entered the page trigger");
    }

    private void OnTriggerExit(Collider other)
    {
        Debug.Log(other.gameObject.tag + " left the page trigger");
    }
}
