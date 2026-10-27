#ifndef TEXTURE_H
#define TEXTURE_H

#include <string>
#include <windows.h>
#include <GL/gl.h>

class Texture
{
public: 
	~Texture();

	unsigned int texId;

	void loadTextureFromFile(const char* filename);
	void deleteTexture();

	void bindTexture();
	
	static int LoadBMP(LPCSTR  filename, int* Wigth, int *Height, RGBTRIPLE **arr);
	static int RGBtoChar(RGBTRIPLE *arr, int width, int height, char **out);
};


#endif //TEXTURE_H