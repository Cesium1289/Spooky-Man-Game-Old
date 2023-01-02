
using UnityEngine;
using UnityEngine.UI;

public class FPSDisplay : MonoBehaviour
{
    // Start is called before the first frame update
   
    Text fpsText;
    public int refreshRate = 10;
    public float frameCounter;
    float totalTime;
    void Start()
    {
        fpsText = GetComponent<Text>();
        frameCounter = 0;
        totalTime = 0;
    }

    // Update is called once per frame
    void Update()
    {
        if (frameCounter == refreshRate)
        {
            float averageFPS = (1.0f / (totalTime / refreshRate));
            fpsText.text = averageFPS.ToString("F1");
            frameCounter = 0;
            totalTime = 0;
        }
        else
        {
            totalTime += Time.deltaTime;
            frameCounter++;
        }
    }
}
