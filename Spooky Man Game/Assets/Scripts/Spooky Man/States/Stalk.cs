using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Stalk : State
{
    public Stalk(GameObject npc, NavMeshAgent agent, Animator animator, GameObject player, SpookyManUtility utility, SpookyManAudio audio)
        : base(npc, agent, animator, player,utility, audio)
    {
        currentState = STATE.STALK;
    }

    public override void Enter()
    {   
        animator.SetBool("Stalking", true);      
        agent.speed = 5f;
        base.Enter();
    }

    public override void Update()
    {
        utility.stalkingTimer += Time.deltaTime;
        agent.SetDestination(player.transform.position);
      //  Debug.Log("stalking timer: " + utility.stalkingTimer);

        if(agent.hasPath)
        {
            if(Vector3.Distance(npc.transform.position, player.transform.position) < utility.CHASE_DISTANCE)
            {
                Debug.Log("going to chase state from stalk");
                nextState = new Chase(npc, agent, animator, player, utility, audio);
                currentStage = STAGE.EXIT;
            }
            else if (BeingLookedAt(npc) && Vector3.Distance(npc.transform.position, player.transform.position) < utility.STOP_LOOK_DISTANCE)
            {
                Debug.Log("going to Watch state from stalk");
                nextState = new Watch(npc, agent, animator, player, utility, audio);
                currentStage = STAGE.EXIT;
            }
            else if (utility.stalkingTimer >= utility.STALK_TIME)
            {
                Debug.Log("going to respawn state from stalk");
                nextState = new Respawn(npc, agent, animator, player, utility, audio);
                currentStage = STAGE.EXIT;
            }
        }
        
    }
    
    public override void Exit()
    {
        animator.SetBool("Stalking", false);
        utility.stalkingTimer = 0.0f;
    }
 
}
