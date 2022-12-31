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
 * 
 * 
 * 
 * 
 * 
 * 
 */
public class Slender : MonoBehaviour
{
    //Max amount of time slender man can either stalk, pursue, or run away
    public float time;
    public bool spot;
    [SerializeField] bool spawnAtPlacementLocation;
    const int BEING_LOOKED_AT_TIME = 8;
    const int RESPAWN_TIME = 15;
    const int STALK_TIME = 20;
    const int PURSUIT_TIME = 10;
    const int RUNNING_AWAY_TIME = 10;
    const int PURSUIT_DISTANCE = 35;
    const int STOP_LOOK_DISTANCE = 50;
    [SerializeField] private GameObject player;
    private NavMeshAgent agent;
    private NavMeshPath path;
    private new Camera camera;
    private Animator animator;
    private bool mCanSpawn;
    [SerializeField] private GameObject[] spawnPoints;
    [SerializeField] private GameObject runAwayTarget;
    [SerializeField] private GameObject spawnPoint;
    [SerializeField] private float stalkingTimer;
    [SerializeField] private float runningAwayTimer;
    [SerializeField] private float beingLookedAtTimer;
    [SerializeField] private float pursuitTimer;
    [SerializeField] private float distanceFromPlayer;
    [SerializeField] private bool inPursuit;
    [SerializeField] private bool isStalking;
    [SerializeField] private bool beingLookedAt;
    [SerializeField] private bool runningAway;
    [SerializeField] private AudioSource audioScream;
    [SerializeField] private AudioSource audioLookAt;
    [SerializeField] private AudioSource audioAttack;
    [SerializeField] private AudioSource audioSpawn;
    [SerializeField] private bool isAttacking;


    //  private bool inRangeToAttack;
    // Start is called before the first frame update
    void Awake()
    {
        camera = Camera.main;
        player = GameObject.FindGameObjectWithTag("Player");
        animator = GetComponent<Animator>();
        agent = GetComponent<NavMeshAgent>();
        path = new NavMeshPath();
        mCanSpawn = false;
        spot = false;
        Spawn();
    }

    public void SpawnAroundPlayer()
    {
        Vector3 randomPos;
        bool foundValidSpawn = false;

        do
        {
            randomPos = Random.insideUnitSphere;
            randomPos.Normalize();
            randomPos *= Random.Range(50, 70);
            randomPos += player.transform.position;
            
            
            if (NavMesh.SamplePosition(randomPos, out NavMeshHit hit, 1000, NavMesh.AllAreas)) 
            {
               float distance = Vector3.Distance(player.transform.position, hit.position);
               if(distance < 70 && distance > 50)
                {
                    agent.Warp(hit.position);
                    agent.SetDestination(player.transform.position);
                    agent.CalculatePath(player.transform.position, path);

                    //check if there is a valid path from agent to player
                    if (path.status == NavMeshPathStatus.PathComplete)
                    {
                        foundValidSpawn = true;
                        Debug.Log("Spawning " + distance + " away!");
                    }
                }
            }
        } while (!foundValidSpawn);
    }

    void Update()
    {
        if (mCanSpawn)
        {


            CheckStates();
            PlayLookAtSound();


            //check if slender should respawn
            if ((stalkingTimer > STALK_TIME && !inPursuit && !beingLookedAt && !runningAway && isStalking && !isAttacking)
                || (stalkingTimer > STALK_TIME && distanceFromPlayer > PURSUIT_DISTANCE && !inPursuit && !runningAway && isStalking))
            {
                //Debug.Log("Respawing player from first case");
                Respawn();
            }
            else if (runningAway)
            {
                if (runningAwayTimer > RUNNING_AWAY_TIME)
                {
                   // Debug.Log("running away timer expired after fleeing, respawning");

                    Respawn();
                }
                else if (Vector3.Distance(runAwayTarget.transform.position, transform.position) < 5)
                {
                   // Debug.Log("Returned to spawn point, after fleeing!, respawning now");
                    Respawn();
                }
                else
                {
                   // Debug.Log("fleeing to target  " + runAwayTarget.name);
                    //  if (canMove)
                    FleeToTarget();
                    //else
                    // agent.SetDestination(this.transform.position);

                }

            }
            //check if slender is close enough to the player
            else if (inPursuit && distanceFromPlayer < 1.5 || isAttacking)
            {
                // animator.SetTrigger("Scream");
                //  animator.SetTrigger("Attacking");
                if (!isAttacking)
                {
                    if (!audioScream.isPlaying)
                        audioScream.PlayOneShot(audioScream.clip);
                    else
                    {
                        audioScream.Stop();
                        audioScream.PlayOneShot(audioScream.clip);
                    }
                   // Debug.Log("Within 1.5 units of the player he should be dead. Having slender run away!");
                    animator.SetTrigger("Attacking");
                    animator.SetBool("isAttacking", true);
                    isAttacking = true;
                    //if (canMove)
                    //   FindSpawnPointToRunTowards();
                    //  else
                    //agent.SetDestination(runAwayTarget.transform.position);
                }

            }
            //check if pursuit from slender man should stop
            else if (inPursuit && pursuitTimer > PURSUIT_TIME && !runningAway)
            {
                if (beingLookedAt)
                {
                  //  Debug.Log("Pursut timer is up and being  looked at, running to respawn point!");
                    if (!audioScream.isPlaying)
                        audioScream.PlayOneShot(audioScream.clip);

                    animator.SetTrigger("Flee");

                    FindSpawnPointToRunTowards();

                }

                else
                {
                    //Debug.Log("pursutit timner is up and not being looked at, respawning!");
                    Respawn();
                }

            }
            else if (inPursuit)
            {
                ChasePlayer();
            }
            //check if slender should chase the player
            else if (distanceFromPlayer < PURSUIT_DISTANCE && !runningAway)
            {
                //if the pursuit timer is up and slender man is not being looked at, he should just respawn
                if (pursuitTimer > PURSUIT_TIME && !beingLookedAt)
                {
                  //  Debug.Log("Pursuit timer is up and the playuer is not looking at slender, so he is respawning");
                    Respawn();
                }
                else if (pursuitTimer > PURSUIT_TIME && beingLookedAt)
                {
                    if (!audioScream.isPlaying)
                        audioScream.PlayOneShot(audioScream.clip);
                  //  Debug.Log("Pursuit timer is up and the playuer is looking at slender, so he is finding a place to flee");
                    FindSpawnPointToRunTowards();
                }
                else
                {
                    if (!audioScream.isPlaying)
                        audioScream.PlayOneShot(audioScream.clip);
                    ChasePlayer();
                }

            }
            //check if should stop and look at player or stalk
            else if ((isStalking && !inPursuit && !runningAway) || distanceFromPlayer > PURSUIT_DISTANCE)
            {
                if (beingLookedAt && beingLookedAtTimer > BEING_LOOKED_AT_TIME)
                {
                   // Debug.Log("Player was looking at slender for more than " + BEING_LOOKED_AT_TIME + " chasing them!");
                    if (!audioScream.isPlaying)
                        audioScream.PlayOneShot(audioScream.clip);

                    ChasePlayer();

                }
                else if (beingLookedAt && beingLookedAtTimer < BEING_LOOKED_AT_TIME && distanceFromPlayer <= STOP_LOOK_DISTANCE)
                {

                   // Debug.Log("Looking at player");
                    StopLookAtPlayer();
                }
                else
                {
                    //audio.Stop();
                    StalkPlayer();
                }

            }

            else if (runningAway && runningAwayTimer < RUNNING_AWAY_TIME)
            {
               // Debug.Log("Run toward spawn point!");
                agent.SetDestination(runAwayTarget.transform.position);
                //  else
                // agent.SetDestination(this.transform.position);
            }
            else if (runningAway && runningAwayTimer > RUNNING_AWAY_TIME)
            {
               // Debug.Log("Run away timer expired. Im respawing!");
                Respawn();
            }
            //respawn him it he was unable to do anything
            else
            {
                //Debug.Log("SOMETHING BAD HAPPENED MAKING HIM RESPAWN");
                Respawn();
            }
        }
    }
    
    private void PlayLookAtSound()
    {
        if (beingLookedAt && isStalking && !audioLookAt.isPlaying && distanceFromPlayer <= STOP_LOOK_DISTANCE)
        {
            audioLookAt.PlayOneShot(audioLookAt.clip);
        }

        else if ((isStalking && distanceFromPlayer >= STOP_LOOK_DISTANCE && audioLookAt.isPlaying)
            || (isStalking && audioLookAt.isPlaying && distanceFromPlayer <= STOP_LOOK_DISTANCE && !beingLookedAt)
            || (inPursuit))
        {
            audioLookAt.Stop();
        }
    }

    private void FindSpawnPointToRunTowards()
    {
        //Debug.Log("Finding a spawn point to run toward!");
        agent.SetDestination(this.transform.position);
        animator.SetBool("InPursuit", false);
        animator.SetBool("Stalking", false);
        animator.SetBool("Fleeing", true);
        inPursuit = false;
        runningAway = true;
        runAwayTarget = spawnPoint;
        FleeToTarget();
    }


    void CheckStates()
    {
        //check if player is looking at slenderman
        beingLookedAt = BeingLookedAt();

        distanceFromPlayer = Vector3.Distance(this.transform.position, player.transform.position);

        StalkingTimer();
    }

    //Check if slenderman is being looked at by the player and is within a certain range
    private bool BeingLookedAt()
    {
        Plane[] planes = GeometryUtility.CalculateFrustumPlanes(camera);

        foreach (var plane in planes)
        {
            if (plane.GetDistanceToPoint(this.transform.position) < 0)
                return false;
        }
        return true;
    }

    private void FleeToTarget()
    {
        // Debug.Log(canMove);
        runningAwayTimer += Time.deltaTime;

        if (runningAwayTimer > 2.5f)
        {
            agent.speed = 10f;
            agent.SetDestination(runAwayTarget.transform.position);
        }
        else
            agent.SetDestination(this.transform.position);
    }

    private void StalkPlayer()
    {
        animator.SetBool("InPursuit", false);
        animator.SetBool("Stalking", true);
        animator.SetBool("Fleeing", false);
        stalkingTimer += Time.deltaTime;
        isStalking = true;
        agent.SetDestination(player.transform.position);
        agent.speed = 5f;
        beingLookedAtTimer = 0.0f;
    }

    private void StopLookAtPlayer()
    {
        animator.SetBool("InPursuit", false);
        animator.SetBool("Stalking", true);
        animator.SetBool("Fleeing", false);
        animator.SetBool("BeingLookedAt", true);
        beingLookedAtTimer += Time.deltaTime;
        agent.SetDestination(this.transform.position);
        agent.speed = 0;
    }


    private void ChasePlayer()
    {
        animator.SetBool("InPursuit", true);
        animator.SetBool("Stalking", false);
        animator.SetBool("Fleeing", false);
        //Debug.Log("Chasing");

        pursuitTimer += Time.deltaTime;
        inPursuit = true;
        isStalking = false;
        if (pursuitTimer > 2.5f)
        {
            agent.speed = 8;
            agent.SetDestination(player.transform.position);
        }
        else
            agent.SetDestination(this.transform.position);


    }
    private void StalkingTimer()
    {
        if (isStalking && !beingLookedAt && !inPursuit && !runningAway)
            stalkingTimer += Time.deltaTime;
    }

    //Find a place to spawn that is near the player. WIll 
    //spawn closer if the player has collected more pages
    private void Respawn()
    {
        stalkingTimer = 0.0f;
        runningAwayTimer = 0.0f;
        beingLookedAtTimer = 0.0f;
        pursuitTimer = 0.0f;
        distanceFromPlayer = 0.0f;
        agent.speed = 5;
        inPursuit = false;
        isStalking = false;
        beingLookedAt = false;
        runningAway = false;
       // canMove = true;
        isAttacking = false;
        //reset animator values
        animator.SetBool("InPursuit", false);
        animator.SetBool("Stalking", false);
        animator.SetBool("BeingLookedAt", false);
        animator.SetBool("Fleeing", false);
        animator.SetBool("isAttacking", false);

        SpawnAroundPlayer();
    }

    public void Spawn()
    {
        audioSpawn.PlayOneShot(audioSpawn.clip);
        mCanSpawn = true;
        stalkingTimer = 0.0f;
        runningAwayTimer = 0.0f;
        beingLookedAtTimer = 0.0f;
        pursuitTimer = 0.0f;
        agent.speed = 5;
        distanceFromPlayer = 0.0f;
        inPursuit = false;
        isStalking = false;
        beingLookedAt = false;
        runningAway = false;
        isAttacking = false;
        animator.SetBool("isAttacking", false);
        animator.SetBool("InPursuit", false);
        animator.SetBool("Stalking", false);
        animator.SetBool("BeingLookedAt", false);
        animator.SetBool("Fleeing", false);

        SpawnAroundPlayer();
    }

    
    private void OnTriggerEnter(Collider other)
    {
        // Debug.Log("TRIGGER HAPPENED");
        if (other.tag == "Throwable" && isAttacking && !other.GetComponent<Rigidbody>().IsSleeping())
        {
            
            // Debug.Log("Pursut timer is up and being  looked at, running to respawn point!");
            if (!audioScream.isPlaying)
                audioScream.PlayOneShot(audioScream.clip);
            if(other.GetComponent<PlayBreakNoise>())
                other.GetComponent<PlayBreakNoise>().PlaySound();
            other.gameObject.SetActive(false);
            animator.SetTrigger("Flee");
           
            FindSpawnPointToRunTowards();
           
        }

    }

    public bool CanSpawn()
    {
        return mCanSpawn;
    }

    private void PlayAttackSound()
    {
        audioAttack.PlayOneShot(audioAttack.clip);
    }

    [System.Obsolete]
    private void ResetScene()
    {
        Application.LoadLevel(Application.loadedLevel);
    }
    
}
