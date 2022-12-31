using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[RequireComponent(typeof(AudioSource))]
public class PageCount : MonoBehaviour
{
    new public AudioSource audio;
    [SerializeField] private GameObject[] slender;
    public int pageCount = 0;
    private void awake()
    {
        Debug.Log("THE AWAKENING");
       
        audio = GetComponent<AudioSource>();
    }
  
    public void IncreasePageCount()
    {
      //  Debug.Log("IN THE INCREASE PAGE COUNT");
      
        slender = GameObject.FindGameObjectsWithTag("Slender");
        if(slender !=null)
        {
            if (!slender[0].GetComponent<Slender>().CanSpawn())
            {
                for (int i = 0; i < slender.Length; i++)
                    slender[i].GetComponent<Slender>().Spawn();
            }
        }
        
      
        
        ++pageCount;
        CheckIfAllPages();
    }
    public int GetPageCount()
    {
        return pageCount;
    }

    private void CheckIfAllPages()
    {
        if (pageCount == 8)
            audio.Play();
    }
}
