#pragma once
#include "Vec2.h"
#include "ObjLoader.h"
#include <vector>

class GameObj
{
public:
	Vec2 Position;
	Vec2 Size;

	GameObj();
	GameObj(Vec2 pos, Vec2 size);
	//virtual void Collusion(const std::vector<GameObj>& bals) = 0;
	//virtual bool CheckCollusion(const GameObj& ball) const = 0;
};

