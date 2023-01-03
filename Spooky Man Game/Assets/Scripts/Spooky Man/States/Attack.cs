using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Attack : State
{
    private readonly NavMeshPath path;
    public Attack(GameObject npc, NavMeshAgent agent, Animator animator, GameObject player, SpookyManUtility utility, SpookyManAudio audio)
          : base(npc, agent, animator, player, utility, audio)
    {

        currentState = STATE.WATCH;
        path = new NavMeshPath();
    }

    public override void Enter()
    {
        animator.SetTrigger("Attacking");
        animator.SetBool("isAttacking", true);
        audio.PlaySlenderScream();
        base.Enter();
    }

    public override void Update()
    {
        utility.attackTimer += Time.deltaTime;

        if (utility.attackTimer > 2.5f)
            audio.PlaySlenderAttackSound();
        if (utility.attackTimer >= utility.ATTACK_TIMER)
        {
            Debug.Log("going to stalk state from respawn!");
            nextState = new Respawn(npc, agent, animator, player, utility, audio);
            currentStage = STAGE.EXIT;
        }
      

    }

    public override void Exit()
    {
        ResetScene();
    }

    [System.Obsolete]
    private void ResetScene()
    {
        Application.LoadLevel(Application.loadedLevel);
    }

}
