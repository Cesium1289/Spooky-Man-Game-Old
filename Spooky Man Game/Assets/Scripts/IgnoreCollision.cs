using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IgnoreCollision : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void OnCollisionEnter(Collision  collision)
    {

        if (collision.gameObject.tag == "Object")
        {
            Physics.IgnoreCollision(collision.collider, this.GetComponent<Collider>());
            Debug.Log("COLLIDING WITH AN OBJECT!");
        }

    }
}
