using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/*The file contians all the timer associated with slender man such as:
 * 
 * 
 * 
 * 
 */
public class SpookyManUtility : MonoBehaviour
{
    public readonly int BEING_LOOKED_AT_TIME = 8;
    public readonly int STOP_LOOK_DISTANCE = 50;
    public readonly int Chase_TIME = 10;
    public readonly int RUNNING_AWAY_TIME = 10;
    public readonly int STALK_TIME = 20;
    public readonly int CHASE_DISTANCE = 35;
    public readonly int ATTACK_TIMER = 5;
    public readonly float ATTACK_DISTANCE = 1.5f;
    public float stalkingTimer;
    public float chaseTimer;
    public float fleeTimer;
    public float beingLookedAtTimer;
    public float attackTimer;
    public Vector3 spawnPoint;

    
}
