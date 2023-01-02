using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PageCountDisplay :MonoBehaviour
{
    private Text mUiPageCountText;
    [SerializeField] private Canvas mCanvas;
    private int mPagesCollected;
    private void Start()
    {
        mPagesCollected = 0;
        PageManager manager = FindObjectOfType<PageManager>();
        manager.OnPageCollectionEvent += IncreasePagesCollected;
        mUiPageCountText = mCanvas.GetComponentInChildren<Text>();
    }

    public void IncreasePagesCollected()
   {
        Debug.Log("called pagecountdisplay increasepagecollected!");
        mPagesCollected++;
   }

    public void ToggleUi()
    {
        mUiPageCountText.text = mPagesCollected + "/8 Pages Found";
        mCanvas.enabled = true;
    }
    public void DisableUi()
    {
        mCanvas.enabled = false;
    }

}
