using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class PageManager : MonoBehaviour
{
    [SerializeField] List<Page> mPages;
    private List<Page> mPagesRemaining;
    public event EventHandler OnPagePickUp;
    public delegate void PageCollected();
    public event PageCollected OnPageCollectionEvent;
    public event PageCollected OnCollectedAllPagesEvent;
    private bool mHasCollectedPage;

    private void Awake()
    {
        mPagesRemaining = new List<Page>(mPages);

        foreach (Page page in mPagesRemaining)
            page.OnPagePickUp += HandlePagePickUp;
    }
    
    public void HandlePagePickUp(Page page)
    {
        if(!page.mHasBeenCollected)
        {
            CollectPage(ref page);
            page.mHasBeenCollected = true;
            
        }
        if (mPagesRemaining.Count == 0)
        {
            OnCollectedAllPagesEvent?.Invoke();
        }
    }

    private void CollectPage(ref Page page)
    {
        mHasCollectedPage = true;
        RemovePageFromList(page);
        OnPageCollectionEvent?.Invoke();
    }

    private void RemovePageFromList(Page page)
    {
        mPagesRemaining.Remove(page);
    }
}
