using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class State
{
    public enum STATE
    {
        RESPAWN, STALK, WATCH, CHASE, FLEE, ATTACK
    };

    public enum STAGE
    {
        ENTER, UPDATE, EXIT
    };

    public STATE currentState;
    protected STAGE currentStage;
    protected GameObject npc;
    protected Animator animator;
    protected GameObject player;
    protected State nextState;
    protected NavMeshAgent agent;
    protected SlenderUtility utility;
    protected SlenderAudio audio;
    public State()
    {
        currentStage = STAGE.ENTER;
    }

    public State(GameObject npc, NavMeshAgent agent, Animator animator, GameObject player, SlenderUtility utility, SlenderAudio audio)
    {
        this.npc = npc;
        this.animator = animator;
        this.player = player;
        this.agent = agent;
        currentStage = STAGE.ENTER;
        this.audio = audio;
        this.utility = utility;
    }

    public virtual void Enter() { currentStage = STAGE.UPDATE; }
    public virtual void Update() { currentStage = STAGE.UPDATE; }
    public virtual void Exit() { currentStage = STAGE.EXIT; }

    public State Process()
    {
        if(currentStage == STAGE.ENTER)
            Enter();
        if(currentStage == STAGE.UPDATE)
            Update();
        if (currentStage == STAGE.EXIT)
        {
           Exit();
            return nextState;
        }
        return this;       
    }

    protected bool BeingLookedAt(GameObject npc)
    {
        Plane[] planes = GeometryUtility.CalculateFrustumPlanes(Camera.main);

        foreach (var plane in planes)
        {
            if (plane.GetDistanceToPoint(npc.transform.position) < 0)
                return false;
        }
        return true;
    }
}
