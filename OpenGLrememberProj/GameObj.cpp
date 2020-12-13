#include "GameObj.h"
#include "Vec2.h"
#include "MyOGL.h"
using std::string;

GameObj::GameObj() {
	Position = Vec2(0, 0);
}

GameObj::GameObj(Vec2 pos, Vec2 size) : Position(pos), Size(size) {
}
