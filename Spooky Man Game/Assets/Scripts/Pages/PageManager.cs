using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class PageManager : MonoBehaviour
{
    [SerializeField] List<Page> mPages;
    private List<Page> mPagesRemaining;
    private bool mHasSpawnedSlenderMan;
    public event EventHandler OnPagePickUp;

    public delegate void PageCollected();
    public event PageCollected OnPageCollectionEvent;
    public event PageCollected OnCollectedAllPagesEvent;
    private void Awake()
    {
        mHasSpawnedSlenderMan = false;
        mPagesRemaining = new List<Page>(mPages);

        foreach (Page page in mPagesRemaining)
            page.OnPagePickUp += HandlePagePickUp;
    }
    
    public void HandlePagePickUp(Page page)
    {
        Debug.Log("page manager handlepagepickup was called!");
     
        if(!page.mHasBeenCollected)
        {
            RemovePageFromList(page);
            OnPageCollectionEvent?.Invoke();
        }
        Debug.Log(mPagesRemaining.Count + " pages remaining!");
        if (mPagesRemaining.Count == 0)
        {
            OnCollectedAllPagesEvent?.Invoke();
            Debug.Log("collected all pages!");
        }
        page.mHasBeenCollected = true;
           // collectedAllPages?.Invoke();
    }

    private void RemovePageFromList(Page page)
    {
        mPagesRemaining.Remove(page);
    }
}
