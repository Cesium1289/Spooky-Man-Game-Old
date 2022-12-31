using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class PageManager : MonoBehaviour
{
    [SerializeField] List<GameObject> mPagesRemaining;
    [SerializeField] AudioSource mCollectPage;
    [SerializeField] AudioSource mCollectedAllPages;
    [SerializeField] UnityEvent OnCompleteEvent;
    [SerializeField] UnityEvent SpawnSlender;
    public int mPagesCollected;


    // Start is called before the first frame update
    private void Awake()
    {
        mPagesCollected = 0;
    }
    
    public void HandlePagePickUp(GameObject obj)
    {
        if(obj.CompareTag("Page"))
        {
            SpawnSlender.Invoke();

            if (mPagesRemaining.Remove(obj))
                ++mPagesCollected;

           // if(obj.GetComponent<Page>())
                obj.GetComponent<Page>()?.CollectPage();

            if (mPagesRemaining.Count == 0)
                OnCompleteEvent.Invoke();
        }
       
    }

    public void RemovePageFromList(GameObject page)
    {
        if(!page.CompareTag("Page"))
        {
            Debug.Log("Attempted to remove a non-page game object from page list!");
            return;
        }
        /*
        for (int i = 0; i < mPages.Count; i++)
        {
            if (page == mPages[i])
            {
                Debug.Log("Removed page " + mPages[i] + " from the list!");
                mPages.RemoveAt(i);
                i = mPages.Count;
                removed = true;
            }
        }*/

       
    }
}
