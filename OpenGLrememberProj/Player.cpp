#include "Player.h"


Player::Player() : GameObj() {}
Player::Player(Vec2 pos, Vec2 size) : GameObj(pos, size) {}

void Player::Up(double del_t) {
	if (Position.y + del_t <= 15) {
		Position.y += del_t;
	} 
}

void Player::Down(double del_t) {
	if (Position.y - del_t >= -15) {
		Position.y -= del_t;
	}
}

bool Player::CheckCollusion(const GameObj& ball) const {

	bool collisionX = this->Position.x + this->Size.x / 2 > ball.Position.x - ball.Size.x / 2 &&
		this->Position.x - this->Size.x / 2 < ball.Position.x + ball.Size.x / 2;

	bool collisionY = this->Position.y + this->Size.y / 2 > ball.Position.y - ball.Size.y / 2 &&
		this->Position.y - this->Size.y / 2 < ball.Position.y + ball.Size.y / 2;
	return collisionX && collisionY;
}

void Player::Collusion(const std::deque<Ball>& balls) {
	for (const auto& ball : balls) {
		if (this->CheckCollusion(ball)) {
			this->IsLive = false;
		}
	}
}