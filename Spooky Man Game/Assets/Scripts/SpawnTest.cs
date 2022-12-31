using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnTest : MonoBehaviour
{
    [SerializeField] private GameObject player;
    // Start is called before the first frame update
    void Start()
    {
        player = GameObject.FindGameObjectWithTag("Player");
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    /*
     *   if (NavMesh.SamplePosition(randomPos, out hit, 1000, NavMesh.AllAreas)) 
            {
                float distance = Vector3.Distance(player.transform.position, hit.position);
                agent.CalculatePath(player.transform.position, path);
                //if (path.status != NavMeshPathStatus.PathComplete)
                //  spot = true;
               // if (distance < 70 && distance > 50)
                 if (distance < 70 && distance > 50 && path.status == NavMeshPathStatus.PathComplete)
                {
                    agent.Warp(hit.position);
                    agent.SetDestination(player.transform.position);
                    agent.CalculatePath(player.transform.position, path);
                    notFound = false;
                }
              
            }*/


    /*
     *  NavMeshHit hit;
        Vector3 randomPos;
        Vector3 spawnLocation;
        NavMeshPath path = new NavMeshPath();
        bool notFound = true;
        if (spot)
            return;
        do
        {
            randomPos = Random.insideUnitSphere;
            randomPos.Normalize();
            randomPos *= Random.Range(50, 70);
            randomPos += player.transform.position;
           
            
            if (NavMesh.SamplePosition(randomPos, out hit, 1000, NavMesh.AllAreas)) 
            {
                float distance = Vector3.Distance(player.transform.position, hit.position);
                agent.CalculatePath(player.transform.position, path);
                if (distance < 70 && distance > 50 && path.status == NavMeshPathStatus.PathComplete)
                {
                    agent.Warp(hit.position);
                    agent.SetDestination(player.transform.position);
                    agent.CalculatePath(player.transform.position, path);
                    if (path.status != NavMeshPathStatus.PathComplete)
                    {
                        Debug.Log("FOUND INVALID PATH!");
                        spot = true;
                    }

                   
                   // Debug.Log("distance: " +  Vector3.Distance(player.transform.position, transform.position));
                    //Debug.Log(distance < 70 && distance > 50);
                    notFound = false;
                }
                else 
                {
                  //  Debug.Log("Resampleing position! : " + distance);
                }
                // Debug.DrawRay(spawnLocation, Vector3.up, Color.green);
                // transform.position = spawnLocation;
            }
            else
            {
                Debug.DrawRay(randomPos, Vector3.up, Color.red);
            }
        } while (notFound);
    }
     */
}
