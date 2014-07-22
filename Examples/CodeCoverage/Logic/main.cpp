/*
 * main.cpp
 *
 *  Created on: 22 lip 2014
 *  Author: Filip Ryborz
 *  Website: simply-embedded.blogspot.com
 */

#include "main.hpp"
#include "interfaceHandler.hpp"

cInterfaceHandler interfaceHandler;

int main()
{

	interfaceHandler.sendFrame(5);

	return 0;
}
