#pragma once
#include "GameObj.h"
#include "Ball.h"
#include <deque>

class Player :
    public GameObj
{
public:
    bool IsLive = true;
    int ang = 0;

    Player();
    Player(Vec2 pos, Vec2 size);
    void Up(double del_t);
    void Down(double del_t);


    void Collusion(const std::deque<Ball>& bals);// override;
    bool CheckCollusion(const GameObj& ball) const;// override;
};

