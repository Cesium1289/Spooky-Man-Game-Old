using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
/*Documentation of what the slenderman AI should do
 * He should spawn at preset gameobjects that are labeled as "Spawn Point"
 * He will stalk the player and head towards them
 * If the player is <= chasing range, slender man will chase after the player
 * If he does not get the player, within the pursuit timer he will respawn at a point if the player is not
 * looking at him, or will turn around and find a spawn location to run toward in order to get out of sight of the player and 
 * will respawn either when he reaches his target, or if 10 seconds has past.
 */
[RequireComponent(typeof(SpookyManAudio))]
[RequireComponent (typeof(State))]
[RequireComponent(typeof(SpookyManUtility))]
public class SpookyMan : MonoBehaviour
{
    [SerializeField] private GameObject player;
    private NavMeshAgent agent;
    private Animator animator;
    [SerializeField] private bool isAttacking;
    private new SpookyManAudio audio;
    private State currentState;
    private SpookyManUtility utility;

    void Awake()
    {    
        player = GameObject.FindGameObjectWithTag("Player");
        animator = GetComponent<Animator>();
        agent = GetComponent<NavMeshAgent>();   
        audio = GetComponent<SpookyManAudio>();
        utility = GetComponent<SpookyManUtility>();
        currentState = new Respawn(this.gameObject, agent, animator, player, utility, audio);
        audio.PlaySlenderSpawnSound();
    }
    void Update()
    {
        currentState = currentState.Process();
    }  
    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Throwable"  && currentState.ToString() == "Chase" && !other.GetComponent<Rigidbody>().IsSleeping())
        {
            currentState.Exit();
            currentState = new Flee(this.gameObject, agent, animator, player, utility, audio);
                     
            if (other.GetComponent<PlayBreakNoise>())
                other.GetComponent<PlayBreakNoise>().PlaySound();
            other.gameObject.SetActive(false);
        }
    }

    [System.Obsolete]
    private void ResetScene()
    {
        Application.LoadLevel(Application.loadedLevel);
    }   
}