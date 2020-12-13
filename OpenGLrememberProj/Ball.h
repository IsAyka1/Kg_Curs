#pragma once
#include "GameObj.h"
#include <deque>
class Ball :
    public GameObj
{
public:
    static float Speed;

    Ball(Vec2 pos, Vec2 size, float speed);
    Ball();
    static Ball Spawn();
    static bool IsChecked(std::deque<Ball> balls, Ball tmp);
};

