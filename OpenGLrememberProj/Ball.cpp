#include "Ball.h"
#include <ctime>
#include <random>

Ball::Ball() : GameObj() { Speed = 0; }
Ball::Ball(Vec2 pos, Vec2 size, float speed) : GameObj(pos, size) {
	Speed = speed;
}

Ball Ball::Spawn() {
	std::random_device rd;
	std::mt19937 rand(rd());
	Vec2 Size = Vec2(1.8, 1.8);
	float x = 35;
	float y = rand() % 30;
	y -= 15;

	return Ball(Vec2(x, y), Size, Ball::Speed);
}

bool Ball::IsChecked(std::deque<Ball> balls, Ball tmp) {
	for (auto& ball : balls) {
		if (tmp.Position.x - tmp.Size.x / 2 <= ball.Position.x + ball.Size.x / 2) {
			if (!(tmp.Position.y + tmp.Size.y / 2 > ball.Position.y + ball.Size.y / 2 && tmp.Position.y - tmp.Size.y / 2 > ball.Position.y + ball.Size.y / 2 ||
				tmp.Position.y + tmp.Size.y / 2 < ball.Position.y - ball.Size.y / 2 && tmp.Position.y - tmp.Size.y / 2 < ball.Position.y - ball.Size.y / 2)) {
				return false;
			}
		}
	}
	return true;
}

float Ball::Speed;