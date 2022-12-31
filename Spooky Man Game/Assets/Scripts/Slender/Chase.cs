using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Chase : State
{
    public Chase(GameObject npc, NavMeshAgent agent, Animator animator, GameObject player, SlenderUtility utility, SlenderAudio audio)
          : base(npc, agent, animator, player, utility, audio)
    {
        currentState = STATE.WATCH;
    }
    public override void Enter()
    {
        animator.SetBool("InPursuit", true);
        
        agent.speed = 8;
        audio.PlaySlenderScream();
        agent.isStopped = true;
        base.Enter();
     
    }
    public override void Update()
    {
        utility.chaseTimer += Time.deltaTime;
       // Debug.Log("chase timer: " + utility.chaseTimer);

        //check if 2.5 second scream animation is over and agent should move again
        if (utility.chaseTimer > 2.5f)
            agent.isStopped = false;
        agent.SetDestination(player.transform.position);

        if (agent.hasPath)
        {
            if(Vector3.Distance(npc.transform.position, player.transform.position) <= utility.ATTACK_DISTANCE)
            {
                Debug.Log("going to attack state from chase");
                nextState = new Attack(npc, agent, animator, player, utility, audio);
                currentStage = STAGE.EXIT;
            }
            else if(utility.chaseTimer >= utility.Chase_TIME)
            {
                if(BeingLookedAt(npc))
                {
                    Debug.Log("going to flee state from chase");
                    nextState = new Flee(npc, agent, animator, player, utility, audio);
                    currentStage = STAGE.EXIT;
                }
                else
                {
                    Debug.Log("going to respawn state from chase");
                    nextState = new Respawn(npc, agent, animator, player, utility, audio);
                    currentStage = STAGE.EXIT;
                }              
            }
        }
    }

    public override void Exit()
    {
        animator.SetBool("InPursuit", false);
        utility.chaseTimer = 0.0f;
        audio.StopSlenderScream();
    }
}
