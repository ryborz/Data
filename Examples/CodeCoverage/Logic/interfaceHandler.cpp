/*
 * interfaceHandler.cpp
 *
 *  Created on: 22 lip 2014
 *  Author: Filip Ryborz
 *  Website: simply-embedded.blogspot.com
 */

#include "interfaceHandler.hpp"

cInterfaceHandler :: cInterfaceHandler()
{

}

int cInterfaceHandler :: getFrame()
{
	int ret = serialPort.getData();

	return ret;
}

void cInterfaceHandler :: sendFrame(int f)
{
	if (getFrame() != 0)
	{
		serialPort.setData(f);
	}
}
