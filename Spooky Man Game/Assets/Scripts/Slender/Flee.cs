using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Flee : State
{
    public Flee(GameObject npc, NavMeshAgent agent, Animator animator, GameObject player, SlenderUtility utility, SlenderAudio audio)
          : base(npc, agent, animator, player, utility, audio)
    {
        currentState = STATE.WATCH;
    }
    public override void Enter()
    {
        animator.SetBool("Fleeing", true);
        animator.SetTrigger("Flee");
        agent.speed = 8;
        audio.PlaySlenderScream();
        agent.isStopped = true;
        base.Enter();

    }
    public override void Update()
    {
        utility.fleeTimer += Time.deltaTime;
       // Debug.Log("flee timer: " + utility.chaseTimer);

        //check if 2.5 second scream animation is over and agent should move again
        if (utility.fleeTimer > 2.5f)
            agent.isStopped = false;
        agent.SetDestination(utility.spawnPoint);

        if (agent.hasPath)
        {
            //check if flee time is up or npc is close to it's spawn point
            if (utility.fleeTimer >= utility.Chase_TIME || Vector3.Distance(npc.transform.position, utility.spawnPoint) < 2)
            {
                Debug.Log("going to respawn state from flee");
                nextState = new Respawn(npc, agent, animator, player, utility, audio);
                currentStage = STAGE.EXIT;
            }
        }
    }

    public override void Exit()
    {
        animator.SetBool("Fleeing", false);
       // animator.SetBool("InPursuit", false);
       // animator.ResetTrigger("Flee");
        utility.fleeTimer = 0.0f;
        audio.StopSlenderScream();
    }
}
