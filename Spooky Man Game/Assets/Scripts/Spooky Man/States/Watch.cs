using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Watch : State
{
    public Watch(GameObject npc, NavMeshAgent agent, Animator animator, GameObject player, SpookyManUtility utility, SpookyManAudio audio)
          : base(npc, agent, animator, player, utility, audio)
    {
        currentState = STATE.WATCH;       
    }
    public override void Enter()
    {
        animator.SetBool("Stalking", true);
        animator.SetBool("BeingLookedAt", true);
        agent.SetDestination(npc.transform.position);
        agent.speed = 0;
        audio.PlaySlenderLookAtSound();
        base.Enter();
    }
    public override void Update()
    {
        utility.beingLookedAtTimer += Time.deltaTime;
        //Debug.Log("watch timer: " + utility.beingLookedAtTimer);
        npc.transform.LookAt(player.transform.position);
        if (Vector3.Distance(npc.transform.position, player.transform.position) < utility.CHASE_DISTANCE)
        {
            Debug.Log("going to chase state from watch 1");
            nextState = new Chase(npc, agent, animator, player, utility, audio);
            currentStage = STAGE.EXIT;
        }
        else if (!BeingLookedAt(npc) || (BeingLookedAt(npc) && Vector3.Distance(npc.transform.position, player.transform.position) > utility.STOP_LOOK_DISTANCE))
        {
            Debug.Log("going to stalk state from watch!");
            nextState = new Stalk(npc, agent, animator, player, utility, audio);
            currentStage = STAGE.EXIT;
        }
        else if(utility.beingLookedAtTimer >= utility.BEING_LOOKED_AT_TIME)
        {
            Debug.Log("going to chase state from watch 2!");
            nextState = new Chase(npc, agent, animator, player, utility, audio);
            currentStage = STAGE.EXIT;
        }      
    }

    public override void Exit()
    {
        audio.StopSlenderLookAtSound();
        animator.SetBool("Stalking", false);
        animator.SetBool("BeingLookedAt", false);
        utility.beingLookedAtTimer = 0.0f;
        audio.StopSlenderLookAtSound();
    }
}
