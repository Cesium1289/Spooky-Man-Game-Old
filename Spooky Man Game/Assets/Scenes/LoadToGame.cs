using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class LoadToGame : MonoBehaviour
{
    [SerializeField] public Text text;
  public void Awake()
    {
       // Debug.Log("Am awake loading scene");
       
       // SceneManager.LoadSceneAsync("SampleScene");
        
    }

    public void LoadLevel()
    {
        //SceneManager.LoadScene("SampleScene");
        StartCoroutine(LoadScene());
    }

    IEnumerator LoadScene()
    {
        yield return null;

        AsyncOperation asyncOperation = SceneManager.LoadSceneAsync("SampleScene");

        while(!asyncOperation.isDone)
        {
            text.text = "Loading progress: " + (asyncOperation.progress * 100) + "%";
        }
        yield return null;
    }
}
