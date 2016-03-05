#include "Particle.h"
#include "Game.h"
#include "Graphics.h"
#include "Texture.h"

Particle::Particle(SDL_Rect* placement, int type, int num, SDL_Point* destination, int life, int speed)
{
	ptNumber = num;
	ptType = type;
	ptRect = *placement;
	if (destination != NULL)
		ptDirection = *destination;
	else
	{
		ptDirection.x = rand() % 18 + (-9);
		ptDirection.y = rand() % 18 + (-9);
	}
	if(life != -1)
		ptLifeSpan = life;
	else
		ptLifeSpan = rand() % 100 + 1;
	if (speed != -1)
		ptSpeed = speed;
	else
		ptSpeed = rand() % 4 + 1;
}

Particle::~Particle()
{

}

void Particle::ptMove()
{
	ptRect.x += ptDirection.x;
	ptRect.y += ptDirection.y;
	if (--ptLifeSpan <= 0)
		Game::destroyParticle(ptNumber);
	else if (ptLifeSpan <= 15)
		ptAlpha -= 17;
}

void Particle::ptRender()
{
	/*
	if (ptFrameWaitCounter <= 0)
		if ((++ptFrame) >= TOTAL_OBJECT_FRAME_TYPES)
			ptFrame = 0;
	*/

	Graphics::particleTextures[ptType][ptFrame]->txRect = ptRect;
	Graphics::particleTextures[ptType][ptFrame]->txAlpha(ptAlpha);
	Graphics::particleTextures[ptType][ptFrame]->txRender();
}

/*
void Particle::ptDestroy()
{
	delete Game::particles[ptNumber];
	Game::particles[ptNumber] = NULL;
}
*/